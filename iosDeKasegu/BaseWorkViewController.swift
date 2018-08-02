//
//  BaseWorkViewController.swift
//  iosDeKasegu
//
//  Created by 高木広大 on 2018/07/23.
//  Copyright © 2018年 shonanhiratsuka. All rights reserved.
//

import UIKit
import GoogleMobileAds

class BaseWorkViewController: BaseViewController {

    var toolbar: UIToolbar!
    var topKeyboard:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //ボタンが押された時の処理
    @objc func shareButtonAction(sender: UIBarButtonItem) {
        print("button tapped")
    }
    
    override func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: -50),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    
    // キーボードが表示、非表示された時に最初に呼び出される関数（textViewDidBeginEditing(）より早い）
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,selector: #selector(self.keyboardWillShow(_:)),name: NSNotification.Name.UIKeyboardWillShow,object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(self.keyboardWillHide(_:)) ,name: NSNotification.Name.UIKeyboardWillHide,object: nil)
    }
    
    //キーボードが表示された時の処理（マンダラとしりとりのWorkViewControllerでOverrideする）
    @objc func keyboardWillShow(_ notification: Notification) {
    }
 
    //キーボードが下がった時の処理（マンダラとしりとりのWorkViewControllerでOverrideする）
    @objc func keyboardWillHide(_ notification: Notification) {
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
