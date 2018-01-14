//
//  CatalogWireframe.swift
//  RxMVVMSample
//
//  Created by 須藤将史 on 2018/01/06.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import UIKit

protocol CatalogWireframeable {
    func goToCatalogScreen()
    func goToSimpleExampleScreen()
    func goToSharedModelExampleScreen()
    func goToHierarchalViewModelExampleScreen()
}

final class CatalogWireframe: CatalogWireframeable {
    
    private weak var nav: UINavigationController?
    
    class func bootstrap(on window: UIWindow) -> CatalogWireframe {
        let nav = UINavigationController()
        window.rootViewController = nav
        window.makeKeyAndVisible()
        return CatalogWireframe(on: nav)
    }
    
    private init(on navigationController: UINavigationController) {
        nav = navigationController
    }
    
    func goToCatalogScreen() {
        let next = CatalogViewController(dependency: self)
        nav?.setViewControllers([next], animated: false)
    }
    
    func goToSimpleExampleScreen() {
        let next = SimpleViewController()
        nav?.pushViewController(next, animated: true)
    }
    
    func goToSharedModelExampleScreen() {
        let allBadgesModel = AllBadges(badges: BadgesDummyRepository())
        let selectedBadgesModel = SelectedBadges(selected: [])
        
        let next = BadgeSelectorViewController(dependency: (
            selectedBadgesModel: selectedBadgesModel,
            selectableBadgesModel: SelectableBadges(dependency: (
                allModel: allBadgesModel,
                selectedModel: selectedBadgesModel))
            )
        )
        
        nav?.pushViewController(next, animated: true)
    }
    
    func goToHierarchalViewModelExampleScreen() {
    }
}
