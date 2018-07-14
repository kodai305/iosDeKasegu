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

class SiritoriTopViewController: BaseViewController,UITableViewDelegate, UITableViewDataSource {
    // 遷移先に送るデータ
    var sendIndexData:Int = 0

    // 広告バナー作成
    var bannerView: GADBannerView!
    //テーブルビューインスタンス作成
    var siritoriTableView: UITableView  =   UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "アイデア発想";
        
        siritoriTableView.frame      = CGRect(x: 50, y:100, width:240, height:400)
        siritoriTableView.delegate   = self
        siritoriTableView.dataSource = self
        
        // 保存されているデータの読み込み
        let Theme:[String] = readTheme()
        if (!Theme.isEmpty) {
            for theme in Theme {
                section0.insert((theme, "dammy"), at: section0.count)
                tableData = [section0]
                self.siritoriTableView.insertRows(at: [IndexPath(row: section0.count-1, section: 0)], with: UITableViewRowAnimation.right)
            }
        }
        
        self.view.addSubview(siritoriTableView)
        // Do any additional setup after loading the view.
        
        // To display the advertisement on scrollView
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = admob_id
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        addBannerViewToView(bannerView)
    }
    
    // セルを作る
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let sectionData = tableData[(indexPath as NSIndexPath).section]
        let cellData = sectionData[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = cellData.0
        cell.detailTextLabel?.text = cellData.1
        return cell
    }
    
    // セクションごとの行数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionData = tableData[section]
        return sectionData.count
    }

    // セクション数を決める
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    // セクションのタイトル
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    // タップしたときの処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //セルの選択解除
        tableView.deselectRow(at: indexPath, animated: true)
        //画面遷移
        if (indexPath.row == 0) { // 0番目がタップされたとき
            self.performSegue(withIdentifier: "toSiritoriGuide", sender: nil)
        } else {
            // 遷移先に送るデータの更新
            self.sendIndexData = indexPath.row
            self.performSegue(withIdentifier: "toSiritoriWork", sender: nil)
        }
    }
    
    // データの保存・読み取り
    func readTheme() -> ([String]) {
        let dammy:[String] = []
        let defaults = UserDefaults.standard
        if let stub:[String] = defaults.array(forKey: "SiritoriTheme") as? [String] {
            return stub
        } else {
            return dammy
        }
    }
    func saveTheme(_ theme: [String]) {
        let defaults = UserDefaults.standard
        defaults.set(theme, forKey: "SiritoriTheme")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                    self.siritoriTableView.insertRows(at: [IndexPath(row: section0.count-1, section: 0)], with: UITableViewRowAnimation.right)
                    //self.siritoriTableView.reloadData()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        // 画面遷移
                        self.sendIndexData = section0.count-1
                        self.performSegue(withIdentifier: "toSiritoriWork", sender: nil)
                    }
                }
            }
        }
        alertController.addAction(okAction)
        
        let cancelButton = UIAlertAction(title: "CANCEL",style:UIAlertActionStyle.cancel, handler: nil)
        alertController.addAction(cancelButton)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // セグエで画面移動の際にデータを渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if segue.identifier == "toSiritoriWork" {
            let nextView:SiritoriWorkViewController = segue.destination as! SiritoriWorkViewController
            let theme:[String]     = self.readTheme()
            nextView.cellIndex     = self.sendIndexData
            print(theme)
            nextView.siritoriTheme = theme[self.sendIndexData-1] //indexがややわかりにくい
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
