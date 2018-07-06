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
    
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var waku1: UITextView!
    @IBOutlet weak var waku2: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        waku1.delegate = self
        waku2.delegate = self

        waku1.layer.borderColor = UIColor.red.cgColor
        
        // 枠の幅
        waku1.layer.borderWidth = 1.0
    }
    
    func textViewDidChange(_ waku1: UITextView) {
        waku2.text = waku1.text;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


}
