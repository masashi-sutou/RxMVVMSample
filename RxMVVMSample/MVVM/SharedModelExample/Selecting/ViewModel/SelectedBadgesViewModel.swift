//
//  SelectedBadgesViewModel.swift
//  RxMVVMSample
//
//  Created by 須藤将史 on 2018/01/11.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class SelectedBadgesViewModel {
    let selectedBadges: RxCocoa.Driver<[Badge]>
    let badgeDidSelect: RxCocoa.Signal<Badge>
    let badgeDidDeselect: RxCocoa.Signal<Badge>
    
    private let selectedModel: SelectedBadgesModelable
    private let disposeBag = RxSwift.DisposeBag()
    
    init(input selectedTap: RxCocoa.Signal<Badge>, dependency selectedModel: SelectedBadgesModelable) {
        
        self.selectedModel = selectedModel
        self.selectedBadges = selectedModel.selectionDidChange
        self.badgeDidSelect = selectedModel.badgeDidSelect
        self.badgeDidDeselect = selectedModel.badgeDidDeselect
        
        selectedTap
            .emit(onNext: { [weak self] badge in
                guard let me = self else { return }
                me.selectedModel.deselect(badge: badge)
            })
            .disposed(by: disposeBag)
    }
}
