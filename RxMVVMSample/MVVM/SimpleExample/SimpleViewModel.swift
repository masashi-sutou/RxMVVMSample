//
//  SimpleViewModel.swift
//  RxMVVMSample
//
//  Created by 須藤将史 on 2018/01/10.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class SimpleViewModel {
    let outputText: RxCocoa.Driver<String?>
    
    init(input inputText: RxCocoa.Driver<String?>) {
        self.outputText = inputText
            .map { text in
                if let t = text, t.isEmpty {
                    return "UPPERCASED TEXT OUTPUT"
                } else {
                    return text?.uppercased()
                }
            }
            .asDriver()
    }
}
