//
//  SiritoriTopViewController.swift
//  iosDeKasegu
//
//  Created by 高木広大 on 2018/07/12.
//  Copyright © 2018年 shonanhiratsuka. All rights reserved.
//

import UIKit
import GoogleMobileAds

let sectionTitle = ["パーソナルボード"]
var section0     = [("しりとり法を使ってみよう","チュートリアル")]
var tableData    = [section0]

class SiritoriThemeViewController: BaseThemeViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 親クラスの変数を自分の画面に合わせて定義すなおす
        // 次の画面のID
        self.nextSegueId = "toSiritoriWork"
        self.guideSegueId = "toSiritoriGuide"
        // 保存されているテーマのKey
        self.themeKey = "SiritoriTheme"
        self.navigationItem.title = "アイデア発想";
        themeTableView.frame      = CGRect(x: 50, y:100, width:240, height:400)
        // ここまで

        themeTableView.delegate   = self
        themeTableView.dataSource = self

        // 保存されているデータの読み込み
        loadSavedTheme()

        // テーブルを追加
        self.view.addSubview(themeTableView)
        
        // To display the advertisement on scrollView
        displayAdvertisement()
    }
    
    
    @IBAction func tapAddButton(_ sender: Any) {
        let alertController = UIAlertController(title: "テーマを追加",message:"テーマを入力して下さい",preferredStyle:UIAlertControllerStyle.alert)
        alertController.addTextField(configurationHandler: nil)
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .none
        let now = Date()
        let okAction = UIAlertAction(title:"OK",style: UIAlertActionStyle.default){(action:UIAlertAction) in
            if let textField = alertController.textFields?.first {  // ?? .first
                let stub:String = textField.text!
                if (stub.isEmpty) {
                    // XXX: 入力されてなかったときの処理
                } else {
                    // テーマの保存
                    var forSaveTheme:[String] = self.readTheme()
                    forSaveTheme.append(textField.text!)
                    self.saveTheme(forSaveTheme)
                    // セルの追加
                    section0.insert((textField.text!, f.string(from: now)), at: section0.count)
                    tableData = [section0]
                    self.themeTableView.insertRows(at: [IndexPath(row: section0.count-1, section: 0)], with: UITableViewRowAnimation.right)
                    //self.themeTableView.reloadData()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        // 画面遷移
                        self.sendIndexData = section0.count-1
                        self.performSegue(withIdentifier: self.nextSegueId, sender: nil)
                    }
                }
            }
        }
        alertController.addAction(okAction)
        
        let cancelButton = UIAlertAction(title: "CANCEL",style:UIAlertActionStyle.cancel, handler: nil)
        alertController.addAction(cancelButton)
        
        present(alertController, animated: true, completion: nil)
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
