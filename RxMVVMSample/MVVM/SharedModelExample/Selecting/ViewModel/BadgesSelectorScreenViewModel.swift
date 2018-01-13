//
//  BadgesSelectorScreenViewModel.swift
//  RxMVVMSample
//
//  Created by 須藤将史 on 2018/01/11.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class BadgesSelectorScreenViewModel {
    typealias Dependency = (
        selectedModel: SelectedBadgesModelable,
        selectableModel: SelectableBadgesModelable,
        wireframe: BadgeSelectorWireframeable
    )
    typealias Input = (
        doneTap: RxCocoa.Signal<Void>,
        selectedTap: RxCocoa.Signal<Badge>,
        selectableTap: RxCocoa.Signal<Badge>
    )
    
    // There are Child ViewModels.
    let selectedViewModel: SelectedBadgesViewModel
    let selectableViewModel: SelectableBadgesViewModel
    let completionViewModel: BadgeSelectorCompletionViewModel
    
    private let disposeBag = RxSwift.DisposeBag()
    
    init(input: Input, dependency: Dependency) {
        // This is a Model shared between 2 ViewModels.
        let selectedModel: SelectedBadgesModelable = dependency.selectedModel
        
        self.selectedViewModel = SelectedBadgesViewModel(
            input: input.selectedTap,
            // Sharing the Model.
            dependency: selectedModel
        )
        
        self.selectableViewModel = SelectableBadgesViewModel(
            input: input.selectableTap,
            // Sharing the Model.
            dependency: (selectedModel: selectedModel,
                         selectableModel: dependency.selectableModel)
        )
        
        self.completionViewModel = BadgeSelectorCompletionViewModel(
            input: input.doneTap,
            // Sharing the Model.
            dependency: (selectedModel: selectedModel,
                         wireframe: dependency.wireframe)
        )
    }
}
