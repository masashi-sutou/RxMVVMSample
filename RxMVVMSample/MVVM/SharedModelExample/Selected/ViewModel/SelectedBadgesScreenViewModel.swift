//
//  SelectedBadgesScreenViewModel.swift
//  RxMVVMSample
//
//  Created by 須藤将史 on 2018/01/13.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class SelectedBadgesScreenViewModel {
    typealias Dependency = (
        selectedModel: SelectedBadgesModelable,
        wireframe: PresentedViewControllerWireframeable
    )
    let selectedViewModel: ReadOnlySelectedBadgesViewModel
    private let dependency: Dependency
    private let disposeBag = RxSwift.DisposeBag()
    
    init(input backTap: RxCocoa.Signal<Void>, dependency: Dependency) {
        self.dependency = dependency
        self.selectedViewModel = ReadOnlySelectedBadgesViewModel(dependency: dependency.selectedModel)
        
        backTap
            .emit(onNext: { [weak self] _ in
                guard let me = self else { return }
                me.dependency.wireframe.goBack()
            })
            .disposed(by: disposeBag)
    }
}
