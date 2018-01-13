//
//  BadgesConstantRepository.swift
//  RxMVVMSample
//
//  Created by 須藤将史 on 2018/01/12.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import Foundation
import RxSwift

final class BadgesConstantRepository: BadgesRepositorable {
    private let badges: [Badge]
    
    init(returning badges: [Badge]) {
        self.badges = badges
    }
    
    func get(by parameters: Void) -> RxSwift.Single< Result<[Badge], Never>> {
        return .just(.success(self.badges))
    }
}
