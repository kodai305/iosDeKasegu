//
//  MandaraThemeViewController.swift
//  iosDeKasegu
//
//  Created by 高木広大 on 2018/07/16.
//  Copyright © 2018年 shonanhiratsuka. All rights reserved.
//

import UIKit
import GoogleMobileAds

class MandaraThemeViewController: BaseThemeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 次の画面のID
        self.nextSegueId = "toMandaraWork"
        self.methodType = .Mandara
        // 保存されているテーマのKey
        self.themeKey = "MandaraTheme"
        self.navigationItem.title = "Theme List"
        themeTableView.frame.size      = CGSize(width:self.view.frame.size.width * 9 / 10, height:self.view.frame.size.height * 4 / 5)
        themeTableView.center.x = self.view.center.x
        themeTableView.frame.origin.y = self.navigationController!.navigationBar.frame.origin.y + self.navigationController!.navigationBar.frame.size.height + 20
        themeTableView.backgroundColor = UIColor(hex: "ECF0F1")
        if (self.tableData.count == 1) {
            // 最初のセルの中身
            print("called first cell")
            self.section0  = [("マンダラチャートを使う","チュートリアルを見る",0)]
            self.tableData = [self.section0]
        }
        
        themeTableView.delegate   = self
        themeTableView.dataSource = self
        themeTableView.tableFooterView = UIView()
        
        // 保存されているデータの読み込み
        loadSavedTheme()
        
        // テーブルを追加
        self.view.addSubview(themeTableView)
        
        // To display the advertisement on scrollView
        displayAdvertisement()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func plusButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "テーマを追加",message:"テーマを入力して下さい",preferredStyle:UIAlertController.Style.alert)
        alertController.addTextField(configurationHandler: nil)

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let okAction = UIAlertAction(title:"OK",style: UIAlertAction.Style.default){(action:UIAlertAction) in
            if let textField = alertController.textFields?.first {  // ?? .first
                let stub:String = textField.text!
                if (stub.isEmpty) {
                    // XXX: 入力されてなかったときの処理
                } else {
                    // テーマの保存
                    var forSaveTheme:[themeData] = self.readTheme()
                    //キーとして使うためにUNIXTime取得
                    let UNIXTime = Int(Date.timeIntervalSinceReferenceDate)
                    let EditData = Date()
                    let stub = themeData(theme: textField.text!, editdata: EditData,key: UNIXTime)
                    forSaveTheme.append(stub)
                    self.saveTheme(forSaveTheme)
                    
                    // セルの追加
                    self.section0.insert((textField.text!, formatter.string(from: EditData),UNIXTime), at: self.section0.count)
                    self.tableData = [self.section0]
                    self.themeTableView.insertRows(at: [IndexPath(row: self.section0.count-1, section: 0)], with: UITableView.RowAnimation.right)
                    //self.themeTableView.reloadData()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        // 画面遷移
                        self.sendIndexData = UNIXTime
                        self.performSegue(withIdentifier: self.nextSegueId, sender: nil)
                    }
                }
            }
        }
        alertController.addAction(okAction)
        
        let cancelButton = UIAlertAction(title: "CANCEL",style:UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(cancelButton)
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if segue.identifier == self.nextSegueId {
            let nextView:MandaraWorkViewController = segue.destination as! MandaraWorkViewController
            let savedThemeData:[themeData]     = self.readTheme()
            nextView.cellIndex        = self.sendIndexData
            print(savedThemeData)
            //タップしたセルとkeyが同じデータを探す
            for n in 0..<section0.count{
                if(section0[n].2 == self.sendIndexData){
                    nextView.mandaraTheme = section0[n].0
                }
            }
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
