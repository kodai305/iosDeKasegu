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
var KeywordTextViewArray:[UITextField] = []
var IdeaTextViewArray:[UITextView] = []

// 保存用
var IdeaDataArray:[(keyword: String, idea: String)] = []

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

        //保存してある配列の読込
        IdeaDataArray = readData() as! [(keyword: String, idea: String)]
        let index = KeywordTextViewArray.count
        // しりとりのテーマを読込んで表示
        displayTheme()
        // しりとりの最初のワードを設定・表示
        createInitialWord()
        // キーワード+アイデアのコンテンツを作成, すでにあれば表示だけする
        if (index == 0) {
            createContentsView(ArrayIndex: 0)
        } else {
            for i in 0..<index {
                loadContentsView(ArrayIndex: i)
                IdeaDataArray = readData() as! [(keyword: String, idea: String)]
            }
        }
        // ボタンの追加
        addNextButton()
        // スクロールビューを設定・追加
        scrollView.backgroundColor = UIColor.gray
        scrollView.keyboardDismissMode = .onDrag
        scrollView.frame = CGRect(x:0 , y:110 , width:view.frame.width, height:view.frame.height-20)
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height-20+CGFloat(140*index))
        self.view.addSubview(scrollView)
        // 広告の表示
        displayAdvertisement()
    }
    
    // 「次へ」ボタンが押されたときの処理
    @objc func onClick(_ sender: AnyObject){
        let button = sender as! UIButton
        let index = KeywordTextViewArray.count
        let y_new = index*140
        let y_field = 120 + y_new
        
        // キーワードが入力されていなかったらアラートを出す
        print("index:")
        print(index)
        if (KeywordTextViewArray[index-1].text?.isEmpty)! {
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
        // 配列に追加
        var tuple_keyword:String = "-"
        if (KeywordTextViewArray[index-1].text?.isEmpty)! {
            tuple_keyword = KeywordTextViewArray[index-1].text! as String
        }
        var tuple_idea:String = "-"
//        if (IdeaTextViewArray[index-1].text?.isEmpty)! {
//            tuple_idea = IdeaTextViewArray[index-1].text!
//        }
        IdeaDataArray.append((tuple_keyword, tuple_idea))
        print("IdeaData index:")
        print(IdeaDataArray.count)
        // 保存
//        saveData(ideaArray: IdeaDataArray)
        saveData()
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
        // キーワードフィールドの作成・追加
        let keywordField = UITextField(frame: CGRect(x: 10, y:40, width:140, height:30))
        keywordField.borderStyle = UITextBorderStyle.roundedRect
        keywordField.text = IdeaDataArray[ArrayIndex].keyword
        KeywordTextViewArray.append(keywordField)
        contentsView.addSubview(keywordField)
        
        // アイデアのラベルを追加
        let IdeaLabel = UILabel()
        IdeaLabel.frame = CGRect(x:160, y:5, width:160, height:30)
        IdeaLabel.numberOfLines = 0
        IdeaLabel.text = "アイデア"+String(ArrayIndex+1)
        IdeaLabel.textColor = UIColor.black
        contentsView.addSubview(IdeaLabel)
        // アイデアフィールドの作成・追加
        let IdeaView: UITextView = UITextView(frame: CGRect(x: 160, y:40, width:160, height:60))
        IdeaView.layer.borderWidth = 1
        IdeaView.layer.cornerRadius = 5
        IdeaView.layer.borderColor = UIColor.lightGray.cgColor
        IdeaTextViewArray.append(IdeaView)
        contentsView.addSubview(IdeaView)

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
        if (ArrayIndex == 0) {
            keywordField.placeholder = firstWord+"→ ..."
        } else {
            keywordField.placeholder = KeywordTextViewArray[ArrayIndex-1].text!+"→ ..."
        }
        KeywordTextViewArray.append(keywordField)
        contentsView.addSubview(keywordField)
        
        // アイデアのラベルを追加
        let IdeaLabel = UILabel()
        IdeaLabel.frame = CGRect(x:160, y:5, width:160, height:30)
        IdeaLabel.numberOfLines = 0
        IdeaLabel.text = "アイデア"+String(ArrayIndex+1)
        IdeaLabel.textColor = UIColor.black
        contentsView.addSubview(IdeaLabel)
        
        // アイデアビューの追加
        let IdeaView: UITextView = UITextView(frame: CGRect(x: 160, y:40, width:160, height:60))
        IdeaView.layer.borderWidth = 1
        IdeaView.layer.cornerRadius = 5
        IdeaView.layer.borderColor = UIColor.lightGray.cgColor
        IdeaTextViewArray.append(IdeaView)
        contentsView.addSubview(IdeaView)
        
        // スクロールビューに追加
        scrollView.addSubview(contentsView)
    }
    
    func addNextButton() {
        let index = IdeaDataArray.count // indexの更新
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
        IdeaDataArray.removeAll()
        IdeaDataArray.removeAll()
    }

//    func saveData(_: ideaArray) {
    func saveData() {
        let texts: [String] = ["三日月宗近"]
        
        let defaults = UserDefaults.standard
//        defaults.set(IdeaDataArray ,forKey: "Cell_1_data")
        defaults.set(texts ,forKey: "Cell_1_data")
    }
    
    func readData() -> ([(Any, Any)]) {
        let defaults = UserDefaults.standard
        let stubArray:[(Any, Any)] = []
        if let ideaArray = defaults.array(forKey: "Cell_1_data") {
            return ideaArray as! ([(Any, Any)])
        } else {
            return stubArray
        }

    }

    func readTheme() -> (String) {
        let defaults = UserDefaults.standard
        if let theme:String = defaults.string(forKey: "Cell_1_theme") {
            return theme
        } else {
            return "1"
        }
    }
    
    func createInitialWord() {
        let contentsView = UIView()
        contentsView.frame = CGRect(x:20, y:10, width:Int(view.frame.width-CGFloat(40)), height:90)
        contentsView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.6, alpha: 1.0)
        let firstWordLabel = UILabel()
        firstWordLabel.frame = CGRect(x:10, y:5, width:contentsView.frame.width-20, height:30)
        firstWordLabel.text = "しりとりの最初のフレーズ"
        firstWordLabel.textColor = UIColor.black
        contentsView.addSubview(firstWordLabel)
        let firstWordField = UITextField(frame: CGRect(x: 10, y:40, width:140, height:30))
        firstWordField.borderStyle = UITextBorderStyle.roundedRect
        firstWordField.text = firstWord
        contentsView.addSubview(firstWordField)
        scrollView.addSubview(contentsView)
    }
    
    func displayTheme() {
        let themeLabel = UILabel()
        themeLabel.frame = CGRect(x:0, y:60, width:view.frame.width, height:50)
        themeLabel.numberOfLines = 0
        themeLabel.text = "★テーマ★\n　　　　" + readTheme()
        themeLabel.textColor = UIColor.white
        themeLabel.backgroundColor = UIColor.blue
        view.addSubview(themeLabel)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
