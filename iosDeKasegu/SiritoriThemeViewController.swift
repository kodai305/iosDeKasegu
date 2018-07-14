//
//  SiritoriViewController.swift
//  iosDeKasegu
//
//  Created by 高木広大 on 2018/07/01.
//  Copyright © 2018年 shonanhiratsuka. All rights reserved.
//

import UIKit
import GoogleMobileAds



var siritoriTheme:String!

class SiritoriThemeViewController: BaseViewController {
    var bannerView: GADBannerView!


    
    @IBAction func viewTap(_ sender: UITapGestureRecognizer) {
        // タップされたらキーボードを下げる
        view.endEditing(true)
    }
    @IBOutlet weak var sublabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var themeUITextView: UITextView!
    
    @IBAction func next(_ sender: Any) {
        // テーマの保存
        //siritoriTheme = self.themeUITextView.text

        // テーマが入力されていなかったらアラートを出す
        if themeUITextView.text.isEmpty {
            print("hoge")
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
            alert.title = "Ops!!"
            alert.message = "please input a theme!"
            alert.addAction(UIAlertAction(
                title: "back",
                style: .default
                )
            )
            self.present(alert, animated: true)
        }
        saveTheme(themeUITextView.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Display the description ラベル
        sublabel.backgroundColor = UIColor.white
        sublabel.text = "テーマを入力してください.\n例：新しいアプリのアイデア"

        // To display the advertisement
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = admob_id
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        addBannerViewToView(bannerView)
     
        // テスト：クリアボタン
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.layer.borderWidth = 2.0 // 枠線の幅
        button.layer.borderColor = UIColor.red.cgColor // 枠線の色
        button.layer.cornerRadius = 10.0
        button.setTitle("clear", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.frame = CGRect(x: 250, y: 450, width: 80, height: 35)
        button.addTarget(self, action: #selector(self.clear(_:)), for: .touchUpInside)
        view.addSubview(button)

        

        
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "SiritoriTheme") != nil {
            let theme:String = defaults.string(forKey: "SiritoriTheme")!
            print("theme:")
            print(theme)
            themeUITextView.text = theme
        }

        siritoriTheme = themeUITextView.text
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func clear(_ sender: AnyObject) {
        //let button = sender as! UIButton
        SiritoriWorkViewController().resetContents()
    }
                                     
    func saveTheme(_ theme: String) {
        let defaults = UserDefaults.standard
        print("save theme:")
        print(theme)
        defaults.set(theme, forKey: "SiritoriTheme")
    }
    
    func readTheme() -> (String) {
        let defaults = UserDefaults.standard
        let theme:String = defaults.string(forKey: "SiritoriTheme")!
        return theme
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
