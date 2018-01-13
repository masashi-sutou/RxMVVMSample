//
//  BadgesDummyRepository.swift
//  RxMVVMSample
//
//  Created by 須藤将史 on 2018/01/12.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import UIKit
import RxSwift

final class BadgesDummyRepository: BadgesRepositorable {
    private let constantRepository: BadgesConstantRepository
    
    init() {
        self.constantRepository = BadgesConstantRepository(returning: (0..<100).map { id in
            let color = BadgesDummyRepository.generateRandomBadgeColor()
            return Badge(id: id, title: color.hex, color: color.value)
        })
    }
    
    func get(by parameters: Void) -> RxSwift.Single< Result<[Badge], Never>> {
        return self.constantRepository.get(by: parameters)
    }
    
    private static func generateBadgeColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> (hex: String, value: UIColor) {
        return (
            hex: String(
                format: "#%02X%02X%02X",
                arguments: [
                    Int(red * 256),
                    Int(green * 256),
                    Int(blue * 256),
                    ]
            ),
            value: UIColor(red: red, green: green, blue: blue, alpha: 1)
        )
    }
    
    private static func generateRandomBadgeColor() -> (hex: String, value: UIColor) {
        return self.generateBadgeColor(
            red: CGFloat(arc4random() % 100) / 100,
            green: CGFloat(arc4random() % 100) / 100,
            blue: CGFloat(arc4random() % 100) / 100
        )
    }    
}
