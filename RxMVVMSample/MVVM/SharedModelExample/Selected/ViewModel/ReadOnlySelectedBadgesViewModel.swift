//
//  ReadOnlySelectedBadgesViewModel.swift
//  RxMVVMSample
//
//  Created by 須藤将史 on 2018/01/13.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import Foundation
import RxCocoa

final class ReadOnlySelectedBadgesViewModel {
    let selectedBadges: RxCocoa.Driver<[Badge]>
    
    private let selectedModel: SelectedBadgesModelable
    
    init(dependency selectedModel: SelectedBadgesModelable) {
        self.selectedModel = selectedModel
        self.selectedBadges = selectedModel.selectionDidChange
    }
}
