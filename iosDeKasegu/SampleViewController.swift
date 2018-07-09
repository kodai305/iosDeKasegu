//
//  SampleViewController.swift
//  iosDeKasegu
//
//  Created by 高木広大 on 2018/07/09.
//  Copyright © 2018年 shonanhiratsuka. All rights reserved.
//

import UIKit

class SampleViewController: UIViewController, UITextViewDelegate {
    var ElementArray:[UITextView] = []
    var ElementRoundArray:[UITextView] = []
    var DetailArray:[[UITextView]] = [[]]
    
    let vector: [(x: Int, y: Int)] = [
        (0, 1), (1, 1), (1, 0), (1, -1),
        (0, -1), (-1, -1), (-1, 0), (-1, 1)]

    let wakuSize   = 36
    let vector_len = 18
    
    var ThemeTextField = UITextView()
    var Theme2TextField = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // テーマの作成
        ThemeTextField = UITextView(frame: CGRect(x: self.view.center.x-CGFloat(wakuSize/2), y:self.view.center.y-CGFloat(wakuSize/2), width:CGFloat(wakuSize), height:CGFloat(wakuSize)))
        ThemeTextField.layer.borderWidth = 1
        ThemeTextField.layer.borderColor = UIColor.lightGray.cgColor
        ThemeTextField.backgroundColor = UIColor.red
        view.addSubview(ThemeTextField)
        ThemeTextField.delegate = self
        
//        Theme2TextField: UITextView = UITextView(frame: CGRect(x: self.view.center.x-CGFloat(wakuSize/2), y:self.view.center.y-CGFloat(300+wakuSize/2), width:CGFloat(wakuSize), height:CGFloat(wakuSize)))
        Theme2TextField = UITextView(frame: CGRect(x: self.view.center.x-CGFloat(wakuSize/2), y:self.view.center.y-CGFloat(200+wakuSize/2), width:CGFloat(wakuSize), height:CGFloat(wakuSize)))
        Theme2TextField.layer.borderWidth = 1
        Theme2TextField.layer.borderColor = UIColor.lightGray.cgColor
        Theme2TextField.backgroundColor = UIColor.green
        view.addSubview(Theme2TextField)

        Theme2TextField.delegate = self
        var index_i = 0
        for (x,y) in vector {
            // 要素の作成
            let WakuTextField: UITextView = UITextView(frame: CGRect(x: self.view.center.x-CGFloat(vector_len+(wakuSize+3)*x), y:self.view.center.y-CGFloat(vector_len+(wakuSize+3)*y), width:CGFloat(wakuSize), height:CGFloat(wakuSize)))
            WakuTextField.layer.borderWidth = 1
            WakuTextField.layer.borderColor = UIColor.lightGray.cgColor
            WakuTextField.backgroundColor = UIColor.yellow
//            WakuTextField.delegate = self
            ElementArray.append(WakuTextField)
            view.addSubview(ElementArray[index_i])

            
            // 要素を周りに配置(新しい中心)
            let Waku2TextField: UITextView = UITextView(frame: CGRect(x: self.view.center.x-CGFloat(vector_len+(wakuSize+3)*3*x), y:self.view.center.y-CGFloat(vector_len+(wakuSize+3)*3*y), width:CGFloat(wakuSize), height:CGFloat(wakuSize)))
            Waku2TextField.layer.borderWidth = 1
            Waku2TextField.layer.borderColor = UIColor.lightGray.cgColor
            Waku2TextField.backgroundColor = UIColor.yellow
//            Waku2TextField.delegate = self
            ElementRoundArray.append(Waku2TextField)
            view.addSubview(ElementRoundArray[index_i])
//            ElementRoundArray[index_i].delegate = self
            // 詳細枠の作成
            var index_j = 0
            for (xx,yy) in vector {
                let Waku3TextField: UITextView = UITextView(frame: CGRect(x: self.view.center.x-CGFloat(vector_len+(wakuSize+3)*3*x+(wakuSize+3)*xx), y:self.view.center.y-CGFloat(vector_len+(wakuSize+3)*3*y+(wakuSize+3)*yy), width:CGFloat(wakuSize), height:CGFloat(wakuSize)))
                Waku3TextField.layer.borderWidth = 1
                Waku3TextField.layer.borderColor = UIColor.lightGray.cgColor
                Waku3TextField.backgroundColor = UIColor.lightGray
                DetailArray[index_i].append(Waku3TextField)
                view.addSubview(DetailArray[index_i][index_j])
                DetailArray.append([])
                index_j += 1
            }
            index_i += 1
            
            for element in ElementArray {
                element.delegate = self
            }
            for elementRound in ElementRoundArray {
                elementRound.delegate = self
            }
            
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textViewDidChange(_ ThemeTextField: UITextView) {
        Theme2TextField.text = ThemeTextField.text
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
