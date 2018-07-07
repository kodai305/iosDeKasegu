//
//  SiritoriWorkViewController.swift
//  iosDeKasegu
//
//  Created by 高木広大 on 2018/07/01.
//  Copyright © 2018年 shonanhiratsuka. All rights reserved.
//

import UIKit
import GoogleMobileAds

class SiritoriWorkViewController: BaseViewController {
    var bannerView: GADBannerView!
    let scrollView = UIScrollView()

    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    // XXX: 別々の配列じゃなくて構造体とかにするべき、おそらく
    var keywordArray:[UITextField] = []
    var IdeaArray:[UITextView] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.backgroundColor = UIColor.gray
        scrollView.keyboardDismissMode = .onDrag
        // 表示窓のサイズと位置を設定
        let scrollFrame = CGRect(x: 0, y: 20, width: view.frame.width, height: view.frame.height-20)
        scrollView.frame = scrollFrame
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height-20)

        // XXX: CGRectのパラメータを数値でなく、画面の幅の半分とかにしないと別の機器で表示が崩れる、多分
        
        // siritoriのテーマを読込んで表示
        let themeLabel = UILabel()
        themeLabel.frame = CGRect(x:50, y:80, width:300, height:80)
        themeLabel.numberOfLines = 0
        themeLabel.text = "★テーマ★\n　　　　" + siritoriTheme
        themeLabel.backgroundColor = UIColor.gray
        self.scrollView.addSubview(themeLabel)

        // キーワード入力用
        let firstKeyword: UITextField = UITextField(frame: CGRect(x: 10, y:200, width:100, height:30))
        firstKeyword.borderStyle = UITextBorderStyle.roundedRect
        keywordArray.append(firstKeyword)
        scrollView.addSubview(firstKeyword)
        
        // アイデア入力用
        let firstIdea: UITextView = UITextView(frame: CGRect(x: 150, y:200, width:200, height:60))
        firstIdea.layer.borderWidth = 1
        firstIdea.layer.cornerRadius = 5
        firstIdea.layer.borderColor = UIColor.lightGray.cgColor
        IdeaArray.append(firstIdea)
        scrollView.addSubview(firstIdea)
        
        // ボタンの追加
        let button = UIButton()
        button.setTitle("次へ", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.frame = CGRect(x: 300, y: 270, width: 50, height: 50)
        button.addTarget(self, action: #selector(self.onClick(_:)), for: .touchUpInside)
        scrollView.addSubview(button)
        
        // スクロールビューをビューに追加
        self.view.addSubview(scrollView)
        
        // To display the advertisement on scrollView
        // スクロールビューの後に追加することで前面に出せる
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = admob_id
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        addBannerViewToView(bannerView)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func onClick(_ sender: AnyObject){
        let button = sender as! UIButton
        let index = keywordArray.count
        let y_new = index*80
        let y_field = 200 + y_new
        // キーワードフィールドの追加
        let keywordField: UITextField = UITextField(frame: CGRect(x: 10, y:y_field, width:100, height:30))
        keywordField.borderStyle = UITextBorderStyle.roundedRect
        keywordArray.append(keywordField)
        scrollView.addSubview(keywordField)
        
        // アイデアフィールドの追加
        let IdeaField: UITextView = UITextView(frame: CGRect(x: 150, y:y_field, width:200, height:60))
        IdeaField.layer.borderWidth = 1
        IdeaField.layer.cornerRadius = 5
        IdeaField.layer.borderColor = UIColor.lightGray.cgColor
        IdeaArray.append(IdeaField)
        scrollView.addSubview(IdeaField)
        
        // ボタンを下げる
        button.frame = CGRect(x:300, y:y_field+50, width:50, height:50)

        // スクロールビューのサイズを更新
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + CGFloat(y_new))
    }
    

    func addBannerViewToScrollView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(bannerView)
        scrollView.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: scrollView,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
