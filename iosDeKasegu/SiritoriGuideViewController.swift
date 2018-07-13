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
        
        let datum_x:CGFloat = UIScreen.main.bounds.width*0.1
        let datum_y:CGFloat = 0.0
        let stand_w:CGFloat = UIScreen.main.bounds.width*0.8
        let stand_h:CGFloat = UIScreen.main.bounds.height*0.8
        
        
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: datum_x, y: datum_y, width: stand_w, height: stand_h)
        scrollView.contentSize = CGSize(width: stand_w * 3.0, height: stand_h)
        scrollView.isPagingEnabled = true
        
        // 1枚目の画像
        let firstImageView = UIImageView(image: UIImage(named: "expand.png"))
        firstImageView.frame = CGRect(x: 0, y: 0, width: stand_w, height: stand_h)
        firstImageView.contentMode = UIViewContentMode.scaleAspectFit
        scrollView.addSubview(firstImageView)
        
        // 2枚目の画像
        let secondImageView = UIImageView(image: UIImage(named: "getidea.png"))
        secondImageView.frame = CGRect(x: stand_w, y: 0, width: stand_w, height: stand_h)
        secondImageView.contentMode = UIViewContentMode.scaleAspectFit
        scrollView.addSubview(secondImageView)
        
        // 3枚目の画像
        let thirdImageView = UIImageView(image: UIImage(named: "tutorial.png"))
        thirdImageView.frame = CGRect(x: stand_w * 2.0, y: 0, width: stand_w, height: stand_h)
        thirdImageView.contentMode = UIViewContentMode.scaleAspectFit
        scrollView.addSubview(thirdImageView)
        
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
