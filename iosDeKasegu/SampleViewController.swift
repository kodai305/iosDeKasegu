//
//  SampleViewController.swift
//  iosDeKasegu
//
//  Created by 高木広大 on 2018/07/09.
//  Copyright © 2018年 shonanhiratsuka. All rights reserved.
//

import UIKit

var ThemeTextView = UITextView()
var ElementArray = [UITextView](repeating: UITextView(), count: 8)
var ElementRoundArray = [UITextView](repeating: UITextView(), count: 8)
//var DetailArray:[[UITextView]] = [[]]
var DetailArray:[[UITextView]] = [[UITextView](repeating: UITextView(), count: 8),
                                  [UITextView](repeating: UITextView(), count: 8),
                                  [UITextView](repeating: UITextView(), count: 8),
                                  [UITextView](repeating: UITextView(), count: 8),
                                  [UITextView](repeating: UITextView(), count: 8),
                                  [UITextView](repeating: UITextView(), count: 8),
                                  [UITextView](repeating: UITextView(), count: 8),
                                  [UITextView](repeating: UITextView(), count: 8),]
var Waku = UIView()

let ini_theme:String! = "テーマを入力"
let ini_element:String! = "構成要素を入力"
let ini_detail:String! = "詳細を入力"

class SampleViewController: UIViewController, UITextViewDelegate {
    
    let vector: [(x: Int, y: Int)] = [
        (0, 1), (1, 1), (1, 0), (1, -1),
        (0, -1), (-1, -1), (-1, 0), (-1, 1)]

    let cellSize  = 36
    let vectorLen = 18
    let margin    =  3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Waku = UIView(frame: CGRect(x: self.view.center.x-CGFloat(cellSize * 4 + cellSize/2 + margin * 4), y:self.view.center.y-CGFloat(cellSize * 4 + cellSize/2 + margin * 4), width:CGFloat(cellSize*9 + margin*8), height:CGFloat(cellSize*9 + margin*8)))
        Waku.backgroundColor = UIColor.blue
        view.addSubview(Waku)
        
        if (ThemeTextView.text.isEmpty) {
            ThemeTextView = UITextView(frame: CGRect(x: CGFloat(cellSize * 4 + margin * 4), y:CGFloat(cellSize * 4 + margin * 4), width:CGFloat(cellSize), height:CGFloat(cellSize)))
            ThemeTextView.layer.borderWidth = 1
            ThemeTextView.layer.borderColor = UIColor.lightGray.cgColor
            ThemeTextView.backgroundColor = UIColor.red
            ThemeTextView.delegate = self
        }

        Waku.addSubview(ThemeTextView)
        //初期化
        ThemeTextView.text = ini_theme
        ThemeTextView.textColor = UIColor.gray
        AutoFontResize(textView: ThemeTextView,flag: -1)
        
        var index_i = 0
        for (x,y) in vector {
            // 要素の作成
            var CellTextView: UITextView = UITextView(frame: CGRect(x: ThemeTextView.center.x-CGFloat(vectorLen+(cellSize+margin)*x), y:ThemeTextView.center.y-CGFloat(vectorLen+(cellSize+margin)*y), width:CGFloat(cellSize), height:CGFloat(cellSize)))
            if (ElementArray[index_i].text.isEmpty) {
                CellTextView.layer.borderWidth = 1
                CellTextView.layer.borderColor = UIColor.lightGray.cgColor
                CellTextView.backgroundColor = UIColor.yellow
                ElementArray[index_i] = CellTextView
                ElementArray[index_i].delegate = self
            }
            Waku.addSubview(ElementArray[index_i])
            ElementArray[index_i].text = ini_element
            ElementArray[index_i].textColor = UIColor.gray
            AutoFontResize(textView: ElementArray[index_i],flag: -1)

            // 要素を周りに配置(新しい中心)
            if (ElementRoundArray[index_i].text.isEmpty) {
                CellTextView = UITextView(frame: CGRect(x: ThemeTextView.center.x-CGFloat(vectorLen+(cellSize+margin)*3*x), y:ThemeTextView.center.y-CGFloat(vectorLen+(cellSize+margin)*3*y), width:CGFloat(cellSize), height:CGFloat(cellSize)))
                CellTextView.layer.borderWidth = 1
                CellTextView.layer.borderColor = UIColor.lightGray.cgColor
                CellTextView.backgroundColor = UIColor.yellow
                ElementRoundArray[index_i] = CellTextView
                ElementRoundArray[index_i].delegate = self
            }
            Waku.addSubview(ElementRoundArray[index_i])

            // 詳細枠(外側)の作成
            var index_j = 0
            for (xx,yy) in vector {
                if (DetailArray[index_i][index_j].text.isEmpty) {
                    CellTextView = UITextView(frame: CGRect(x: ThemeTextView.center.x-CGFloat(vectorLen+(cellSize+margin)*3*x+(cellSize+margin)*xx), y:ThemeTextView.center.y-CGFloat(vectorLen+(cellSize+margin)*3*y+(cellSize+margin)*yy), width:CGFloat(cellSize), height:CGFloat(cellSize)))
                    CellTextView.layer.borderWidth = 1
                    CellTextView.layer.borderColor = UIColor.lightGray.cgColor
                    CellTextView.backgroundColor = UIColor.lightGray
                    DetailArray[index_i][index_j] = CellTextView
                    DetailArray[index_i][index_j].delegate = self
                }
                Waku.addSubview(DetailArray[index_i][index_j])
                DetailArray[index_i][index_j].text = ini_detail
                DetailArray[index_i][index_j].textColor = UIColor.gray
                AutoFontResize(textView: DetailArray[index_i][index_j],flag: -1)
                index_j += 1
            }
            index_i += 1
        }

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func PinchOut(_ sender: UIPinchGestureRecognizer) {
        //ピンチ開始時のアフィン変換を引き継いでアフィン変換を行う。
        Waku.transform = Waku.transform.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1
    }
    
    @IBAction func Slide(_ sender: UIPanGestureRecognizer) {
        //移動量を取得する。
        let move:CGPoint = sender.translation(in: self.view)
        
        //ドラッグした部品の座標に移動量を加算する。
        let right_x = Waku.frame.origin.x + Waku.frame.size.width + move.x
        let left_x  = Waku.frame.origin.x + move.x
        let top_y = Waku.frame.origin.y + move.y
        let bottom_y  = Waku.frame.origin.y + Waku.frame.size.height + move.y
        
        if(self.view.center.x < left_x){
            Waku.frame.origin.x = self.view.center.x
        }
        else{
            if(right_x < self.view.center.x){
                Waku.frame.origin.x = self.view.center.x - Waku.frame.size.width
            }
            else{
                Waku.center.x += move.x
            }
        }
        
        if(self.view.center.y < top_y){
            Waku.frame.origin.y = self.view.center.y
        }
        else{
            if(bottom_y < self.view.center.y){
                Waku.frame.origin.y = self.view.center.y - Waku.frame.size.height
            }
            else{
                Waku.center.y += move.y
            }
        }
        
        //移動量を0にする。
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
    
    //マスの編集開始時に説明文が入っていれば消去
    func textViewDidBeginEditing(_ textView: UITextView){
        if(textView.text == ini_theme || textView.text == ini_element || textView.text == ini_detail){
            textView.text = ""
            textView.textColor = UIColor.black
            }
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
