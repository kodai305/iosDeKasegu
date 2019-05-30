//
//  SiritoriGuideViewController.swift
//  
//
//  Created by 高木広大 on 2018/07/12.
//

import UIKit
import AVFoundation

class SiritoriGuideViewController: BaseViewController,UIScrollViewDelegate {
    
    //UIPageControlのインスタンス作成
    let PageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //スクロールビューの大きさ、座標を決める
        let Datum_xOfScrollView:CGFloat = UIScreen.main.bounds.width*0.05
        let Datum_yOfScrollView:CGFloat = UIScreen.main.bounds.height*0.1
        let WidthOfScrollView:CGFloat = UIScreen.main.bounds.width*0.9
        let HeightOfScrollView:CGFloat = UIScreen.main.bounds.height*0.9
        let NumberOfPages:Int = 5
        
        //スクロールビューの設定
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: Datum_xOfScrollView, y: Datum_yOfScrollView, width: WidthOfScrollView, height: HeightOfScrollView)
        //枚数に合わせてwidthの係数を変える
        scrollView.contentSize = CGSize(width: WidthOfScrollView * CGFloat(NumberOfPages), height: HeightOfScrollView)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        
        // しりとり法の説明
        let IntroductionUIView = UIView(frame: CGRect(x: 0, y: 0, width: WidthOfScrollView, height: HeightOfScrollView))
        
        let TitelofIntroduction = UILabel()
        TitelofIntroduction.frame.size = CGSize(width: WidthOfScrollView, height: 0)
        TitelofIntroduction.center = CGPoint(x:self.view.center.x, y: HeightOfScrollView * 0.05)
        let TitleText = "しりとり法とは"
        // attributedTextを作成する.
        let attributedText = NSMutableAttributedString(string: TitleText)
        let range = NSMakeRange(0, TitleText.count)
        // 下線を引くようの設定をする.
        attributedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        TitelofIntroduction.attributedText = attributedText
        TitelofIntroduction.textAlignment = NSTextAlignment.center
        //上記の文章の段数と合わせる
        TitelofIntroduction.numberOfLines = 1
        TitelofIntroduction.font = UIFont.boldSystemFont(ofSize: 25)
        TitelofIntroduction.sizeToFit()
        
        let DetailofIntroduction = UILabel()
        DetailofIntroduction.frame = CGRect(x:0, y: TitelofIntroduction.frame.origin.y + TitelofIntroduction.frame.height + 15 ,width: WidthOfScrollView, height: 0)
        DetailofIntroduction.text = "しりとり法は \n アイデアの発想を使用するツールです。 \n 具体的には \n 1.アイデアを出すテーマを決定 \n 2.最初のキーワードを決定 \n 3.しりとり形式で新しいキーワードを決定 \n 4.3のキーワードを含むアイデアを考案 \n 5.3と4を繰り返す \n という手順で進めます。 \n 下は「新しいアプリ」をテーマにした例です"
        //上記の文章の段数と合わせる
        DetailofIntroduction.numberOfLines = 11
        DetailofIntroduction.font = UIFont.systemFont(ofSize: 17)
        DetailofIntroduction.sizeToFit()
        
        let ImageofIntroduction = UIImage(named: "SiritoriExample.png")
        let UIImageofIntroduction = UIImageView(image: ImageofIntroduction)
        UIImageofIntroduction.frame.size.width = WidthOfScrollView
        //元の画像のアスペクト比を保ったまま、画像を縮小
        UIImageofIntroduction.contentMode = UIView.ContentMode.scaleAspectFit
        //縮小した後の画像のサイズと座標を取得
        let FrameOfImage = AVMakeRect(aspectRatio: (ImageofIntroduction?.size)!, insideRect: UIImageofIntroduction.bounds)
        //縮小した後の画像の座標に合わせてUIViewもオフセット
        UIImageofIntroduction.frame.origin = CGPoint(x: 0, y:  (DetailofIntroduction.frame.origin.y - FrameOfImage.origin.y) + DetailofIntroduction.frame.height + 10)
        
        let DetailofApp = UILabel()
        DetailofApp.frame = CGRect(x:0, y: UIImageofIntroduction.frame.origin.y + (UIImageofIntroduction.frame.height - FrameOfImage.origin.y) + 15 ,width: WidthOfScrollView, height: 0 )
        DetailofApp.text = "左にスワイプするとアプリの使い方を \n 見ることが出来ます。 \n 途中の状態で保存して再開することも　\n 出来ます。（保存は自動で行われます。）"
        DetailofApp.numberOfLines = 0
        DetailofApp.font = UIFont.systemFont(ofSize: 17)
        DetailofApp.sizeToFit()
        
        IntroductionUIView.addSubview(TitelofIntroduction)
        IntroductionUIView.addSubview(DetailofIntroduction)
        IntroductionUIView.addSubview(UIImageofIntroduction)
        IntroductionUIView.addSubview(DetailofApp)
        scrollView.addSubview(IntroductionUIView)
        
        // 1枚目の画像
        let FirstUIView = UIView(frame: CGRect(x: WidthOfScrollView, y: 0, width: WidthOfScrollView, height: HeightOfScrollView))
        let FirstImage = UIImageView(image: UIImage(named: "SiritoriTutorialImage1.png"))
        FirstImage.frame.size.height = HeightOfScrollView * 0.8
        FirstImage.center = CGPoint(x: WidthOfScrollView * 0.5, y: HeightOfScrollView * 0.4)
        FirstImage.contentMode = UIView.ContentMode.scaleAspectFit
        
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
        SecondImage.contentMode = UIView.ContentMode.scaleAspectFit
        
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
        ThirdImage.contentMode = UIView.ContentMode.scaleAspectFit
        
        let ThirdLable = UILabel()
        ThirdLable.text = "キーワード1を含むアイデア1を考案 \n 次へボタンをタップして \n キーワード2のカードを作成 \n アイデア数は無制限です"
        ThirdLable.numberOfLines = 4
        ThirdLable.font = UIFont.systemFont(ofSize: 20.0)
        ThirdLable.frame = CGRect(x:0, y: HeightOfScrollView * 0.72,width: WidthOfScrollView, height: HeightOfScrollView * 0.3)
        ThirdLable.adjustsFontSizeToFitWidth = true
        ThirdLable.minimumScaleFactor = 0.3
        ThirdUIView.addSubview(ThirdImage)
        ThirdUIView.addSubview(ThirdLable)
        scrollView.addSubview(ThirdUIView)
        
        //しりとりテーマ画面へ遷移するボタン
        let ButtonUIView = UIView(frame: CGRect(x: WidthOfScrollView * 4, y: 0, width: WidthOfScrollView, height: HeightOfScrollView))
        let SiritoriButton = UIButton()
        SiritoriButton.frame.size = CGSize(width: WidthOfScrollView, height: HeightOfScrollView * 0.3)
        SiritoriButton.center = CGPoint(x:WidthOfScrollView * 0.5, y:HeightOfScrollView * 0.5)
        SiritoriButton.backgroundColor = UIColor(hex: "F4D03F")
        SiritoriButton.addTarget(self, action: #selector(self.movetotheme(sender:)), for: .touchUpInside)
        let ButtonLable = UILabel()
        ButtonLable.text = "しりとり法を使う \n （テーマ作成画面に移動します）"
        ButtonLable.numberOfLines = 2
        ButtonLable.textAlignment = NSTextAlignment.center
        ButtonLable.font = UIFont.systemFont(ofSize: 20)
        ButtonLable.frame = CGRect(x:0, y:0,width: SiritoriButton.frame.width, height: SiritoriButton.frame.height)
        SiritoriButton.addSubview(ButtonLable)
        ButtonUIView.addSubview(SiritoriButton)
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
        let storyboard = UIStoryboard(name: "Siritori", bundle: nil)
        let destinationNC = storyboard.instantiateViewController(withIdentifier: "SiritoriThemesNC") as! UINavigationController
        self.navigationController?.pushViewController(destinationNC.topViewController!, animated: true)
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
