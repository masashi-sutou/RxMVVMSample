//
//  ExampleScreen.swift
//  RxMVVMSample
//
//  Created by 須藤将史 on 2018/01/06.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import Foundation

enum ExampleScreen {
    case simple
    case sharedModel
    case dynamicHierarchalViewModel
    
    var title: String {
        switch self {
        case .simple:
            return "Simple"
        case .sharedModel:
            return "Shared Model"
        case .dynamicHierarchalViewModel:
            return "Dynamic Hierarchal ViewModel"
        }
    }
    
    static let all: [ExampleScreen] = [.simple, .sharedModel, .dynamicHierarchalViewModel]
}
