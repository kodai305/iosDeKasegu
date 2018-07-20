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
    
    @IBOutlet weak var Expand: UIButton!
    @IBOutlet weak var GetIdea: UIButton!
    @IBOutlet weak var Tutorial: UIButton!
    
    //ボタンに使う画像を設定
    let ImageOfGetIdea :UIImage? = UIImage(named:"getidea.png")
    let ImageOfExpand:UIImage? = UIImage(named:"expand.png")
    let ImageOfTutorial :UIImage? = UIImage(named:"tutorial.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //サイズ、位置を動的に動かすためにUIImageViewにセット
        let GetIdeaImageView = UIImageView(image: ImageOfGetIdea)
        let ExpandImageView = UIImageView(image: ImageOfExpand)
        let TutorialImageView = UIImageView(image: ImageOfTutorial)
        
        //ボタンの大きさ、ボタン間の距離を動的に設定
        let Width :CGFloat = self.view.frame.width * 4 / 5
        let Height :CGFloat = self.view.frame.height / 4
        let margin :CGFloat = Height / 10
        
        //アイデアを発想ボタンの設定
        GetIdea.frame = CGRect(x:self.view.frame.width / 10, y : self.view.frame.height / 8, width:Width,height:Height)
        //ボタンに使う画像の縮尺率を算出
        var Image_Scale :CGFloat = GetIdea.frame.height / GetIdeaImageView.frame.size.height * 3 / 5
        GetIdeaImageView.frame.size  = CGSize(width:GetIdeaImageView.frame.size.width * Image_Scale,height:GetIdeaImageView.frame.size.height * Image_Scale)
        GetIdeaImageView.center = CGPoint(x:GetIdea.frame.width / 2, y : GetIdea.frame.height * 2 / 5)
        GetIdea.addSubview(GetIdeaImageView)
        //ボタンの文字の設定
        GetIdea.setTitle("アイデアを発想", for: UIControlState.normal)
        GetIdea.setTitleColor(UIColor.black, for: UIControlState.normal)
        GetIdea.titleEdgeInsets = UIEdgeInsetsMake(0.8 * Height, 0, 0, 0)
        //ボタンの角を丸くする
        GetIdea.layer.cornerRadius = 21.0
        
        //アイデアを拡大ボタンの設定
        Expand.frame = CGRect(x:self.view.frame.width / 10, y:GetIdea.frame.origin.y + Height + margin,width:Width, height:Height)
        //ボタンに使う画像の縮尺率を算出
        Image_Scale = Expand.frame.height / ExpandImageView.frame.size.height * 3 / 5
        ExpandImageView.frame.size  = CGSize(width:ExpandImageView.frame.size.width * Image_Scale,height:ExpandImageView.frame.size.height * Image_Scale)
        ExpandImageView.center = CGPoint(x:Expand.frame.width / 2, y : Expand.frame.height * 2 / 5)
        Expand.addSubview(ExpandImageView)
        //ボタンの文字の設定
        Expand.setTitle("アイデアを拡大", for: UIControlState.normal)
        Expand.setTitleColor(UIColor.black, for: UIControlState.normal)
        Expand.titleEdgeInsets = UIEdgeInsetsMake(0.8 * Height, 0, 0, 0)
        //ボタンの角を丸くする
        Expand.layer.cornerRadius = 21.0
        
        //チュートリアルボタンの設定
        Tutorial.frame = CGRect(x:self.view.frame.width / 10, y:Expand.frame.origin.y + Height + margin,width:Width, height:Height)
        //ボタンに使う画像の縮尺率を算出
        Image_Scale = Tutorial.frame.height / TutorialImageView.frame.size.height * 3 / 5
        TutorialImageView.frame.size  = CGSize(width:TutorialImageView.frame.size.width * Image_Scale,height:TutorialImageView.frame.size.height * Image_Scale)
        TutorialImageView.center = CGPoint(x:Tutorial.frame.width / 2, y : Tutorial.frame.height * 2 / 5)
        Tutorial.addSubview(TutorialImageView)
        //ボタンの文字の設定
        Tutorial.setTitle("チュートリアル", for: UIControlState.normal)
        Tutorial.setTitleColor(UIColor.black, for: UIControlState.normal)
        Tutorial.titleEdgeInsets = UIEdgeInsetsMake(0.8 * Height, 0, 0, 0)
        //ボタンの角を丸くする
        Tutorial.layer.cornerRadius = 21.0
        
        
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

