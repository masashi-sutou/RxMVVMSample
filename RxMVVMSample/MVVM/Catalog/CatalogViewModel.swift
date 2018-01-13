//
//  CatalogViewModel.swift
//  RxMVVMSample
//
//  Created by 須藤将史 on 2018/01/06.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class CatalogViewModel {
    typealias Input = RxCocoa.Signal<Int>
    private let disposeBag = RxSwift.DisposeBag()
    
    let screenRelay: RxCocoa.BehaviorRelay<[ExampleScreen]>
    let screens: RxCocoa.Driver<[ExampleScreen]>
    
    init(input indexSelected: Input, dependency wireframe: CatalogWireframeable) {
        
        let screenRelay = BehaviorRelay(value: ExampleScreen.all)
        
        self.screenRelay = screenRelay
        self.screens = screenRelay.asDriver()
        
        indexSelected
            .emit(onNext: { [weak self] index in
                guard let me = self else { return }
                let screens = me.screenRelay.value
            
                switch screens[index] {
                case .simple:
                    wireframe.goToSimpleExampleScreen()
                case .sharedModel:
                    wireframe.goToSharedModelExampleScreen()
                case .dynamicHierarchalViewModel:
                    wireframe.goToHierarchalViewModelExampleScreen()
                }
            })
            .disposed(by: disposeBag)
    }
}
