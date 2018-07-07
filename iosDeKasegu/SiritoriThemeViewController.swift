//
//  SiritoriViewController.swift
//  iosDeKasegu
//
//  Created by 高木広大 on 2018/07/01.
//  Copyright © 2018年 shonanhiratsuka. All rights reserved.
//

import UIKit
import GoogleMobileAds

var siritoriTheme = ""

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
        siritoriTheme = self.themeUITextView.text
        print(siritoriTheme)

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
        
    }
    func hello(_ msg:String) {
        print(msg)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Display the description
        sublabel.backgroundColor = UIColor.white
        sublabel.text = "テーマを入力してください.\n例：新しいアプリのアイデア"

        // To display the advertisement
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = admob_id
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        addBannerViewToView(bannerView)
        
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
