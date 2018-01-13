//
//  BadgesRepositorable.swift
//  RxMVVMSample
//
//  Created by 須藤将史 on 2018/01/12.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import Foundation

protocol BadgesRepositorable: EntityModelRepositorable {
    associatedtype P = Void
    associatedtype V = [Badge]
    associatedtype E = Never
}
