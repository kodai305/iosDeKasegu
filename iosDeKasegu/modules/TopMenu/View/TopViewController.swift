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
    
    @IBOutlet weak var Expand: UIButton!
    @IBOutlet weak var GetIdea: UIButton!
    @IBOutlet weak var Tutorial: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.showAd()
    }
}

extension TopViewController:TopMenuView {
    func showSiritoriTheme() {
        self.presenter.selectMenu(selectedTopMenuType: .siritori)
    }
    
    func showMandaraTheme() {
        self.presenter.selectMenu(selectedTopMenuType: .mandara)
    }
    
    func showTutorialTheme() {
        self.presenter.selectMenu(selectedTopMenuType: .tutorial)
    }
    
}

extension TopViewController {
    @IBAction func tapSiritoriButton(_ sender: Any) {
        self.showSiritoriTheme()
    }
    
    @IBAction func tapMandaraButton(_ sender: Any) {
        self.showMandaraTheme()
    }
    
    @IBAction func tapTutorialButton(_ sender: Any) {
        self.showTutorialTheme()
    }
}

extension TopViewController {
    fileprivate func configure() {
        //ボタンに使う画像を設定
        let ImageOfGetIdea :UIImage? = UIImage(named:"getidea.png")
        let ImageOfExpand:UIImage? = UIImage(named:"expand.png")
        let ImageOfTutorial :UIImage? = UIImage(named:"tutorial.png")
        //サイズ、位置を動的に動かすためにUIImageViewにセット
        let ExpandImageView = UIImageView(image: ImageOfExpand)
        let TutorialImageView = UIImageView(image: ImageOfTutorial)
        
        //ボタンの大きさ、ボタン間の距離を動的に設定
        let Width :CGFloat = self.view.frame.width
        let Height :CGFloat = self.view.frame.height / 4
        let margin :CGFloat = Height / 10
        
        //表題
        let Title =  UILabel(frame: CGRect(x:0,y:margin * 2,width:Width,height:Height/2.5))
        Title.text = "Fast Idea"
        Title.font = UIFont(name: "Futura-Medium", size: 35)
        Title.numberOfLines = 0
        Title.textAlignment = NSTextAlignment.center
        Title.baselineAdjustment = UIBaselineAdjustment.alignCenters
        Title.backgroundColor = UIColor(hex: "ECF0F1")
        self.view.addSubview(Title)
        
        //アイデアを発想ボタンの設定
        GetIdea.frame = CGRect(x:0, y : Title.frame.origin.y + Title.frame.height, width:Width,height:Height)
        GetIdea.backgroundColor = UIColor(hex: "F4D03F")
        //ボタンに使う画像の縮尺率を算出
        let GetIdeaImageView = UIImageView(image: ImageOfGetIdea)
        var Image_Scale :CGFloat = GetIdea.frame.height / GetIdeaImageView.frame.size.height * 3 / 5
        GetIdeaImageView.frame.size  = CGSize(width:GetIdeaImageView.frame.size.width * Image_Scale,height:GetIdeaImageView.frame.size.height * Image_Scale)
        GetIdeaImageView.center = CGPoint(x:GetIdea.frame.width / 2, y : GetIdea.frame.height * 2 / 5)
        GetIdea.addSubview(GetIdeaImageView)
        //ボタンの文字の設定
        let GetIdeaTitle = UILabel(frame: CGRect(x:0,y:GetIdeaImageView.frame.origin.y + GetIdeaImageView.frame.height,width:Width,height:Height * 3 / 10))
        GetIdeaTitle.text = "Get an idea"
        GetIdeaTitle.font = UIFont(name: "Futura-Medium", size: 22)
        GetIdeaTitle.textColor = UIColor(hex: "ECF0F1")
        GetIdeaTitle.adjustsFontSizeToFitWidth = true
        GetIdeaTitle.textAlignment = NSTextAlignment.center
        GetIdea.addSubview(GetIdeaTitle)
        
        //アイデアを拡大ボタンの設定
        Expand.frame = CGRect(x:0, y:GetIdea.frame.origin.y + Height,width:Width, height:Height)
        Expand.backgroundColor = UIColor(hex: "59ABE3")
        //ボタンに使う画像の縮尺率を算出
        Image_Scale = Expand.frame.height / ExpandImageView.frame.size.height * 3 / 5
        ExpandImageView.frame.size  = CGSize(width:ExpandImageView.frame.size.width * Image_Scale,height:ExpandImageView.frame.size.height * Image_Scale)
        ExpandImageView.center = CGPoint(x:Expand.frame.width / 2, y : Expand.frame.height * 2 / 5)
        Expand.addSubview(ExpandImageView)
        //ボタンの文字の設定
        let ExpandTitle = UILabel(frame: CGRect(x:0,y:ExpandImageView.frame.origin.y + ExpandImageView.frame.height,width:Width,height:Height * 3 / 10))
        ExpandTitle.text = "Expand on an idea"
        ExpandTitle.font = UIFont(name: "Futura-Medium", size: 22)
        ExpandTitle.textColor = UIColor(hex: "ECF0F1")
        ExpandTitle.adjustsFontSizeToFitWidth = true
        ExpandTitle.textAlignment = NSTextAlignment.center
        Expand.addSubview(ExpandTitle)
        
        //チュートリアルボタンの設定
        Tutorial.frame = CGRect(x:0, y:Expand.frame.origin.y + Height,width:Width, height:Height)
        Tutorial.backgroundColor = UIColor(hex: "E08283")
        //ボタンに使う画像の縮尺率を算出
        Image_Scale = Tutorial.frame.height / TutorialImageView.frame.size.height * 3 / 5
        TutorialImageView.frame.size  = CGSize(width:TutorialImageView.frame.size.width * Image_Scale,height:TutorialImageView.frame.size.height * Image_Scale)
        TutorialImageView.center = CGPoint(x:Tutorial.frame.width / 2, y : Tutorial.frame.height * 2 / 5)
        Tutorial.addSubview(TutorialImageView)
        //ボタンの文字の設定
        let TutorialTitle = UILabel(frame: CGRect(x:0,y:TutorialImageView.frame.origin.y + TutorialImageView.frame.height,width:Width,height:Height * 3 / 10))
        TutorialTitle.text = "Tutorial"
        TutorialTitle.font = UIFont(name: "Futura-Medium", size: 22)
        TutorialTitle.textColor = UIColor(hex: "ECF0F1")
        TutorialTitle.adjustsFontSizeToFitWidth = true
        TutorialTitle.textAlignment = NSTextAlignment.center
        Tutorial.addSubview(TutorialTitle)
    }
    
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

