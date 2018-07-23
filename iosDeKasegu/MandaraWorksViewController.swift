//
//  SampleViewController.swift
//  iosDeKasegu
//
//  Created by 高木広大 on 2018/07/09.
//  Copyright © 2018年 shonanhiratsuka. All rights reserved.
//

import UIKit
import GoogleMobileAds

class MandaraWorkViewController: BaseWorkViewController, UITextViewDelegate {
    // 保存用の構造体
    struct MandaraData: Codable {
        // テーマの周りの8マス
        var CentralData:[String] = [String](repeating: "", count: 8)
        // 周りのマス
        var DetailData:[[String]] = [[String](repeating: "", count: 8),
                                     [String](repeating: "", count: 8),
                                     [String](repeating: "", count: 8),
                                     [String](repeating: "", count: 8),
                                     [String](repeating: "", count: 8),
                                     [String](repeating: "", count: 8),
                                     [String](repeating: "", count: 8),
                                     [String](repeating: "", count: 8),]
    }
    // 保存用
    var mandaraData = MandaraData()
    
    // キーボード上に出す完了ボタンが載るツールバー
    let DoneToolBar = UIToolbar()
    
    //前の画面から受け取る変数
    var cellIndex:Int = 0
    var mandaraTheme:String = ""
    
    // 変数の宣言と初期化
    var ElementArray = [UITextView](repeating: UITextView(), count: 8)
    var ElementRoundArray = [UITextView](repeating: UITextView(), count: 8)
    var DetailArray:[[UITextView]] = [[UITextView](repeating: UITextView(), count: 8),
                                      [UITextView](repeating: UITextView(), count: 8),
                                      [UITextView](repeating: UITextView(), count: 8),
                                      [UITextView](repeating: UITextView(), count: 8),
                                      [UITextView](repeating: UITextView(), count: 8),
                                      [UITextView](repeating: UITextView(), count: 8),
                                      [UITextView](repeating: UITextView(), count: 8),
                                      [UITextView](repeating: UITextView(), count: 8),]

    var ThemeLabel = UILabel() // UILabelに変える予定
    let InitialTextOfElement:String! = "構成要素を入力"
    let InitialTextOfDetail:String! = "詳細を入力"
    var topKeyboard:CGFloat = 0
    var BackGround = UIView() //マンダラチャートの全てのマスを同時に動かすためのUIView
    
    
    let vector: [(x: Int, y: Int)] = [
        (0, 1), (1, 1), (1, 0), (1, -1),
        (0, -1), (-1, -1), (-1, 0), (-1, 1)]

    //ここで宣言しないとビルド時にメモリーリーク？
    var cellSize  = 0
    var vectorLen = 0
    var margin    = 0
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("load View called")
        
        //iPhoneに合せて再定義
        cellSize = Int(self.view.frame.width / 9 * 11 / 12)
        vectorLen = cellSize / 2
        margin = Int(self.view.frame.width / 9 * 1 / 12)

        //マンダラチャートの全てのマスを同時に動かすためのUIViewの位置、大きさを定義
        BackGround = UIView(frame: CGRect(x: self.view.center.x-CGFloat(cellSize * 4 + cellSize/2 + margin * 5), y:self.view.center.y-CGFloat(cellSize * 4 + cellSize/2 + margin * 5), width:CGFloat(cellSize * 9 + margin * 10), height:CGFloat(cellSize * 9 + margin * 10)))
        //背景色(SHERPA BLUE)
        BackGround.backgroundColor = UIColor(hex: "013243", alpha: 1.0)
        view.addSubview(BackGround)
        
        //テーママスの設定
        ThemeLabel = UILabel(frame: CGRect(x: CGFloat(cellSize * 4 + margin * 5), y:CGFloat(cellSize * 4 + margin * 5), width:CGFloat(cellSize), height:CGFloat(cellSize)))
        //テーママスの色(WAX FLOWER)
        ThemeLabel.backgroundColor = UIColor(hex: "F1A9A0", alpha: 1.0)
        ThemeLabel.adjustsFontSizeToFitWidth = true
        ThemeLabel.minimumScaleFactor = 0.3
        ThemeLabel.numberOfLines = 0
        ThemeLabel.text = mandaraTheme
        //AutoFontResize(textView: ThemeLabel,flag: -1)
        BackGround.addSubview(ThemeLabel)
        
        // 保存されているデータの読み込み
        let lastData:MandaraData = readData()
        // 要素マスを作成
        var index_i = 0
        for (x,y) in vector {
            var CellTextView: UITextView = UITextView(frame: CGRect(x: ThemeLabel.center.x-CGFloat(vectorLen+(cellSize+margin)*x), y:ThemeLabel.center.y-CGFloat(vectorLen+(cellSize+margin)*y), width:CGFloat(cellSize), height:CGFloat(cellSize)))
            if (ElementArray[index_i].text.isEmpty) {
                //要素のマスの色(MADANG)
                CellTextView.backgroundColor = UIColor(hex: "C8F7C5", alpha: 1.0)
                ElementArray[index_i] = CellTextView
                ElementArray[index_i].delegate = self
            }

            BackGround.addSubview(ElementArray[index_i])
            //初期化or編集されていないマスの場合
            if (lastData.CentralData[index_i].isEmpty || lastData.CentralData[index_i] == InitialTextOfElement) {
                
                ElementArray[index_i].text = InitialTextOfElement
                ElementArray[index_i].textColor = UIColor.gray
                AutoFontResize(textView: ElementArray[index_i],flag: -1)
            }
            //ロードする場合
            else{
                ElementArray[index_i].text = lastData.CentralData[index_i]
                ElementArray[index_i].textColor = UIColor.black
                AutoFontResize(textView: ElementArray[index_i],flag: -1)
            }
            
            // 要素を周りに配置(新しい中心)
            if (ElementRoundArray[index_i].text.isEmpty) {
                CellTextView = UITextView(frame: CGRect(x: ThemeLabel.center.x-CGFloat(vectorLen+(cellSize+margin)*3*x), y:ThemeLabel.center.y-CGFloat(vectorLen+(cellSize+margin)*3*y), width:CGFloat(cellSize), height:CGFloat(cellSize)))
                CellTextView.backgroundColor = UIColor(hex: "C8F7C5", alpha: 1.0)
                ElementRoundArray[index_i] = CellTextView
                ElementRoundArray[index_i].delegate = self
            }
            //ロードする情報がある場合
            if (!lastData.CentralData[index_i].isEmpty) {
                ElementRoundArray[index_i].text = lastData.CentralData[index_i]
                AutoFontResize(textView: ElementRoundArray[index_i],flag: -1)
            }
            BackGround.addSubview(ElementRoundArray[index_i])
            
            // 詳細マス(外側)の作成
            var index_j = 0
            for (xx,yy) in vector {
                if (DetailArray[index_i][index_j].text.isEmpty) {
                    CellTextView = UITextView(frame: CGRect(x: ThemeLabel.center.x-CGFloat(vectorLen+(cellSize+margin)*3*x+(cellSize+margin)*xx), y:ThemeLabel.center.y-CGFloat(vectorLen+(cellSize+margin)*3*y+(cellSize+margin)*yy), width:CGFloat(cellSize), height:CGFloat(cellSize)))
                    //詳細マスの色(ALICE BLUE)
                    CellTextView.backgroundColor = UIColor(hex: "E4F1FE", alpha: 1.0)
                    DetailArray[index_i][index_j] = CellTextView
                    DetailArray[index_i][index_j].delegate = self
                }
                BackGround.addSubview(DetailArray[index_i][index_j])
                
                //初期化or編集されていないマスの場合
                if (lastData.DetailData[index_i][index_j].isEmpty || lastData.DetailData[index_i][index_j] == InitialTextOfDetail) {
                    DetailArray[index_i][index_j].text = InitialTextOfDetail
                    DetailArray[index_i][index_j].textColor = UIColor.gray
                    AutoFontResize(textView: DetailArray[index_i][index_j],flag: -1)
                }
                    //ロードする場合
                else{
                    DetailArray[index_i][index_j].text = lastData.DetailData[index_i][index_j]
                    DetailArray[index_i][index_j].textColor = UIColor.black
                    AutoFontResize(textView: DetailArray[index_i][index_j],flag: -1)
                }
                index_j += 1
            }
            index_i += 1
        }
        //UIToolBarの生成。
        self.toolbar = UIToolbar(frame: CGRect(x:0, y:self.view.frame.height - 50, width:self.view.frame.width, height:50))
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        let button = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(self.shareButtonAction(sender:)))
        button.tag = 1
        self.toolbar.items = [space,space,button]
        self.view.addSubview(self.toolbar)
        
        
        // バッググラウンドに行ったときの処理
        NotificationCenter.default.addObserver(self, selector: #selector(viewDidEnterBackground(_:)), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        
        // To display the advertisement on scrollView
        displayAdvertisement()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //完了ボタン用のツールバーの設定
        DoneToolBar.frame = CGRect(x: 0, y: self.view.frame.size.height, width: 320, height: 40) //仮にサイズを決定、ここでは見えない場所に置く
        DoneToolBar.barStyle = UIBarStyle.default  // スタイルを設定
        DoneToolBar.sizeToFit()
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil) // スペーサー
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.commitButtonTapped)) // 閉じるボタン
        DoneToolBar.items = [spacer, commitButton]
        self.view.addSubview(DoneToolBar)
        // Do any additional setup after loading the view.
    }
    
    // バッググラウンドに行ったときの処理
    @objc func viewDidEnterBackground(_ notification: Notification?) {
        if (self.isViewLoaded && (self.view.window != nil)) {
            print("バッググラウンド処理")
            for i in 0..<self.ElementArray.count {
                if (self.ElementArray[i].text != InitialTextOfElement) {
                    self.mandaraData.CentralData[i] = self.ElementArray[i].text
                } else {
                    self.mandaraData.CentralData[i] = ""
                }
            }
            for i in 0..<self.ElementArray.count {
                for j in 0..<self.DetailArray.count {
                    self.mandaraData.DetailData[i][j] = self.DetailArray[i][j].text
                }
            }
            saveData(self.mandaraData)
        }
    }
    
    override func shareButtonAction(sender: UIBarButtonItem) {
        print("shitiroti !!!!!")
        // シェアする
        let TopText = "マンダラチャート出力\n"
        var sharedText:String = ""
        sharedText += "テーマ："+self.mandaraTheme+"\n"
        for i in 0..<ElementArray.count {
            if (ElementArray[i].text == InitialTextOfElement) {
                sharedText += "　要素"+String(i+1)+"：-\n"
            } else {
                sharedText += "　要素"+String(i+1)+"："+ElementArray[i].text!+"\n"
            }
            
            
            for j in 0..<DetailArray[i].count {
                if (DetailArray[i][j].text == InitialTextOfDetail) {
                    sharedText += "　　詳細"+String(j+1)+"：-\n"
                } else {
                    sharedText += "　　詳細"+String(j+1)+"："+DetailArray[i][j].text+"\n"
                }
            }
        }
        
        let activities = [TopText, sharedText] as [Any]
        // アクティビティコントローラを表示する
        let activityVC = UIActivityViewController(activityItems: activities, applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    
    //ピンチした時の拡大縮小を設定
    @IBAction func PinchOut(_ sender: UIPinchGestureRecognizer) {
        //let TempTransform : UIView = UIView()
        BackGround.transform = BackGround.transform.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1
    }
    
    //パンした時の移動方法を設定
    @IBAction func Slide(_ sender: UIPanGestureRecognizer) {
        //指の移動量を取得する。
        let move:CGPoint = sender.translation(in: self.view)
        //移動後のBackGroundの上下左右の端の座標を算出
        let right_x = BackGround.frame.origin.x + BackGround.frame.size.width + move.x
        let left_x  = BackGround.frame.origin.x + move.x
        let top_y = BackGround.frame.origin.y + move.y
        let bottom_y  = BackGround.frame.origin.y + BackGround.frame.size.height + move.y
        
        //移動後のBackGroundの左端が画面の真ん中より右にある場合、左端を画面の真ん中で規制する
        if(self.view.center.x < left_x){
            BackGround.frame.origin.x = self.view.center.x
        }
        else{
            //移動後のBackGroundの右端が画面の真ん中より左にある場合、右端を画面の真ん中で規制する
            if(right_x < self.view.center.x){
                BackGround.frame.origin.x = self.view.center.x - BackGround.frame.size.width
            }
            //移動量分移動させる
            else{
                BackGround.center.x += move.x
            }
        }
        //移動後のBackGroundの上端が画面の真ん中より下にある場合、上端を画面の真ん中で規制する
        if(self.view.center.y < top_y){
            BackGround.frame.origin.y = self.view.center.y
        }
        else{
        //移動後のBackGroundの下端が画面の真ん中より上にある場合、下端を画面の真ん中で規制する
            if(bottom_y < self.view.center.y){
                BackGround.frame.origin.y = self.view.center.y - BackGround.frame.size.height
            }
            else{
                BackGround.center.y += move.y
            }
        }
        //移動量を0にする。
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //任意のマスの内容が書き換えられた時の処理
    func textViewDidChange(_ textView: UITextView) {
        //変更したマスから対象マスへの代入と変更したマスの特定
        var k: Int = -1
        for i in 0..<8 {
            if (textView == ElementArray[i]){
                ElementRoundArray[i].text = ElementArray[i].text
                k = i
            }
        }
        AutoFontResize(textView: textView,flag: k)
    }
    
    //マスの編集開始時の処理
    func textViewDidBeginEditing(_ textView: UITextView){
        //マスの内容が初期状態の場合
        if(textView.text == InitialTextOfElement || textView.text == InitialTextOfDetail){
            textView.text = ""
            textView.textColor = UIColor.black
        }
        
        // 編集しているマスがキーボードと重なるかを判定
        // 編集しているマスの下端の絶対座標を算出、拡大時にも対応するためにBackGround.transform.aをかける
        let textView_y = BackGround.frame.origin.y + (textView.frame.origin.y + textView.frame.height) * BackGround.transform.a
        let distance = textView_y - (topKeyboard - 40)
        if distance >= 0 {
            // scrollViewのコンテツを上へオフセット + 20(追加のオフセット)
            BackGround.frame.origin.y = BackGround.frame.origin.y - (distance + 20)
        }
        self.view.bringSubview(toFront: DoneToolBar) //最前面に配置
        //完了ボタンをキーボード上に表示
        DoneToolBar.frame.origin = CGPoint(x: 0, y: topKeyboard-40)
    }
    
    @objc func commitButtonTapped (){
        self.view.endEditing(true)
    }
    
    func AutoFontResize(textView: UITextView, flag: Int){
        let defaultfontsize: CGFloat = 20
        var fixedFontPoint: CGFloat = 0.0
        textView.font = UIFont.systemFont(ofSize: defaultfontsize)
        var fontIncrement: CGFloat = 0.5
        while (textView.contentSize.height > textView.frame.size.height) {
            fixedFontPoint = defaultfontsize - fontIncrement
            textView.font = UIFont.systemFont(ofSize: fixedFontPoint)
            fontIncrement = fontIncrement + 0.5
        }
        if(flag != -1){
            ElementRoundArray[flag].font = UIFont.systemFont(ofSize: fixedFontPoint)
        }
    }
    
    // キーボードが表示、非表示された時に最初に呼び出される関数（textViewDidBeginEditing(）より早い）
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,selector: #selector(self.keyboardWillShow(_:)),name: NSNotification.Name.UIKeyboardWillShow,object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(self.keyboardWillHide(_:)) ,name: NSNotification.Name.UIKeyboardWillHide,object: nil)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self,name: .UIKeyboardWillShow,object: self.view.window)
        NotificationCenter.default.removeObserver(self,name: .UIKeyboardDidHide,object: self.view.window)
        
        for i in 0..<self.ElementArray.count {
            if (self.ElementArray[i].text != InitialTextOfElement) {
                self.mandaraData.CentralData[i] = self.ElementArray[i].text
            } else {
                self.mandaraData.CentralData[i] = ""
            }
        }
        for i in 0..<self.ElementArray.count {
            for j in 0..<self.DetailArray.count {
                self.mandaraData.DetailData[i][j] = self.DetailArray[i][j].text
            }
        }
        saveData(self.mandaraData)
        print("saveData is called")
    }
    
    @objc func UIApplicationWillTerminateNotification(_ notification: Notification) {

    }
    
    //キーボードが表示された時の処理
    @objc func keyboardWillShow(_ notification: Notification) {
        let info = notification.userInfo!
        //キーボードの大きさ、座標を取得
        let keyboardFrame = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        //キーボード+ツールバーの上端のy座標を保存
        topKeyboard = keyboardFrame.origin.y
    }
    
     //キーボードが下がった時の処理
    @objc func keyboardWillHide(_ notification: Notification) {
        //キーボードが下がって分全体を下げる
        BackGround.frame.origin.y = BackGround.frame.origin.y + 50.0
        DoneToolBar.frame.origin = CGPoint(x: 0, y: self.view.frame.height)
    }

    //UITextView以外を触るとキーボードが下がる
    @IBAction func Tap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // データの保存・読み取り
    func saveData(_ mandaraData: MandaraData) {
        let defaults = UserDefaults.standard
        let data = try? JSONEncoder().encode(mandaraData)
        //Userdefaultのkeyを設定
        let siritoriDataKey:String = "MandaraCell_"+String(self.cellIndex)+"_data"
        print("texts")
        defaults.set(data ,forKey: siritoriDataKey)
        print("done")
    }
    func readData() -> (MandaraData) {
        let defaults = UserDefaults.standard
        let stub = MandaraData()
        //Userdefaultのkeyを設定
        let siritoriDataKey:String = "MandaraCell_"+String(self.cellIndex)+"_data"
        print("read:")
        guard let data = defaults.data(forKey: siritoriDataKey) else {
            return stub
        }
        let user = try? JSONDecoder().decode(MandaraData.self, from: data)
        print(user!)
        return user!
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
