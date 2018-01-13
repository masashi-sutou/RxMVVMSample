//
//  StateMachine.swift
//  RxMVVMSample
//
//  Created by 須藤将史 on 2018/01/11.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class StateMachine<S> {
    private let stateRelay: RxCocoa.BehaviorRelay<S>
    let stateDidChange: RxCocoa.Driver<S>
    
    var currentState: S {
        get {
            return self.stateRelay.value
        }
        set {
            self.stateRelay.accept(newValue)
        }
    }
    
    init(startingWith initialState: S) {
        let stateRelay = RxCocoa.BehaviorRelay(value: initialState)
        self.stateRelay = stateRelay
        self.stateDidChange = stateRelay.asDriver()
    }
}
