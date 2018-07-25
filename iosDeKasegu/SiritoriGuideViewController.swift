//
//  SiritoriGuideViewController.swift
//  
//
//  Created by 高木広大 on 2018/07/12.
//

import UIKit

class SiritoriGuideViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let Datum_xOfScrollView:CGFloat = UIScreen.main.bounds.width*0.1
        let Datum_yOfScrollView:CGFloat = UIScreen.main.bounds.height*0.1
        let WidthOfScrollView:CGFloat = UIScreen.main.bounds.width*0.8
        let HeightOfScrollView:CGFloat = UIScreen.main.bounds.height*0.9
        
        
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: Datum_xOfScrollView, y: Datum_yOfScrollView, width: WidthOfScrollView, height: HeightOfScrollView)
        scrollView.contentSize = CGSize(width: WidthOfScrollView * 3.0, height: HeightOfScrollView)
        scrollView.isPagingEnabled = true
        
        // 1枚目の画像
        let FirstUIView = UIView(frame: CGRect(x: 0, y: 0, width: WidthOfScrollView, height: HeightOfScrollView))
        let FirstImage = UIImageView(image: UIImage(named: "SiritoriTutorialImage1.png"))
        //FirstImage.frame.size = CGSize(width: WidthOfScrollView, height: HeightOfScrollView * 0.8)
        FirstImage.frame.size.height = HeightOfScrollView * 0.8
        FirstImage.center = CGPoint(x: WidthOfScrollView * 0.5, y: HeightOfScrollView * 0.4)
        FirstImage.contentMode = UIViewContentMode.scaleAspectFit
        
        let FirstLable = UILabel()
        FirstLable.text = "新規テーマ:画面右上の＋ボタン \n 保存テーマ:テーブルの項目 \n をそれぞれタップ"
        FirstLable.numberOfLines = 5
        FirstLable.font = UIFont.systemFont(ofSize: 20.0)
        FirstLable.frame = CGRect(x:0, y: HeightOfScrollView * 0.72,width: WidthOfScrollView, height: HeightOfScrollView * 0.3)
        FirstLable.adjustsFontSizeToFitWidth = true
        FirstUIView.addSubview(FirstImage)
        FirstUIView.addSubview(FirstLable)
        scrollView.addSubview(FirstUIView)
        // 2枚目の画像
        let SecondUIView = UIView(frame: CGRect(x: WidthOfScrollView, y: 0, width: WidthOfScrollView, height: HeightOfScrollView))
        let SecondImage = UIImageView(image: UIImage(named: "SiritoriTutorialImage2.png"))
        SecondImage.frame.size.height = HeightOfScrollView * 0.8
        SecondImage.center = CGPoint(x: WidthOfScrollView * 0.5, y: HeightOfScrollView * 0.4)
        SecondImage.contentMode = UIViewContentMode.scaleAspectFit
        
        let SecondLable = UILabel()
        SecondLable.text = "最初のフレーズを決定 \n （デフォルト:しりとり）\n 最初のフレーズとしりとりをして \n キーワード1を決定"
        SecondLable.numberOfLines = 5
        SecondLable.font = UIFont.systemFont(ofSize: 20.0)
        SecondLable.frame = CGRect(x:0, y: HeightOfScrollView * 0.72,width: WidthOfScrollView, height: HeightOfScrollView * 0.3)
        SecondLable.adjustsFontSizeToFitWidth = true
        SecondUIView.addSubview(SecondImage)
        SecondUIView.addSubview(SecondLable)
        scrollView.addSubview(SecondUIView)
        
        // 3枚目の画像
        let ThirdUIView = UIView(frame: CGRect(x: WidthOfScrollView * 2, y: 0, width: WidthOfScrollView, height: HeightOfScrollView))
        let ThirdImage = UIImageView(image: UIImage(named: "SiritoriTutorialImage3.png"))
        ThirdImage.frame.size.height = HeightOfScrollView * 0.8
        ThirdImage.center = CGPoint(x: WidthOfScrollView * 0.5, y: HeightOfScrollView * 0.4)
        ThirdImage.contentMode = UIViewContentMode.scaleAspectFit
        
        let ThirdLable = UILabel()
        ThirdLable.text = "キーワード1を含むアイデア1を考案 \n 次へボタンをタップして \n キーワード2のカードを作成 \n 100個のアイデアを目指そう！"
        ThirdLable.numberOfLines = 5
        ThirdLable.font = UIFont.systemFont(ofSize: 20.0)
        ThirdLable.frame = CGRect(x:0, y: HeightOfScrollView * 0.72,width: WidthOfScrollView, height: HeightOfScrollView * 0.3)
        ThirdLable.adjustsFontSizeToFitWidth = true
        ThirdUIView.addSubview(ThirdImage)
        ThirdUIView.addSubview(ThirdLable)
        scrollView.addSubview(ThirdUIView)
        
        // スクロールビューを追加
        self.view.addSubview(scrollView)
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
