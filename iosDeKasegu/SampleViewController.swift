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
        }
        view.addSubview(ThemeTextView)
        
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
                }
                view.addSubview(DetailArray[index_i][index_j])
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
        var k: Int = 0
        for i in 0..<8 {
            if (textView.text == ElementArray[i].text){
                ElementRoundArray[i].text = ElementArray[i].text
                k = i
            }
        }
        //枠にあわせて文字サイズを調整
        let defaultfontsize: CGFloat = 20.0
        var fixedFontPoint: CGFloat = 0.0
        if (textView.contentSize.height > textView.frame.size.height) {
            var fontIncrement: CGFloat = 1.0
            while (textView.contentSize.height > textView.frame.size.height) {
                fixedFontPoint = defaultfontsize - fontIncrement
                textView.font = UIFont.systemFont(ofSize: fixedFontPoint)
                fontIncrement = fontIncrement + 1
            }
            ElementRoundArray[k].font = UIFont.systemFont(ofSize: fixedFontPoint)
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
