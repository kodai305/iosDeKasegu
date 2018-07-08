//
//  MandaraWorkTableViewController.swift
//  iosDeKasegu
//
//  Created by user on 2018/07/04.
//  Copyright © 2018年 shonanhiratsuka. All rights reserved.
//

import UIKit
import GoogleMobileAds

class MandaraWorkTableViewController: BaseViewController,UITextViewDelegate {
    var bannerView: GADBannerView!
    
    @IBAction func TapScreen(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var Center5: UITextView!
    @IBOutlet weak var Center6: UITextView!
    
    @IBOutlet weak var RightCenter5: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefaults = UserDefaults.standard
        if let value = userDefaults.string(forKey: "c6"){
            Center6.text = value
            RightCenter5.text = Center6.text;
        }
        
        Center5.delegate = self
        Center6.delegate = self
        RightCenter5.delegate = self

        //枠線の色と幅を設定
        //waku1.layer.borderColor = UIColor.black.cgColor
        //waku1.layer.borderWidth = 1.0
    }
    
    /*同じ関数を使いたいがエラー
    func textViewDidChange(_ Center5: UITextView) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(Center5.text, forKey: "c5")
        userDefaults.synchronize()
    }
 */
    
    //中央の9x9を周囲の9x9の中央にコピー、変更を保存
    func textViewDidChange(_ Center6: UITextView) {
        RightCenter5.text = Center6.text;
        let userDefaults = UserDefaults.standard
        userDefaults.set(Center6.text, forKey: "c6")
        userDefaults.synchronize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


}
