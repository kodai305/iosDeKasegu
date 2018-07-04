//
//  MandaraWorkTableViewController.swift
//  iosDeKasegu
//
//  Created by user on 2018/07/04.
//  Copyright © 2018年 shonanhiratsuka. All rights reserved.
//

import UIKit
import GoogleMobileAds

class MandaraWorkTableViewController: BaseViewController {
    var bannerView: GADBannerView!
    
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var waku1: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        waku1.layer.borderColor = UIColor.red.cgColor
        
        // 枠の幅
        waku1.layer.borderWidth = 1.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


}
