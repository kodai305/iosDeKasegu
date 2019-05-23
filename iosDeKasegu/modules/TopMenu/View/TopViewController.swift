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
    
    // Presenterへのアクセスはprotocolを介して行う
    var presenter: TopMenuPresentable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showAd()
    }
}

extension TopViewController:TopMenuView {
    func showSiritoriThemes() {
        self.presenter.selectMenu(selectedTopMenuType: .siritori)
    }
    
    func showMandaraThemes() {
        self.presenter.selectMenu(selectedTopMenuType: .mandara)
    }
    
    func showSixHatsThemes() {
        self.presenter.selectMenu(selectedTopMenuType: .sixHats)
    }
    
    func showOsborneThemes() {
        self.presenter.selectMenu(selectedTopMenuType: .osborne)
    }
    
    func showTutorial() {
        self.presenter.selectMenu(selectedTopMenuType: .tutorial)
    }
    
}

extension TopViewController {
    @IBAction func tapSiritoriButton(_ sender: Any) {
        self.showSiritoriThemes()
    }
    
    @IBAction func tapMandaraButton(_ sender: Any) {
        self.showMandaraThemes()
    }
    
    @IBAction func tapSixHatsButton(_ sender: Any) {
        self.showSixHatsThemes()
    }
    
    @IBAction func tapOsborneButton(_ sender: Any) {
        self.showOsborneThemes()
    }
    
    @IBAction func tapTutorialButton(_ sender: Any) {
        self.showTutorial()
    }
}

extension TopViewController {
    fileprivate func showAd() {
        // To display the advertisement
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = admob_id
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        addBannerViewToView(bannerView)
    }
}

