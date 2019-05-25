//
//  RootRouter.swift
//  iosDeKasegu
//
//  Created by 松栄健太 on 2019/05/20.
//  Copyright © 2019 shonanhiratsuka. All rights reserved.
//

import UIKit

class RootRouter {
    
    private init() {}
    
    static func showFirstView(window: UIWindow) {
        let firstView = TopMenuRouter.assembleModules()
        let navigationController = UINavigationController(rootViewController: firstView)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
