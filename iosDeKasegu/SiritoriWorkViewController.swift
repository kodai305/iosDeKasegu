//
//  SiritoriWorkViewController.swift
//  iosDeKasegu
//
//  Created by 高木広大 on 2018/07/01.
//  Copyright © 2018年 shonanhiratsuka. All rights reserved.
//

import UIKit
import GoogleMobileAds



class SiritoriWorkViewController: BaseWorkViewController, UITextFieldDelegate {
    // 構造体
    struct IdeaData: Codable {
        var keyword: String = ""
        var idea: String = ""
    }
    // 保存用
    var IdeaDataArray:[IdeaData] = []

    //前の画面から受け取る
    var cellIndex:Int = 0
    var siritoriTheme:String = ""

    //カードの幅、高さ、カード間の距離を定義
    var HeightOfCard:CGFloat!
    var WidthOfCard:CGFloat!
    var MarginOfCards:CGFloat!
    
    var KeywordTextFieldArray:[UITextField] = []
    var IdeaTextViewArray:[PlaceholderTextView] = []

    let firstWord = "しりとり"
    let scrollView = UIScrollView()

    // キーボードを下げる
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //カードの幅、高さ、カード間の距離を定義
        self.HeightOfCard = self.view.frame.size.height / 5
        self.WidthOfCard = self.view.frame.size.width * 9 / 10
        self.MarginOfCards = self.view.frame.size.height / 30
        //保存してある配列の読込
        IdeaDataArray = readData()
        let index = IdeaDataArray.count
        
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
            }
            IdeaDataArray = readData()
        }
        // ボタンの追加
        addNextButton()
        // スクロールビューを設定・追加
        //背景色（PORCELAIN）
        scrollView.backgroundColor = UIColor(hex: "ECF0F1", alpha: 10.0)
        scrollView.keyboardDismissMode = .onDrag
        scrollView.frame = CGRect(x:0 , y:60 + view.frame.height / 10, width:view.frame.width, height:view.frame.height-20)
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height-20+CGFloat(140*index))
        self.view.addSubview(scrollView)
        
        
        //UIToolBarの生成
        self.toolbar = UIToolbar(frame: CGRect(x:0, y:self.view.frame.height - 50, width:self.view.frame.width, height:50))
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        let button = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(self.shareButtonAction(sender:)))
        button.tag = 1
        self.toolbar.items = [space,space,button]
        self.view.addSubview(self.toolbar)
        
        // 広告の表示
        displayAdvertisement()
        
        // バッググラウンドに行ったときの処理
        NotificationCenter.default.addObserver(self, selector: #selector(viewDidEnterBackground(_:)), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
    }

    override func shareButtonAction(sender: UIBarButtonItem) {
        print("shitiroti !!!!!")
        // シェアする
        let TopText = "しりとり法で発想したアイデア\n"
        var sharedText:String = ""
        sharedText += "テーマ："+self.siritoriTheme+"\n\n"
        for i in 0..<KeywordTextFieldArray.count {
            sharedText += "キーワード"+String(i+1)+"："+KeywordTextFieldArray[i].text!+"\n"
            sharedText += "アイデア"+String(i+1)+"："+IdeaTextViewArray[i].text+"\n"
            sharedText += "\n"
        }
        
        let activities = [TopText, sharedText] as [Any]
        // アクティビティコントローラを表示する
        let activityVC = UIActivityViewController(activityItems: activities, applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    // バッググラウンドに行ったときの処理
    @objc func viewDidEnterBackground(_ notification: Notification?) {
        if (self.isViewLoaded && (self.view.window != nil)) {
            print("バッググラウンド処理")
            let index = KeywordTextFieldArray.count
            print("disapper index:")
            print(index)
            var stubIdeaDataArray:[IdeaData] = []
            for i in 0..<index {
                let stub = IdeaData(keyword: KeywordTextFieldArray[i].text!, idea: IdeaTextViewArray[i].text!)
                stubIdeaDataArray.append(stub)
            }
            saveData(array: stubIdeaDataArray)
        }
    }

    
    // 「次へ」ボタンが押されたときの処理
    @objc func onClick(_ sender: AnyObject){
        let button   = sender as! UIButton
        let index    = KeywordTextFieldArray.count
        let button_y = (index + 2) * Int(self.MarginOfCards!) + (index + 1) * Int(self.HeightOfCard!)

        // キーワードが入力されていなかったらアラートを出す
        print("index:")
        print(index)
        if (KeywordTextFieldArray[index-1].text?.isEmpty)! {
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
        button.frame = CGRect(x:Int(self.view.frame.width * 3 / 4), y:button_y + Int(HeightOfCard + MarginOfCards) , width:Int(self.view.frame.width) / 6, height:Int(HeightOfCard) / 3)
        // スクロールビューのサイズを更新
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + CGFloat(button_y))
        // 中心を変更する(-200はなんの値？) // 200は、無意味. とりあえず、ボタンの位置からカード２つ分上にしてみた
        scrollView.setContentOffset(CGPoint(x: 0, y: button_y - Int(HeightOfCard) * 2), animated: true)

        // 保存用のデータを作成配列
        let stubIdeaData = IdeaData(keyword: KeywordTextFieldArray[index-1].text!, idea: IdeaTextViewArray[index-1].text!)
        var stubIdeaDataArray = readData()
        stubIdeaDataArray.append(stubIdeaData)
        print("IdeaData index:")
        print(stubIdeaDataArray.count)
        // 保存
        saveData(array: stubIdeaDataArray)
    }
    
    func loadContentsView(ArrayIndex: Int) {
        let y_field = (ArrayIndex + 2) * Int(self.MarginOfCards!) + (ArrayIndex + 1) * Int(HeightOfCard)

        // キーワード + アイデアのUIViewの作成
        let contentsView = UIView()
        contentsView.frame = CGRect(x:Int(self.view.frame.size.width / 20), y:y_field, width:Int(WidthOfCard), height:Int(HeightOfCard))
        contentsView.backgroundColor = UIColor(hex: "FABE58", alpha: 1.0)
        
        // キーワードのラベルを追加
        let keywordLabel = createKeywordLabel(index: ArrayIndex)
        contentsView.addSubview(keywordLabel)
        // キーワードフィールドの設定・追加
        let keywordField = UITextField(frame: CGRect(x: contentsView.frame.size.width / 50, y:contentsView.frame.size.height * 3 / 10, width:contentsView.frame.size.width * 2 / 5, height:contentsView.frame.size.height / 4))
        keywordField.borderStyle = UITextBorderStyle.roundedRect
        keywordField.text = IdeaDataArray[ArrayIndex].keyword
        keywordField.layer.borderWidth = 1
        keywordField.layer.borderColor = UIColor.lightGray.cgColor
        KeywordTextFieldArray.append(keywordField)
        contentsView.addSubview(keywordField)
        
        // アイデアのラベルを追加
        let IdeaLabel = createIdeaLabel(index: ArrayIndex)
        contentsView.addSubview(IdeaLabel)
        // アイデアフィールドの作成・追加
        let IdeaView: PlaceholderTextView = PlaceholderTextView(frame: CGRect(x: contentsView.frame.size.width * 23 / 50, y:contentsView.frame.size.height * 3 / 10, width:contentsView.frame.size.width * 26 / 50, height:contentsView.frame.size.height * 15 / 25))
        IdeaView.layer.borderWidth = 1
        IdeaView.layer.cornerRadius = 5
        IdeaView.layer.borderColor = UIColor.lightGray.cgColor
        IdeaView.text = IdeaDataArray[ArrayIndex].idea
        IdeaTextViewArray.append(IdeaView)
        contentsView.addSubview(IdeaView)

        // スクロールビューに追加
        scrollView.addSubview(contentsView)
    }
    
    func createContentsView(ArrayIndex: Int) {
        let y_field = (ArrayIndex + 2) * Int(MarginOfCards) + (ArrayIndex + 1) * Int(HeightOfCard)
        
        // キーワード + アイデアのUIViewの作成
        let contentsView = UIView()
        contentsView.frame = CGRect(x:Int(self.view.frame.size.width / 20), y:y_field, width:Int(WidthOfCard), height:Int(HeightOfCard))
        contentsView.backgroundColor = UIColor(hex: "FABE58", alpha: 1.0)
        
        // キーワードのラベルを追加
        let keywordLabel = createKeywordLabel(index: ArrayIndex)
        contentsView.addSubview(keywordLabel)
        // キーワードフィールドの作成・追加
        let keywordField = UITextField(frame: CGRect(x: contentsView.frame.size.width / 50, y:contentsView.frame.size.height * 3 / 10, width:contentsView.frame.size.width * 2 / 5, height:contentsView.frame.size.height / 4))
        keywordField.borderStyle = UITextBorderStyle.roundedRect
        if (ArrayIndex == 0) {
            keywordField.placeholder = firstWord+"→ ..."
        } else {
            keywordField.placeholder = KeywordTextFieldArray[ArrayIndex-1].text!+"→ ..."
        }
        KeywordTextFieldArray.append(keywordField)
        KeywordTextFieldArray[ArrayIndex].delegate = self
        
        contentsView.addSubview(keywordField)
        
        // アイデアのラベルを追加
        let IdeaLabel = createIdeaLabel(index: ArrayIndex)
        contentsView.addSubview(IdeaLabel)
        // アイデアビューの追加
        let IdeaView: PlaceholderTextView = PlaceholderTextView(frame: CGRect(x: contentsView.frame.size.width * 23 / 50, y:contentsView.frame.size.height * 3 / 10, width:contentsView.frame.size.width * 26 / 50, height:contentsView.frame.size.height * 15 / 25))
        IdeaView.layer.borderWidth = 1
        IdeaView.layer.cornerRadius = 5
        IdeaView.layer.borderColor = UIColor.lightGray.cgColor
        IdeaView.placeholder = "キーワードを入力してください."
        IdeaTextViewArray.append(IdeaView)
        contentsView.addSubview(IdeaView)
        
        // スクロールビューに追加
        scrollView.addSubview(contentsView)
    }
    
    func addNextButton() {
        let button   = UIButton()
        let index    = KeywordTextFieldArray.count
        let button_y = (index + 2) * Int(MarginOfCards) + (index + 1) * Int(HeightOfCard)

        button.backgroundColor = UIColor(hex: "F9690E", alpha: 1.0)
        button.layer.borderWidth = 2.0 // 枠線の幅
        button.layer.borderColor = UIColor(hex: "6C7A89", alpha: 1.0).cgColor // 枠線の色
        button.layer.cornerRadius = 10.0
        button.setTitle("次へ", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.frame = CGRect(x: Int(self.view.frame.width * 3 / 4), y: button_y, width:Int(self.view.frame.width) / 6, height:Int(HeightOfCard) / 3)
        button.addTarget(self, action: #selector(self.onClick(_:)), for: .touchUpInside)
        scrollView.addSubview(button)
    }
    

    
    // データの保存・読み取り
    func saveData(array: [IdeaData]) {
        print(array)
        let defaults = UserDefaults.standard
        let data = try? JSONEncoder().encode(array)
        //Userdefaultのkeyを設定
        let siritoriDataKey:String = "SiritoriCell_"+String(self.cellIndex)+"_data"
        print("texts")
        defaults.set(data ,forKey: siritoriDataKey)
        print("done")
    }
    func readData() -> ([IdeaData]) {
        let defaults = UserDefaults.standard
        let stubArray:[IdeaData] = []
        //Userdefaultのkeyを設定
        let siritoriDataKey:String = "SiritoriCell_"+String(self.cellIndex)+"_data"
        print("read:")
        guard let data = defaults.data(forKey: siritoriDataKey) else {
            return stubArray
        }
        let user = try? JSONDecoder().decode([IdeaData].self, from: data)
        print(user!)
        return user!
    }
    
    
    func createInitialWord() {
        let contentsView = UIView()
        
        contentsView.frame = CGRect(x:Int(self.view.frame.size.width / 20), y:Int(MarginOfCards), width:Int(WidthOfCard), height:Int(HeightOfCard))
        contentsView.backgroundColor = UIColor(hex: "FABE58", alpha: 1.0)
        let firstWordLabel = UILabel()
        firstWordLabel.frame = CGRect(x:WidthOfCard / 50, y:HeightOfCard / 10, width:WidthOfCard , height:HeightOfCard / 10)
        firstWordLabel.text = "しりとりの最初のフレーズ"
        firstWordLabel.textColor = UIColor.black
        contentsView.addSubview(firstWordLabel)
        let firstWordField = UITextField(frame: CGRect(x:contentsView.frame.size.width / 50, y:contentsView.frame.size.height * 3 / 10, width:contentsView.frame.size.width * 2 / 5, height:contentsView.frame.size.height / 4))
        firstWordField.borderStyle = UITextBorderStyle.roundedRect
        firstWordField.text = firstWord
        contentsView.addSubview(firstWordField)
        scrollView.addSubview(contentsView)
    }
    
    func displayTheme() {
        let themeLabel = UILabel()
        themeLabel.frame = CGRect(x:0, y:60, width:view.frame.width, height:view.frame.height / 10)
        themeLabel.numberOfLines = 0
        themeLabel.text = "★テーマ★\n　　　　" + self.siritoriTheme
        themeLabel.textColor = UIColor.white
        //JACKSONS PURPLE
        themeLabel.backgroundColor = UIColor(hex: "1F3A93", alpha: 1.0)
        view.addSubview(themeLabel)
    }
    
    func createIdeaLabel(index: Int) -> (UILabel) {
        //カードの幅、高さ、カード間の距離を定義
        let HeightOfCard = self.view.frame.size.height / 5
        let WidthOfCard = self.view.frame.size.width * 9 / 10
        let IdeaLabel = UILabel()
        IdeaLabel.frame = CGRect(x:WidthOfCard * 23 / 50, y:HeightOfCard / 10, width:WidthOfCard * 2 / 5, height:HeightOfCard / 10)
        IdeaLabel.numberOfLines = 0
        IdeaLabel.text = "アイデア"+String(index+1)
        IdeaLabel.textColor = UIColor.black
        return IdeaLabel
    }
    
    func createKeywordLabel(index: Int) -> (UILabel) {
        //カードの幅、高さ、カード間の距離を定義
        let HeightOfCard = self.view.frame.size.height / 5
        let WidthOfCard = self.view.frame.size.width * 9 / 10
        let keywordLabel = UILabel()
        keywordLabel.frame = CGRect(x:WidthOfCard / 50, y:HeightOfCard / 10, width:WidthOfCard * 2 / 5, height:HeightOfCard / 10)
        keywordLabel.numberOfLines = 0
        keywordLabel.text = "キーワード"+String(index+1)
        keywordLabel.textColor = UIColor.black
        return keywordLabel
    }
    
    //任意のマスの内容が書き換えられた時の処理
    func textFieldDidEndEditing(_ textField:UITextField) {
        for i in 0..<KeywordTextFieldArray.count {
            if (KeywordTextFieldArray[i].text?.isEmpty)! {
                IdeaTextViewArray[i].placeholder = "←のキーワードを入力してください."
            } else {
                IdeaTextViewArray[i].placeholder = "["+KeywordTextFieldArray[i].text!+"]をつかった["+siritoriTheme+"]を入力."
            }
            
            if (i == 0) {
                KeywordTextFieldArray[i].placeholder = firstWord+"→ ..."
            } else {
                KeywordTextFieldArray[i].placeholder = KeywordTextFieldArray[i-1].text!+"→ ..."
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let index = KeywordTextFieldArray.count
        print("disapper index:")
        var stubIdeaDataArray:[IdeaData] = []
        for i in 0..<index {
            let stub = IdeaData(keyword: KeywordTextFieldArray[i].text!, idea: IdeaTextViewArray[i].text!)
            stubIdeaDataArray.append(stub)
        }
        saveData(array: stubIdeaDataArray)
        print("saveData is called")
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
