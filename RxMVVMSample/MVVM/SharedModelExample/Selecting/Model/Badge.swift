//
//  Badge.swift
//  RxMVVMSample
//
//  Created by 須藤将史 on 2018/01/11.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import UIKit
import RxDataSources

struct Badge {
    let id: Int
    let title: String
    let color: UIColor
}

extension Badge: Hashable {
    var hashValue: Int {
        return id
    }
    
    static func ==(lhs: Badge, rhs: Badge) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Badge: IdentifiableType {
    typealias Identity = Int

    var identity: Int {
        return id
    }
}
