//
//  SelectedBadgesModel.swift
//  RxMVVMSample
//
//  Created by 須藤将史 on 2018/01/11.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SelectedBadgesModelable {
    var badgeDidSelect: RxCocoa.Signal<Badge> { get }
    var badgeDidDeselect: RxCocoa.Signal<Badge> { get }
    var selectionDidChange: RxCocoa.Driver<[Badge]> { get }
    var currentSelection: [Badge] { get }

    func select(badge: Badge)
    func deselect(badge: Badge)
}

final class SelectedBadgesModel: SelectedBadgesModelable {
    
    private let stateMachine: StateMachine<[Badge]>
    private let badgeDidSelectRelay: RxCocoa.PublishRelay<Badge>
    private let badgeDidDeselectRelay: RxCocoa.PublishRelay<Badge>
    
    let badgeDidSelect: RxCocoa.Signal<Badge>
    let badgeDidDeselect: RxCocoa.Signal<Badge>
    let selectionDidChange: RxCocoa.Driver<[Badge]>
    
    var currentSelection: [Badge] {
        get {
            return stateMachine.currentState
        }
        set {
            stateMachine.currentState = newValue
        }
    }
    
    init(selected initialSelection: [Badge]) {
        self.stateMachine = StateMachine(startingWith: initialSelection)
        
        let badgeDidSelectRelay = RxCocoa.PublishRelay<Badge>()
        self.badgeDidSelectRelay = badgeDidSelectRelay
        self.badgeDidSelect = badgeDidSelectRelay.asSignal()
        
        let badgeDidDeselectRelay = RxCocoa.PublishRelay<Badge>()
        self.badgeDidDeselectRelay = badgeDidDeselectRelay
        self.badgeDidDeselect = badgeDidDeselectRelay.asSignal()
        
        self.selectionDidChange = stateMachine.stateDidChange
    }
    
    func select(badge: Badge) {
        guard !currentSelection.contains(badge) else { return }
        var newSelection = currentSelection
        newSelection.append(badge)
        
        currentSelection = newSelection
        badgeDidSelectRelay.accept(badge)
    }
    
    func deselect(badge: Badge) {
        var newSelection = currentSelection
        
        guard let index = newSelection.index(of: badge) else { return }
        newSelection.remove(at: index)
        
        currentSelection = newSelection
        badgeDidDeselectRelay.accept(badge)
    }
}
