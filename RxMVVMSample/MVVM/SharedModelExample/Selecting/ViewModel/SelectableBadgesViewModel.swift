//
//  SelectableBadgesViewModel.swift
//  RxMVVMSample
//
//  Created by 須藤将史 on 2018/01/11.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class SelectableBadgesViewModel {
    typealias Dependency = (
        selectedModel: SelectedBadgesModelable,
        selectableModel: SelectableBadgesModelable
    )
    let selectableBadges: RxCocoa.Driver<[Badge]>
    
    private let dependency: Dependency
    private let disposeBag = RxSwift.DisposeBag()
    
    init(input selectableTap: RxCocoa.Signal<Badge>, dependency: Dependency) {
        self.dependency = dependency
        self.selectableBadges = dependency.selectableModel.selectableBadgesDidChange
        
        selectableTap
            .emit(onNext: { [weak self] badge in
                guard let me = self else { return }
                me.dependency.selectedModel.select(badge: badge)
            })
            .disposed(by: disposeBag)
    }
}
