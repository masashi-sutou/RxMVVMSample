//
//  DefaultCatalogWireframe.swift
//  RxMVVMSample
//
//  Created by 須藤将史 on 2018/01/06.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import UIKit

protocol CatalogWireframe {
    func goToCatalogScreen()
    func goToSimpleExampleScreen()
    func goToSharedModelExampleScreen()
    func goToHierarchalViewModelExampleScreen()
}

final class DefaultCatalogWireframe: CatalogWireframe {
    
    private weak var nav: UINavigationController?
    
    class func bootstrap(on window: UIWindow) -> DefaultCatalogWireframe {
        let nav = UINavigationController()
        window.rootViewController = nav
        window.makeKeyAndVisible()
        return DefaultCatalogWireframe(on: nav)
    }
    
    private init(on navigationController: UINavigationController) {
        nav = navigationController
    }
    
    func goToCatalogScreen() {
        let next = CatalogViewController(dependency: self)
        nav?.setViewControllers([next], animated: false)
    }
    
    func goToSimpleExampleScreen() {
    }
    
    func goToSharedModelExampleScreen() {
    }
    
    func goToHierarchalViewModelExampleScreen() {
    }
}
