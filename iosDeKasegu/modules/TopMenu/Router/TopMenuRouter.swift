//
//  StartMenuRouter.swift
//  iosDeKasegu
//
//  Created by 松栄健太 on 2019/05/20.
//  Copyright © 2019 shonanhiratsuka. All rights reserved.
//

import UIKit

class TopMenuRouter {
    
    // 画面遷移のためにViewControllerが必要。initで受け取る
    weak var viewController: UIViewController?
    
    private init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    // 依存関係の解決をしている
    static func assembleModules() -> UIViewController {
        // Top画面ではViewとRouterのみ（interactorは不要）
        let topNC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TopNC") as! UINavigationController
        let view = topNC.topViewController as! TopViewController
        let router = TopMenuRouter(viewController: view)
        // PresenterはView, Interactor, Routerそれぞれ必要なので
        // 生成し、initの引数で渡す
        let presenter = TopMenuPresenter(view: view, router: router)
        view.presenter = presenter    // ViewにPresenterを設定
        
        return view
    }
}

// Routerのプロトコルに準拠する
// 遷移する各画面ごとにメソッドを定義
extension TopMenuRouter:TopMenuWireframe {
    func showSiritoriThemes() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationNC = storyboard.instantiateViewController(withIdentifier: "SiritoriThemeNC") as! UINavigationController
        viewController?.navigationController?.pushViewController(destinationNC.topViewController!, animated: true)
    }
    
    func showMandaraThemes() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationNC = storyboard.instantiateViewController(withIdentifier: "MandaraThemeNC") as! UINavigationController
        viewController?.navigationController?.pushViewController(destinationNC.topViewController!, animated: true)
    }
    
    func showSixHatsThemes() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationNC = storyboard.instantiateViewController(withIdentifier: "SixHatsThemeNC") as! UINavigationController
        viewController?.navigationController?.pushViewController(destinationNC.topViewController!, animated: true)
    }
    
    func showOsborneThemes() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationNC = storyboard.instantiateViewController(withIdentifier: "OsborneThemeNC") as! UINavigationController
        viewController?.navigationController?.pushViewController(destinationNC.topViewController!, animated: true)
    }
    
    func showTutorial() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationNC = storyboard.instantiateViewController(withIdentifier: "TutorialNC") as! UINavigationController
        viewController?.navigationController?.pushViewController(destinationNC.topViewController!, animated: true)
    }
    
    
}
