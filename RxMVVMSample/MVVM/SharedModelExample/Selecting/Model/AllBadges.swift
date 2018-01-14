//
//  AllBadges.swift
//  RxMVVMSample
//
//  Created by 須藤将史 on 2018/01/11.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol AllBadgesModelable {
    typealias State = EntityModelState<Void, [Badge], Never>
    var stateDidChange: RxCocoa.Driver<State> { get }
    var currentState: State { get }
}

final class AllBadges: AllBadgesModelable {
    private let entityModel: EntityModel<Void, [Badge], Never>
    private let disposeBag = RxSwift.DisposeBag()
    
    let stateDidChange: RxCocoa.Driver<State>
    
    var currentState: AllBadgesModelable.State {
        return entityModel.currentState
    }
    
    init<Repository: BadgesRepositorable>(badges repository: Repository) where Repository.P == Void, Repository.V == [Badge], Repository.E == Never {
        self.entityModel = EntityModel<Void, [Badge], Never>(startingWith: .sleeping, entity: repository)
        self.stateDidChange = entityModel.stateDidChange
        self.entityModel.get(by: ())
    }
}
