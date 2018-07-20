//
//  BaseThemeViewController.swift
//  iosDeKasegu
//
//  Created by 高木広大 on 2018/07/15.
//  Copyright © 2018年 shonanhiratsuka. All rights reserved.
//

import UIKit
import GoogleMobileAds

class BaseThemeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    let sectionTitle = ["パーソナルボード"]
    var section0:[(String,String)] = []
    var tableData:[[(String,String)]] = [[]]

    // overrideする変数 // XXX:ベストなやり方かは微妙
    // 遷移先に送るデータ
    var sendIndexData:Int = 0
    // 次の画面のID
    var nextSegueId:String = ""
    var guideSegueId:String = ""
    // テーマのKey
    var themeKey:String = ""
    //テーブルビューインスタンス作成
    var themeTableView: UITableView = UITableView()
    // セルを作る
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let sectionData = tableData[(indexPath as NSIndexPath).section]
        let cellData = sectionData[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = cellData.0
        cell.detailTextLabel?.text = cellData.1
        cell.layoutMargins = UIEdgeInsets.zero
        //チュートリアルのセルの色を設定（MADANG）
        if(indexPath.row == 0){
            cell.backgroundColor = UIColor(hex: "C8F7C5", alpha: 1.0)
            cell.layer.borderWidth = 2.5
        }
        //テーマのセルの色を設定(CAPE HONEY)
        else{
            cell.backgroundColor = UIColor(hex: "FDE3A7", alpha: 1.0)
            cell.layer.borderWidth = 1.0
        }
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
    /**
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    **/
    
    // データの保存・読み取り
    func readTheme() -> ([String]) {
        let dammy:[String] = []
        let defaults = UserDefaults.standard
        if let stub:[String] = defaults.array(forKey: themeKey) as? [String] {
            return stub
        } else {
            return dammy
        }
    }
    func saveTheme(_ theme: [String]) {
        let defaults = UserDefaults.standard
        defaults.set(theme, forKey: themeKey)
    }

    // タップしたときの処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //セルの選択解除
        tableView.deselectRow(at: indexPath, animated: true)
        //画面遷移
        if (indexPath.row == 0) { // 0番目がタップされたとき
            self.performSegue(withIdentifier: self.guideSegueId, sender: nil)
        } else {
            // 遷移先に送るデータの更新
            self.sendIndexData = indexPath.row
            self.performSegue(withIdentifier: self.nextSegueId, sender: nil)
        }
    }
    
    // テーマの読込
    func loadSavedTheme() {
        guard (section0.count <= 1) else {
            return
        }
        let Theme:[String] = readTheme()
        if (!Theme.isEmpty) {
            for theme in Theme {
                section0.insert((theme, "dammy"), at: section0.count)
                tableData = [section0]
                self.themeTableView.insertRows(at: [IndexPath(row: section0.count-1, section: 0)], with: UITableViewRowAnimation.right)
            }
        }
    }
    
    // セグエで画面移動の際にデータを渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {

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
