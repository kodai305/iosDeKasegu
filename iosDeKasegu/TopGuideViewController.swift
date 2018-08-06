//
//  TopGuideViewController.swift
//  iosDeKasegu
//
//  Created by user on 2018/07/26.
//  Copyright © 2018年 shonanhiratsuka. All rights reserved.
//

import UIKit

class TopGuideViewController: BaseViewController {


    @IBOutlet weak var Introduction: UILabel!
    @IBOutlet weak var SiritoriGuide: UIButton!
    @IBOutlet weak var MandaraGuide: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //表題
        let Title =  UILabel(frame: CGRect(x:0,y:self.view.frame.height / 20,width:self.view.frame.width,height:self.view.frame.height / 10))
        Title.text = "Tutorial"
        Title.font = UIFont(name: "Futura-Medium", size: 25)
        Title.numberOfLines = 0
        Title.textAlignment = NSTextAlignment.center
        Title.baselineAdjustment = UIBaselineAdjustment.alignCenters
        Title.backgroundColor = UIColor(hex: "ECF0F1")
        self.view.addSubview(Title)
        
        self.Introduction.frame = CGRect(x: self.view.frame.size.width * 0.05, y: self.view.frame.size.height * 0.1, width: self.view.frame.size.width * 0.9, height: self.view.frame.size.height * 0.4)
        
        self.SiritoriGuide.frame = CGRect(x: self.view.frame.size.width * 0.1, y: self.view.frame.size.height * 0.52, width: self.view.frame.size.width * 0.8, height: self.view.frame.size.height * 0.2)
        self.SiritoriGuide.titleLabel?.adjustsFontSizeToFitWidth = true
        self.SiritoriGuide.backgroundColor = UIColor(hex: "F4D03F")
        
        self.MandaraGuide.frame = CGRect(x: self.view.frame.size.width * 0.1, y: self.view.frame.size.height * 0.74, width: self.view.frame.size.width * 0.8, height: self.view.frame.size.height * 0.2)
        self.MandaraGuide.titleLabel?.adjustsFontSizeToFitWidth = true
        self.MandaraGuide.backgroundColor = UIColor(hex: "59ABE3")

        // Do any additional setup after loading the view.
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
