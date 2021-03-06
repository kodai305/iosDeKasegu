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
    var section0:[(String,String,Int)] = []
    var tableData:[[(String,String,Int)]] = [[]]

    // overrideする変数 // XXX:ベストなやり方かは微妙
    // 遷移先に送るデータ
    var sendIndexData:Int = 0
    // 次の画面のID
    var nextSegueId:String = ""
    var methodType:MethodType!
    // 保存するデータ
    var themeKey:String = ""
    struct themeData: Codable {
        var theme   :String = ""
        var editdata:Date
        var key     :Int
    }

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
        //チュートリアルのセルの色を設定（EBONY CLAY）
        if(indexPath.row == 0){
            cell.backgroundColor = UIColor(hex: "22313F", alpha: 1.0)
            cell.textLabel?.textColor = UIColor.white
            cell.layer.borderWidth = 3
            cell.layer.borderColor = UIColor(hex: "ECF0F1", alpha: 1.0).cgColor
        }
        //テーマのセルの色を設定(PORCELAIN)
        else{
            cell.backgroundColor = UIColor.white
            cell.layer.borderWidth = 3
            cell.layer.borderColor = UIColor(hex: "ECF0F1", alpha: 1.0).cgColor
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
    func readTheme() -> ([themeData]) {
        let defaults = UserDefaults.standard
        let stubArray:[themeData] = []
        guard let data = defaults.data(forKey: themeKey) else {
            return stubArray
        }
        let savedData = try? JSONDecoder().decode([themeData].self, from: data)
        return savedData!
    }
    func saveTheme(_ theme: [themeData]) {
        let defaults = UserDefaults.standard
        let data = try? JSONEncoder().encode(theme)
        defaults.set(data, forKey: themeKey)
    }

    // タップしたときの処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //セルの選択解除
        tableView.deselectRow(at: indexPath, animated: true)
        //画面遷移
        if (indexPath.row == 0) { // 0番目がタップされたとき
            self.showTutotialFromThemes(methodType: self.methodType)
        } else {
            //デバック用
            let format = DateFormatter()
            format.dateFormat = "yyyy/MM/dd HH:mm:ss.SSS"
            print("cell tapped!!!")
            print(format.string(from: Date()))
            // 遷移先に送るデータの更新
            self.sendIndexData = section0[indexPath.row].2
            self.performSegue(withIdentifier: self.nextSegueId, sender: nil)
        }
    }
    
    // テーマの読込
    func loadSavedTheme() {
        guard (section0.count <= 1) else {
            return
        }
        let ThemeData:[themeData] = readTheme()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        if (!ThemeData.isEmpty) {
            for data in ThemeData {
                section0.insert((data.theme, formatter.string(from: data.editdata), data.key), at: section0.count)
                tableData = [section0]
                self.themeTableView.insertRows(at: [IndexPath(row: section0.count-1, section: 0)], with: UITableView.RowAnimation.right)
            }
        }
    }
    
    // セグエで画面移動の際にデータを渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {

    }
    
    //セルが編集可能であるかどうかをReturn（セルの中身ではない）
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //セルを削除した時の処理
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //削除処理かどうかを判定
        if editingStyle == UITableViewCell.EditingStyle.delete{
            //テーマリストからセルを削除
            section0.remove(at: indexPath.row)
            tableData = [section0]
            //セルを削除
            themeTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            //保存しているデータを修正
            var forSaveTheme:[themeData] = self.readTheme()
            forSaveTheme.remove(at: indexPath.row - 1)
            self.saveTheme(forSaveTheme)
        }
    }
    
    fileprivate func showTutotialFromThemes(methodType:MethodType) {
        switch methodType {
        case .Siritori:
            let storyboard = UIStoryboard(name: "Tutorial", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "SiritoriGuideViewController") as! SiritoriGuideViewController
            self.navigationController?.pushViewController(destinationVC, animated: true)
        case .Mandara:
            let storyboard = UIStoryboard(name: "Tutorial", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "MandaraGuideViewController") as! MandaraGuideViewController
            self.navigationController?.pushViewController(destinationVC, animated: true)
        case .SixHats:
            ()
        case .Osborne:
            ()
        }
    }

}
