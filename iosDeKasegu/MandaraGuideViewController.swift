//
//  MandaraGuideViewController.swift
//  iosDeKasegu
//
//  Created by 高木広大 on 2018/07/16.
//  Copyright © 2018年 shonanhiratsuka. All rights reserved.
//

import UIKit
//import PlaceholderTextView

class MandaraGuideViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let placeholderTextView = PlaceholderTextView()
        let frame = CGRect(x: 0, y: 20, width: 320, height: 100)
        placeholderTextView.frame = frame
        placeholderTextView.placeholder = "Placeholder Text"
        placeholderTextView.placeholderColor = UIColor.lightGray
        self.view.addSubview(placeholderTextView)
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
