//
//  MandaraThemeViewController.swift
//  iosDeKasegu
//
//  Created by 高木広大 on 2018/07/16.
//  Copyright © 2018年 shonanhiratsuka. All rights reserved.
//

import UIKit
import GoogleMobileAds

let sectionMandaraTitle = ["パーソナルボード"]
var sectionMandara0     = [("しりとり法を使ってみよう","チュートリアル")]
var tableMandaraData    = [sectionMandara0]

class MandaraThemeViewController: BaseThemeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 次の画面のID
        self.nextSegueId = "toMandaraWork"
        self.guideSegueId = "toMandaraGuide"
        // 保存されているテーマのKey
        self.themeKey = "MandaraTheme"
        self.navigationItem.title = "アイデア拡散";
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
        // Do any additional setup after loading the view.
    }

    
    @IBAction func plusButtonTapped(_ sender: Any) {
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
                    sectionMandara0.insert((textField.text!, f.string(from: now)), at: sectionMandara0.count)
                    tableData = [sectionMandara0]
                    self.themeTableView.insertRows(at: [IndexPath(row: sectionMandara0.count-1, section: 0)], with: UITableViewRowAnimation.right)
                    //self.themeTableView.reloadData()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        // 画面遷移
                        self.sendIndexData = sectionMandara0.count-1
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if segue.identifier == self.nextSegueId {
            let nextView:SampleViewController = segue.destination as! SampleViewController
            let theme:[String]     = self.readTheme()
//            nextView.cellIndex     = self.sendIndexData
            print(theme)
//            nextView.siritoriTheme = theme[self.sendIndexData-1] //indexがややわかりにくい
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
