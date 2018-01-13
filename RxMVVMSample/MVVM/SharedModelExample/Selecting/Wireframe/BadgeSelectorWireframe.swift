//
//  BadgeSelectorWireframe.swift
//  RxMVVMSample
//
//  Created by 須藤将史 on 2018/01/11.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import UIKit

protocol BadgeSelectorWireframeable {
    func goToSelectedBadgesViewScreen(with selectedBadgesModel: SelectedBadgesModelable)
}

final class BadgeSelectorWireframe: BadgeSelectorWireframeable {
    private weak var controller: UIViewController?
    
    init(on controller: UIViewController) {
        self.controller = controller
    }
    
    func goToSelectedBadgesViewScreen(with selectedBadgesModel: SelectedBadgesModelable) {
        let nav = UINavigationController(
            rootViewController: SelectedBadgesViewController(
                dependency: selectedBadgesModel
            )
        )
        
        controller?.present(nav, animated: true)
    }
}
