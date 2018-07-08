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
    @IBOutlet weak var waku1: UITextView!
    @IBOutlet weak var Center6: UITextView!
    
    @IBOutlet weak var RightCenter5: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Center6.delegate = self
        
        RightCenter5.delegate = self

        waku1.layer.borderColor = UIColor.black.cgColor
        
        // 枠の幅
        waku1.layer.borderWidth = 1.0
    }
    
    func textViewDidChange(_ Center6: UITextView) {
        RightCenter5.text = Center6.text;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


}
