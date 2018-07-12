//
//  SiritoriTopViewController.swift
//  iosDeKasegu
//
//  Created by 高木広大 on 2018/07/12.
//  Copyright © 2018年 shonanhiratsuka. All rights reserved.
//

import UIKit

let sectionTitle = ["パーソナルボード"]
let section0     = [("しりとり法を使ってみよう","チュートリアル"),("テーマ1","sample")]
let tableData    = [section0]

class SiritoriTopViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    

    //テーブルビューインスタンス作成
    var siritoriTableView: UITableView  =   UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "アイデア発想";
        
        siritoriTableView.frame      = CGRect(x: 50, y:100, width:240, height:200)
        siritoriTableView.delegate   = self
        siritoriTableView.dataSource = self
        
        self.view.addSubview(siritoriTableView)
        // Do any additional setup after loading the view.
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
            self.performSegue(withIdentifier: "toSiritoriTheme", sender: nil)
        }

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
