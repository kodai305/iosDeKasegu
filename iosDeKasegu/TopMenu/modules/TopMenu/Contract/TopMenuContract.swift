//
//  TopMenuContract.swift
//  iosDeKasegu
//
//  Created by 松栄健太 on 2019/05/20.
//  Copyright © 2019 shonanhiratsuka. All rights reserved.
//

import Foundation

// MARK: - view
protocol TopMenuView: class {
    func showSiritoriThemes()
    func showMandaraThemes()
    func showSixHatsThemes()
    func showOsborneThemes()
    func showTutorial()
}

// MARK: - presenter
protocol TopMenuPresentable: class {
    func selectMenu(selectedTopMenuType: TopMenuType)
}

// MARK: - router
protocol TopMenuWireframe: class {
    func showSiritoriThemes()
    func showMandaraThemes()
    func showSixHatsThemes()
    func showOsborneThemes()
    func showTutorial()
}

enum TopMenuType: String {
    case siritori
    case mandara
    case sixHats
    case osborne
    case tutorial
}
