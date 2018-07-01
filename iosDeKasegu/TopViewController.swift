//
//  ViewController.swift
//  iosDeKasegu
//
//  Created by 高木広大 on 2018/06/29.
//  Copyright © 2018年 shonanhiratsuka. All rights reserved.
//

import UIKit
import GoogleMobileAds

class TopViewController: BaseViewController {
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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


}

