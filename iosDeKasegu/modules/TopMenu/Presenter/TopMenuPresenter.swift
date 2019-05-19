//
//  TopMenuPresenter.swift
//  iosDeKasegu
//
//  Created by 松栄健太 on 2019/05/20.
//  Copyright © 2019 shonanhiratsuka. All rights reserved.
//

import Foundation

class TopMenuPresenter {
    
    // View, Routerへのアクセスはprotocolを介して行う
    private weak var view: TopMenuView?
    private let router: TopMenuWireframe
    
    init(view: TopMenuView, router: TopMenuWireframe) {
        self.view = view
        self.router = router
    }
}

// Presenterのプロトコルに準拠する
extension TopMenuPresenter: TopMenuPresentable {
    
    func selectMenu(selectedTopMenuType: TopMenuType) {
        switch selectedTopMenuType {
        case .mandara:
            self.router.showMandaraThemes()
        case .siritori:
            self.router.showSiritoriThemes()
        case .tutorial:
            self.router.showTutorial()
        }
    }
}
