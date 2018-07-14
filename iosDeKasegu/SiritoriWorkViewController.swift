//
//  SiritoriWorkViewController.swift
//  iosDeKasegu
//
//  Created by 高木広大 on 2018/07/01.
//  Copyright © 2018年 shonanhiratsuka. All rights reserved.
//

import UIKit
import GoogleMobileAds

// XXX: 別々の配列じゃなくて構造体とかにするべき、おそらく
var keywordArray:[UITextField] = []
var IdeaArray:[UITextView] = []

class SiritoriWorkViewController: BaseViewController {
    let firstWord = "アイデア"
    var bannerView: GADBannerView!
    let scrollView = UIScrollView()

    // キーボードを下げる
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let index = keywordArray.count
        
// XXX: CGRectのパラメータを数値でなく、画面の幅の半分とかにしないと別の機器で表示が崩れる、多分
        scrollView.backgroundColor = UIColor.gray
        scrollView.keyboardDismissMode = .onDrag
        // 表示窓のサイズと位置を設定
        let scrollFrame = CGRect(x:0 , y:110 , width:view.frame.width, height:view.frame.height-20)
        scrollView.frame = scrollFrame
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height-20+CGFloat(140*index))

        // しりとりのテーマを読込んで表示
        let themeLabel = UILabel()
        themeLabel.frame = CGRect(x:0, y:60, width:view.frame.width, height:50)
        themeLabel.numberOfLines = 0
        
        themeLabel.text = "★テーマ★\n　　　　" + UserDefaults.standard.string(forKey: "SiritoriTheme")!
        themeLabel.textColor = UIColor.white
        themeLabel.backgroundColor = UIColor.blue
        view.addSubview(themeLabel)

        // しりとりの最初のワードを設定・表示
        let contentsView = UIView()
        contentsView.frame = CGRect(x:20, y:10, width:Int(view.frame.width-CGFloat(40)), height:90)
        contentsView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.6, alpha: 1.0)
            // 説明
        let firstWordLabel = UILabel()
        firstWordLabel.frame = CGRect(x:10, y:5, width:contentsView.frame.width-20, height:30)
        firstWordLabel.text = "しりとりの最初のフレーズ"
        firstWordLabel.textColor = UIColor.black
        contentsView.addSubview(firstWordLabel)
            // 最初のワード
        let firstWordField = UITextField(frame: CGRect(x: 10, y:40, width:140, height:30))
        firstWordField.borderStyle = UITextBorderStyle.roundedRect
        firstWordField.text = firstWord
        contentsView.addSubview(firstWordField)

        scrollView.addSubview(contentsView)
        
        // キーワード+アイデアのコンテンツを作成, すでにあれば表示だけする
        if (index == 0) {
            createContentsView(ArrayIndex: 0)
        } else {
            for i in 0..<index {
                loadContentsView(ArrayIndex: i)
            }
        }
        
        // ボタンの追加
        addNextButton()
        
        // スクロールビューをビューに追加
        self.view.addSubview(scrollView)
        
        // 広告の表示
        displayAdvertisement()
        
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
        
        // キーワードが入力されていなかったらアラートを出す
        if (keywordArray[index-1].text?.isEmpty)! {
            print("hoge")
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
            alert.title = "Ops!!"
            alert.message = "please input a keyword!"
            alert.addAction(UIAlertAction(
                title: "back",
                style: .default
                )
            )
            self.present(alert, animated: true)
            return
        }
        
        // キーワード+アイデアを作成
        createContentsView(ArrayIndex: Int(index))
        // ボタンを下げる
        button.frame = CGRect(x:300, y:y_field+120, width:50, height:25)
        // スクロールビューのサイズを更新
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + CGFloat(y_new))
        // 中心を変更する
        scrollView.setContentOffset(CGPoint(x: 0, y: y_field-200), animated: true)
    }
    
    
    func loadContentsView(ArrayIndex: Int) {
        let y_new = ArrayIndex*140
        let y_field = 120 + y_new
        
        // キーワード + アイデアのUIViewの作成
        let contentsView = UIView()
        contentsView.frame = CGRect(x:20, y:y_field, width:Int(view.frame.width-CGFloat(40)), height:120)
        contentsView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.6, alpha: 1.0)
        
        // キーワードのラベルを追加
        let keywordLabel = UILabel()
        keywordLabel.frame = CGRect(x:10, y:5, width:140, height:30)
        keywordLabel.numberOfLines = 0
        keywordLabel.text = "キーワード"+String(ArrayIndex+1)
        keywordLabel.textColor = UIColor.black
        contentsView.addSubview(keywordLabel)
        
        // キーワードフィールドの追加
        contentsView.addSubview(keywordArray[ArrayIndex])
        
        // アイデアのラベルを追加
        let IdeaLabel = UILabel()
        IdeaLabel.frame = CGRect(x:160, y:5, width:160, height:30)
        IdeaLabel.numberOfLines = 0
        IdeaLabel.text = "アイデア"+String(ArrayIndex+1)
        IdeaLabel.textColor = UIColor.black
        contentsView.addSubview(IdeaLabel)
        
        // アイデアフィールドの追加
        contentsView.addSubview(IdeaArray[ArrayIndex])
        
        // スクロールビューに追加
        scrollView.addSubview(contentsView)
    }
    
    func createContentsView(ArrayIndex: Int) {
        let y_new = ArrayIndex*140
        let y_field = 120 + y_new
        
        // キーワード + アイデアのUIViewの作成
        let contentsView = UIView()
        contentsView.frame = CGRect(x:20, y:y_field, width:Int(view.frame.width-CGFloat(40)), height:120)
        contentsView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.6, alpha: 1.0)
        
        // キーワードのラベルを追加
        let keywordLabel = UILabel()
        keywordLabel.frame = CGRect(x:10, y:5, width:140, height:30)
        keywordLabel.numberOfLines = 0
        keywordLabel.text = "キーワード"+String(ArrayIndex+1)
        keywordLabel.textColor = UIColor.black
        contentsView.addSubview(keywordLabel)
        
        // キーワードフィールドの追加
        let keywordField: UITextField = UITextField(frame: CGRect(x: 10, y:40, width:140, height:30))
        keywordField.delegate = self as? UITextFieldDelegate
        keywordField.borderStyle = UITextBorderStyle.roundedRect
        keywordArray.append(keywordField)
        if (ArrayIndex == 0) {
            keywordField.placeholder = firstWord+"→ ..."
        } else {
            keywordField.placeholder = keywordArray[ArrayIndex-1].text!+"→ ..."
        }
        contentsView.addSubview(keywordField)
        
        // アイデアのラベルを追加
        let IdeaLabel = UILabel()
        IdeaLabel.frame = CGRect(x:160, y:5, width:160, height:30)
        IdeaLabel.numberOfLines = 0
        IdeaLabel.text = "アイデア"+String(ArrayIndex+1)
        IdeaLabel.textColor = UIColor.black
        contentsView.addSubview(IdeaLabel)
        
        // アイデアフィールドの追加
        let IdeaField: UITextView = UITextView(frame: CGRect(x: 160, y:40, width:160, height:60))
        IdeaField.layer.borderWidth = 1
        IdeaField.layer.cornerRadius = 5
        IdeaField.layer.borderColor = UIColor.lightGray.cgColor
        IdeaArray.append(IdeaField)
        contentsView.addSubview(IdeaField)
        
        // スクロールビューに追加
        scrollView.addSubview(contentsView)
    }
    
    func addNextButton() {
        var index = keywordArray.count // indexの更新
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.layer.borderWidth = 2.0 // 枠線の幅
        button.layer.borderColor = UIColor.red.cgColor // 枠線の色
        button.layer.cornerRadius = 10.0
        button.setTitle("次へ", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.frame = CGRect(x: 300, y: 140*(index)+100, width: 50, height: 25)
        button.addTarget(self, action: #selector(self.onClick(_:)), for: .touchUpInside)
        scrollView.addSubview(button)
    }
    
    func displayAdvertisement() {
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = admob_id
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        addBannerViewToView(bannerView)
    }
    
    public func resetContents() {
        keywordArray.removeAll()
        IdeaArray.removeAll()
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
