//
//  MandaraGuideViewController.swift
//  iosDeKasegu
//
//  Created by 高木広大 on 2018/07/16.
//  Copyright © 2018年 shonanhiratsuka. All rights reserved.
//

import UIKit
//import PlaceholderTextView

class MandaraGuideViewController: BaseViewController,UIScrollViewDelegate {
    
    //UIPageControlのインスタンス作成
    let PageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //スクロールビューの大きさ、座標を決める
        let Datum_xOfScrollView:CGFloat = UIScreen.main.bounds.width*0.05
        let Datum_yOfScrollView:CGFloat = UIScreen.main.bounds.height*0.1
        let WidthOfScrollView:CGFloat = UIScreen.main.bounds.width*0.9
        let HeightOfScrollView:CGFloat = UIScreen.main.bounds.height*0.9
        let NumberOfPages:Int = 6
        
        //スクロールビューの設定
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: Datum_xOfScrollView, y: Datum_yOfScrollView, width: WidthOfScrollView, height: HeightOfScrollView)
        //枚数に合わせてwidthの係数を変える
        scrollView.contentSize = CGSize(width: WidthOfScrollView * CGFloat(NumberOfPages), height: HeightOfScrollView)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        
        // しりとり法の説明
        let IntroductionUIView = UIView(frame: CGRect(x: 0, y: 0, width: WidthOfScrollView, height: HeightOfScrollView))
        
        let DetailofIntroduction = UILabel()
        DetailofIntroduction.frame = CGRect(x:0, y: HeightOfScrollView * 0.05 ,width: WidthOfScrollView, height: HeightOfScrollView * 0.3 )
        DetailofIntroduction.text = "マンダラチャートは \n あるアイデアから9つの単語を連想し \n それぞれの単語に関連する \n 単語を9つ考えることで \n アイデアを拡大する方法です \n 下は「りんごを育てるアプリ」の例です"
        //上記の文章の段数と合わせる
        DetailofIntroduction.numberOfLines = 6
        DetailofIntroduction.font = UIFont.systemFont(ofSize: 40.0)
        //横幅に合わせてフォントサイズを自動調整
        DetailofIntroduction.adjustsFontSizeToFitWidth = true
        DetailofIntroduction.minimumScaleFactor = 0.3
        
        let ImageofIntroduction = UIImageView(image: UIImage(named: "MandaraExample.png"))
        ImageofIntroduction.frame.size.width = WidthOfScrollView
        ImageofIntroduction.frame.origin = CGPoint(x: 0, y: HeightOfScrollView * 0.1)
        //元の画像のアスペクト比を保ったまま、画像を縮小
        ImageofIntroduction.contentMode = UIViewContentMode.scaleAspectFit
        
        let DetailofApp = UILabel()
        DetailofApp.frame = CGRect(x:0, y: HeightOfScrollView * 0.65 ,width: WidthOfScrollView, height: HeightOfScrollView * 0.3 )
        DetailofApp.text = "左にスワイプすると \n 詳しいアプリの使い方を見ることが出来ます \n このアプリでは途中経過も保存されるので \n どんどん使いましょう！"
        DetailofApp.numberOfLines = 4
        DetailofApp.font = UIFont.systemFont(ofSize: 40.0)
        DetailofApp.adjustsFontSizeToFitWidth = true
        DetailofApp.minimumScaleFactor = 0.2
        
        IntroductionUIView.addSubview(ImageofIntroduction)
        IntroductionUIView.addSubview(DetailofIntroduction)
        IntroductionUIView.addSubview(DetailofApp)
        scrollView.addSubview(IntroductionUIView)
        
        // 1枚目の画像
        let FirstUIView = UIView(frame: CGRect(x: WidthOfScrollView, y: 0, width: WidthOfScrollView, height: HeightOfScrollView))
        let FirstImage = UIImageView(image: UIImage(named: "MandaraTutorialImage1.png"))
        FirstImage.frame.size.height = HeightOfScrollView * 0.8
        FirstImage.center = CGPoint(x: WidthOfScrollView * 0.5, y: HeightOfScrollView * 0.4)
        FirstImage.contentMode = UIViewContentMode.scaleAspectFit
        
        let FirstLable = UILabel()
        FirstLable.text = "新規テーマ:画面右上の＋ボタン \n 保存テーマ:テーブルの項目 \n をそれぞれタップ"
        FirstLable.numberOfLines = 3
        FirstLable.font = UIFont.systemFont(ofSize: 20.0)
        FirstLable.frame = CGRect(x:0, y: HeightOfScrollView * 0.72,width: WidthOfScrollView, height: HeightOfScrollView * 0.3)
        FirstLable.adjustsFontSizeToFitWidth = true
        FirstLable.minimumScaleFactor = 0.3
        FirstUIView.addSubview(FirstImage)
        FirstUIView.addSubview(FirstLable)
        scrollView.addSubview(FirstUIView)
        
        // 2枚目の画像
        let SecondUIView = UIView(frame: CGRect(x: WidthOfScrollView * 2, y: 0, width: WidthOfScrollView, height: HeightOfScrollView))
        let SecondImage = UIImageView(image: UIImage(named: "MandaraTutorialImage2.png"))
        SecondImage.frame.size.height = HeightOfScrollView * 0.8
        SecondImage.center = CGPoint(x: WidthOfScrollView * 0.5, y: HeightOfScrollView * 0.4)
        SecondImage.contentMode = UIViewContentMode.scaleAspectFit
        
        let SecondLable = UILabel()
        SecondLable.text = "ピンチアウトする事で \n 編集する箇所を拡大できます"
        SecondLable.numberOfLines = 2
        SecondLable.font = UIFont.systemFont(ofSize: 20.0)
        SecondLable.frame = CGRect(x:0, y: HeightOfScrollView * 0.72,width: WidthOfScrollView, height: HeightOfScrollView * 0.3)
        SecondLable.adjustsFontSizeToFitWidth = true
        SecondLable.minimumScaleFactor = 0.3
        SecondUIView.addSubview(SecondImage)
        SecondUIView.addSubview(SecondLable)
        scrollView.addSubview(SecondUIView)
        
        // 3枚目の画像
        let ThirdUIView = UIView(frame: CGRect(x: WidthOfScrollView * 3, y: 0, width: WidthOfScrollView, height: HeightOfScrollView))
        let ThirdImage = UIImageView(image: UIImage(named: "MandaraTutorialImage3.png"))
        ThirdImage.frame.size.height = HeightOfScrollView * 0.8
        ThirdImage.center = CGPoint(x: WidthOfScrollView * 0.5, y: HeightOfScrollView * 0.4)
        ThirdImage.contentMode = UIViewContentMode.scaleAspectFit
        
        let ThirdLable = UILabel()
        ThirdLable.text = "先ずは赤マスの隣の緑マスに \n テーマから連想される \n 単語を入力しましょう \n 外側には自動コピーされます"
        ThirdLable.numberOfLines = 4
        ThirdLable.font = UIFont.systemFont(ofSize: 20.0)
        ThirdLable.frame = CGRect(x:0, y: HeightOfScrollView * 0.72,width: WidthOfScrollView, height: HeightOfScrollView * 0.3)
        ThirdLable.adjustsFontSizeToFitWidth = true
        ThirdLable.minimumScaleFactor = 0.3
        ThirdUIView.addSubview(ThirdImage)
        ThirdUIView.addSubview(ThirdLable)
        scrollView.addSubview(ThirdUIView)
        
        // 4枚目の画像
        let FourthUIView = UIView(frame: CGRect(x: WidthOfScrollView * 4, y: 0, width: WidthOfScrollView, height: HeightOfScrollView))
        let FourthImage = UIImageView(image: UIImage(named: "MandaraTutorialImage4.png"))
        FourthImage.frame.size.height = HeightOfScrollView * 0.8
        FourthImage.center = CGPoint(x: WidthOfScrollView * 0.5, y: HeightOfScrollView * 0.4)
        FourthImage.contentMode = UIViewContentMode.scaleAspectFit
        
        let FourthLable = UILabel()
        FourthLable.text = "外側の緑マスの隣の青マスに \n 緑マスの単語に関連する \n 単語を入力しましょう"
        FourthLable.numberOfLines = 3
        FourthLable.font = UIFont.systemFont(ofSize: 20.0)
        FourthLable.frame = CGRect(x:0, y: HeightOfScrollView * 0.72,width: WidthOfScrollView, height: HeightOfScrollView * 0.3)
        FourthLable.adjustsFontSizeToFitWidth = true
        FourthLable.minimumScaleFactor = 0.3
        FourthUIView.addSubview(FourthImage)
        FourthUIView.addSubview(FourthLable)
        scrollView.addSubview(FourthUIView)
        
        //マンダラテーマ画面へ遷移するボタン
        let ButtonUIView = UIView(frame: CGRect(x: WidthOfScrollView * 5, y: 0, width: WidthOfScrollView, height: HeightOfScrollView))
        let MandaraButton = UIButton()
        MandaraButton.frame.size = CGSize(width: WidthOfScrollView, height: HeightOfScrollView * 0.3)
        MandaraButton.center = CGPoint(x:WidthOfScrollView * 0.5, y:HeightOfScrollView * 0.5)
        MandaraButton.backgroundColor = UIColor(hex: "87ceeb")
        //ボタンの角を丸くする
        MandaraButton.layer.cornerRadius = 21.0
        MandaraButton.addTarget(self, action: #selector(self.movetotheme(sender:)), for: .touchUpInside)
        let ButtonLable = UILabel()
        ButtonLable.text = "マンダラチャートを使う！ \n （テーマ作成画面に移動します）"
        ButtonLable.numberOfLines = 2
        ButtonLable.textAlignment = NSTextAlignment.center
        ButtonLable.font = UIFont.systemFont(ofSize: 20)
        ButtonLable.frame = CGRect(x:0, y:0,width: MandaraButton.frame.width, height: MandaraButton.frame.height)
        MandaraButton.addSubview(ButtonLable)
        ButtonUIView.addSubview(MandaraButton)
        scrollView.addSubview(ButtonUIView)
        
        // スクロールビューを追加
        self.view.addSubview(scrollView)
        
        //スクロールビューのページ位置を表すドットを追加
        //pageControlの位置とサイズを設定
        PageControl.frame = CGRect(x:0, y:self.view.frame.height*0.96, width:self.view.frame.width, height:self.view.frame.height*0.04)
        //背景色の設定
        PageControl.backgroundColor = UIColor.lightGray
        //ページ数の設定
        PageControl.numberOfPages = NumberOfPages
        //現在ページの設定
        PageControl.currentPage = 0
        self.view.addSubview(PageControl)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //スクロール距離 = 1ページ(画面幅)
        if fmod(scrollView.contentOffset.x, scrollView.frame.width) == 0 {
            //ページの切り替え
            self.PageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        }
    }
    
    @objc func movetotheme(sender: Any) {
        self.performSegue(withIdentifier: "toMandaraTheme", sender: nil)
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
