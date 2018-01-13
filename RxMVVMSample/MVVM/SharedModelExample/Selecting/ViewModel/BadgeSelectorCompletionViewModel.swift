//
//  BadgeSelectorCompletionViewModel.swift
//  RxMVVMSample
//
//  Created by 須藤将史 on 2018/01/12.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class BadgeSelectorCompletionViewModel {
    typealias Dependency = (
        selectedModel: SelectedBadgesModelable,
        wireframe: BadgeSelectorWireframeable
    )
    
    let canComplete: RxCocoa.Driver<Bool>
    
    private let dependency: Dependency
    private let disposeBag = RxSwift.DisposeBag()
    
    init(input doneTap: RxCocoa.Signal<Void>, dependency: Dependency) {
        self.dependency = dependency
        self.canComplete = dependency.selectedModel
            .selectionDidChange
            .map { selection in
                !selection.isEmpty
            }
            .asDriver()
        
        doneTap
            .emit(onNext: { [weak self] _ in
                guard let me = self else { return }
                me.dependency.wireframe.goToSelectedBadgesViewScreen(with: me.dependency.selectedModel)
            })
            .disposed(by: disposeBag)
    }
}
