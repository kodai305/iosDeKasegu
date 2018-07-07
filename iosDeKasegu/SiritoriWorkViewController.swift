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
// XXX: CGRectのパラメータを数値でなく、画面の幅の半分とかにしないと別の機器で表示が崩れる、多分
        scrollView.backgroundColor = UIColor.gray
        scrollView.keyboardDismissMode = .onDrag
        // 表示窓のサイズと位置を設定
        let scrollFrame = CGRect(x:0 , y:110 , width:view.frame.width, height:view.frame.height-20)
        scrollView.frame = scrollFrame
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height-20)

        // siritoriのテーマを読込んで表示
        let themeLabel = UILabel()
        themeLabel.frame = CGRect(x:0, y:60, width:view.frame.width, height:50)
        themeLabel.numberOfLines = 0
        themeLabel.text = "★テーマ★\n　　　　" + siritoriTheme
        themeLabel.textColor = UIColor.white
        themeLabel.backgroundColor = UIColor.blue
        view.addSubview(themeLabel)

        // キーワード+アイデアのコンテンツを作成
        createContentsView()

        // ボタンの追加
        let button = UIButton()
        button.setTitle("次へ", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.frame = CGRect(x: 300, y: 250, width: 50, height: 50)
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
        let y_new = index*140
        let y_field = 120 + y_new
        
        // キーワード+アイデアを作成
        createContentsView()
        
        // ボタンを下げる
        button.frame = CGRect(x:300, y:y_field+120, width:50, height:50)

        // スクロールビューのサイズを更新
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + CGFloat(y_new))

        // 中心を変更する
        scrollView.setContentOffset(CGPoint(x: 0, y: y_field-120), animated: true)
        
    }
    
    func createContentsView() {
        let index = keywordArray.count
        let y_new = index*140
        let y_field = 120 + y_new
        
        // キーワード + アイデアのUIViewの作成
        let contentsView = UIView()
        contentsView.frame = CGRect(x:20, y:y_field, width:Int(view.frame.width-CGFloat(40)), height:120)
        contentsView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.6, alpha: 1.0)
        
        // キーワードのラベルを追加
        let keywordLabel = UILabel()
        keywordLabel.frame = CGRect(x:10, y:5, width:80, height:30)
        keywordLabel.numberOfLines = 0
        keywordLabel.text = "キーワード"
        keywordLabel.textColor = UIColor.black
        contentsView.addSubview(keywordLabel)
        
        // キーワードフィールドの追加
        let keywordField: UITextField = UITextField(frame: CGRect(x: 10, y:40, width:100, height:30))
        keywordField.borderStyle = UITextBorderStyle.roundedRect
        keywordArray.append(keywordField)
        contentsView.addSubview(keywordField)
        
        // キーワードのラベルを追加
        let IdeaLabel = UILabel()
        IdeaLabel.frame = CGRect(x:120, y:5, width:80, height:30)
        IdeaLabel.numberOfLines = 0
        IdeaLabel.text = "アイデア"
        IdeaLabel.textColor = UIColor.black
        contentsView.addSubview(IdeaLabel)
        
        // アイデアフィールドの追加
        let IdeaField: UITextView = UITextView(frame: CGRect(x: 120, y:40, width:160, height:60))
        IdeaField.layer.borderWidth = 1
        IdeaField.layer.cornerRadius = 5
        IdeaField.layer.borderColor = UIColor.lightGray.cgColor
        IdeaArray.append(IdeaField)
        contentsView.addSubview(IdeaField)
        
        // スクロールビューに追加
        scrollView.addSubview(contentsView)
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
