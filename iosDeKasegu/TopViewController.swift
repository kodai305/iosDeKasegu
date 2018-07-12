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
    
    @IBOutlet weak var Expand: UIButton!
    @IBOutlet weak var GetIdea: UIButton!
    @IBOutlet weak var Tutorial: UIButton!
    
    let GetIdeaImageDefault :UIImage? = UIImage(named:"getidea.png")
    let buttonImageDefault:UIImage? = UIImage(named:"expand.png")
    let TutorialImageDefault :UIImage? = UIImage(named:"tutorial.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //アイデアを発想ボタンの設定
        GetIdea.setImage(GetIdeaImageDefault!, for: [])
        GetIdea.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        GetIdea.layer.cornerRadius = 20.0
        //アイデアを拡大ボタンの
        Expand.setImage(buttonImageDefault!, for: [])
        Expand.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        Expand.layer.cornerRadius = 20.0
        //チュートリアルボタンの設定
        Tutorial.setImage(TutorialImageDefault!, for: [])
        Tutorial.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        Tutorial.layer.cornerRadius = 20.0
        
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

