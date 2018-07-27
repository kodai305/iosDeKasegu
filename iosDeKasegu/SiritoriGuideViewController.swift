//
//  SiritoriGuideViewController.swift
//  
//
//  Created by 高木広大 on 2018/07/12.
//

import UIKit

class SiritoriGuideViewController: BaseViewController,UIScrollViewDelegate {
    
    //UIPageControlのインスタンス作成
    let PageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let Datum_xOfScrollView:CGFloat = UIScreen.main.bounds.width*0.05
        let Datum_yOfScrollView:CGFloat = UIScreen.main.bounds.height*0.1
        let WidthOfScrollView:CGFloat = UIScreen.main.bounds.width*0.9
        let HeightOfScrollView:CGFloat = UIScreen.main.bounds.height*0.9
        
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: Datum_xOfScrollView, y: Datum_yOfScrollView, width: WidthOfScrollView, height: HeightOfScrollView)
        scrollView.contentSize = CGSize(width: WidthOfScrollView * 4.0, height: HeightOfScrollView)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        
        // しりとり法の説明
        let IntroductionUIView = UIView(frame: CGRect(x: 0, y: 0, width: WidthOfScrollView, height: HeightOfScrollView))
        
        let DetailofIntroduction = UILabel()
        DetailofIntroduction.frame = CGRect(x:0, y: HeightOfScrollView * 0.05 ,width: WidthOfScrollView, height: HeightOfScrollView * 0.4 )
        DetailofIntroduction.text = "しりとり法とは \n アイデアを出すテーマを決め \n しりとり形式でキーワードを増やしながら \n キーワードを含むアイデアを考える方法です \n 下は「新しいアプリ」をテーマにした例です"
        DetailofIntroduction.numberOfLines = 5
        DetailofIntroduction.font = UIFont.systemFont(ofSize: 40.0)
        DetailofIntroduction.adjustsFontSizeToFitWidth = true
        DetailofIntroduction.minimumScaleFactor = 0.3
        
        let ImageofIntroduction = UIImageView(image: UIImage(named: "SiritoriExample.png"))
        ImageofIntroduction.frame.size.width = WidthOfScrollView
        ImageofIntroduction.frame.origin = CGPoint(x: 0, y: HeightOfScrollView * 0.3)
        ImageofIntroduction.contentMode = UIViewContentMode.scaleAspectFit
        
        let DetailofApp = UILabel()
        DetailofApp.frame = CGRect(x:0, y: HeightOfScrollView * 0.6 ,width: WidthOfScrollView, height: HeightOfScrollView * 0.3 )
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
        let FirstImage = UIImageView(image: UIImage(named: "SiritoriTutorialImage1.png"))
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
        let SecondImage = UIImageView(image: UIImage(named: "SiritoriTutorialImage2.png"))
        SecondImage.frame.size.height = HeightOfScrollView * 0.8
        SecondImage.center = CGPoint(x: WidthOfScrollView * 0.5, y: HeightOfScrollView * 0.4)
        SecondImage.contentMode = UIViewContentMode.scaleAspectFit
        
        let SecondLable = UILabel()
        SecondLable.text = "最初のフレーズを決定 \n （デフォルト:しりとり）\n 最初のフレーズとしりとりをして \n キーワード1を決定"
        SecondLable.numberOfLines = 4
        SecondLable.font = UIFont.systemFont(ofSize: 20.0)
        SecondLable.frame = CGRect(x:0, y: HeightOfScrollView * 0.72,width: WidthOfScrollView, height: HeightOfScrollView * 0.3)
        SecondLable.adjustsFontSizeToFitWidth = true
        SecondLable.minimumScaleFactor = 0.3
        SecondUIView.addSubview(SecondImage)
        SecondUIView.addSubview(SecondLable)
        scrollView.addSubview(SecondUIView)
        
        // 3枚目の画像
        let ThirdUIView = UIView(frame: CGRect(x: WidthOfScrollView * 3, y: 0, width: WidthOfScrollView, height: HeightOfScrollView))
        let ThirdImage = UIImageView(image: UIImage(named: "SiritoriTutorialImage3.png"))
        ThirdImage.frame.size.height = HeightOfScrollView * 0.8
        ThirdImage.center = CGPoint(x: WidthOfScrollView * 0.5, y: HeightOfScrollView * 0.4)
        ThirdImage.contentMode = UIViewContentMode.scaleAspectFit
        
        let ThirdLable = UILabel()
        ThirdLable.text = "キーワード1を含むアイデア1を考案 \n 次へボタンをタップして \n キーワード2のカードを作成 \n 100個のアイデアを目指そう！"
        ThirdLable.numberOfLines = 4
        ThirdLable.font = UIFont.systemFont(ofSize: 20.0)
        ThirdLable.frame = CGRect(x:0, y: HeightOfScrollView * 0.72,width: WidthOfScrollView, height: HeightOfScrollView * 0.3)
        ThirdLable.adjustsFontSizeToFitWidth = true
        ThirdLable.minimumScaleFactor = 0.3
        ThirdUIView.addSubview(ThirdImage)
        ThirdUIView.addSubview(ThirdLable)
        scrollView.addSubview(ThirdUIView)
        
        // スクロールビューを追加
        self.view.addSubview(scrollView)
        
        //スクロールビューのページ位置を表すドットを追加
        //pageControlの位置とサイズを設定
        PageControl.frame = CGRect(x:0, y:self.view.frame.height*0.96, width:self.view.frame.width, height:self.view.frame.height*0.04)
        //背景色の設定
        PageControl.backgroundColor = UIColor.lightGray
        //ページ数の設定
        PageControl.numberOfPages = 4
        //現在ページの設定
        PageControl.currentPage = 0
        self.view.addSubview(PageControl)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //スクロール距離 = 1ページ(画面幅)
        print("in")
        if fmod(scrollView.contentOffset.x, scrollView.frame.width) == 0 {
            //ページの切り替え
            self.PageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        }
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
