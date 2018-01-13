//
//  PresentedViewControllerWireframe.swift
//  RxMVVMSample
//
//  Created by 須藤将史 on 2018/01/13.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import UIKit

protocol PresentedViewControllerWireframeable {
    func goBack()
}

final class PresentedViewControllerWireframe: PresentedViewControllerWireframeable {
    private weak var presentedViewController: UIViewController?
    
    init(willDismiss presentedViewController: UIViewController) {
        self.presentedViewController = presentedViewController
    }
    
    func goBack() {
        presentedViewController?.dismiss(animated: true, completion: nil)
    }
}
