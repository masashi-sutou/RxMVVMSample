//
//  SelectableBadges.swift
//  RxMVVMSample
//
//  Created by 須藤将史 on 2018/01/11.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import RxSwift
import RxCocoa

protocol SelectableBadgesModelable {
    var selectableBadgesDidChange: RxCocoa.Driver<[Badge]> { get }
    var currentSelectableBadges: [Badge] { get }
}

final class SelectableBadges: SelectableBadgesModelable {
    typealias Dependency = (
        allModel: AllBadgesModelable,
        selectedModel: SelectedBadgesModelable
    )
    private let disposeBag = RxSwift.DisposeBag()
    private let dependency: Dependency
    private let selectableBadgesRealy: RxCocoa.BehaviorRelay<[Badge]>
    
    let selectableBadgesDidChange: RxCocoa.Driver<[Badge]>
    
    var currentSelectableBadges: [Badge] {
        return selectableBadgesRealy.value
    }
    
    init(dependency: Dependency) {
        self.dependency = dependency
        
        /*
         MARK: Use a BehaviorRelay because this model has a synchronous getter for selected badges.
         */
        let relay = RxCocoa.BehaviorRelay(value: SelectableBadges.dropSelected(from: dependency.allModel.currentState.value ?? [], without: Set(dependency.selectedModel.currentSelection)
        ))
        self.selectableBadgesRealy = relay
        self.selectableBadgesDidChange = relay.asDriver()
        
        RxCocoa.Driver
            .combineLatest(dependency.allModel.stateDidChange, dependency.selectedModel.selectionDidChange, resultSelector: { ($0, $1) }
            )
            .map { tuple -> [Badge] in
                let (allBadgesModelState, selectedBadges) = tuple
                return SelectableBadges.dropSelected(from: allBadgesModelState.value ?? [], without: Set(selectedBadges)
                )
            }
            .drive(selectableBadgesRealy)
            .disposed(by: disposeBag)
    }
    
    private static func dropSelected(from allBadges: [Badge], without selectedBadges: Set<Badge>) -> [Badge] {
        return allBadges.filter { !selectedBadges.contains($0) }
    }
}
