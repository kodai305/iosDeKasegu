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
        // テーマの作成
        if (ThemeTextView.text.isEmpty) {
            ThemeTextView = UITextView(frame: CGRect(x: self.view.center.x-CGFloat(cellSize/2), y:self.view.center.y-CGFloat(cellSize/2), width:CGFloat(cellSize), height:CGFloat(cellSize)))
            ThemeTextView.layer.borderWidth = 1
            ThemeTextView.layer.borderColor = UIColor.lightGray.cgColor
            ThemeTextView.backgroundColor = UIColor.red
            ThemeTextView.delegate = self
        }
        view.addSubview(ThemeTextView)
        //初期化
        ThemeTextView.text = ini_theme
        
        var index_i = 0
        for (x,y) in vector {
            // 要素の作成
            var CellTextView: UITextView = UITextView(frame: CGRect(x: self.view.center.x-CGFloat(vectorLen+(cellSize+margin)*x), y:self.view.center.y-CGFloat(vectorLen+(cellSize+margin)*y), width:CGFloat(cellSize), height:CGFloat(cellSize)))
            if (ElementArray[index_i].text.isEmpty) {
                CellTextView.layer.borderWidth = 1
                CellTextView.layer.borderColor = UIColor.lightGray.cgColor
                CellTextView.backgroundColor = UIColor.yellow
                ElementArray[index_i] = CellTextView
                ElementArray[index_i].delegate = self
            }
            view.addSubview(ElementArray[index_i])
            ElementArray[index_i].text = ini_element

            // 要素を周りに配置(新しい中心)
            if (ElementRoundArray[index_i].text.isEmpty) {
                CellTextView = UITextView(frame: CGRect(x: self.view.center.x-CGFloat(vectorLen+(cellSize+margin)*3*x), y:self.view.center.y-CGFloat(vectorLen+(cellSize+margin)*3*y), width:CGFloat(cellSize), height:CGFloat(cellSize)))
                CellTextView.layer.borderWidth = 1
                CellTextView.layer.borderColor = UIColor.lightGray.cgColor
                CellTextView.backgroundColor = UIColor.yellow
                ElementRoundArray[index_i] = CellTextView
                ElementRoundArray[index_i].delegate = self
            }
            view.addSubview(ElementRoundArray[index_i])

            // 詳細枠(外側)の作成
            var index_j = 0
            for (xx,yy) in vector {
                if (DetailArray[index_i][index_j].text.isEmpty) {
                    CellTextView = UITextView(frame: CGRect(x: self.view.center.x-CGFloat(vectorLen+(cellSize+margin)*3*x+(cellSize+margin)*xx), y:self.view.center.y-CGFloat(vectorLen+(cellSize+margin)*3*y+(cellSize+margin)*yy), width:CGFloat(cellSize), height:CGFloat(cellSize)))
                    CellTextView.layer.borderWidth = 1
                    CellTextView.layer.borderColor = UIColor.lightGray.cgColor
                    CellTextView.backgroundColor = UIColor.lightGray
                    DetailArray[index_i][index_j] = CellTextView
                    DetailArray[index_i][index_j].delegate = self
                }
                view.addSubview(DetailArray[index_i][index_j])
                DetailArray[index_i][index_j].text = ini_detail
                index_j += 1
            }
            index_i += 1
        }
        
        // Do any additional setup after loading the view.
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
        //枠にあわせて文字サイズを調整
        let defaultfontsize: CGFloat = 20
        var fixedFontPoint: CGFloat = 0.0
        textView.font = UIFont.systemFont(ofSize: defaultfontsize)
        var fontIncrement: CGFloat = 0.5
        while (textView.contentSize.height > textView.frame.size.height) {
            fixedFontPoint = defaultfontsize - fontIncrement
            textView.font = UIFont.systemFont(ofSize: fixedFontPoint)
            fontIncrement = fontIncrement + 1
            }
        if(k != -1){
            ElementRoundArray[k].font = UIFont.systemFont(ofSize: fixedFontPoint)
        }
    }
        func textViewDidBeginEditing(_ textView: UITextView){
        if(textView.text == ini_theme || textView.text == ini_element || textView.text == ini_detail){
            textView.text = ""
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
