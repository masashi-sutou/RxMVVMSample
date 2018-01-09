//
//  SimpleView.swift
//  RxMVVMSample
//
//  Created by 須藤将史 on 2018/01/10.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import UIKit

final class SimpleView: UIView {
    
    let output: UILabel = UILabel()
    let input: UITextField = UITextField()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
        output.textAlignment = .center
        output.translatesAutoresizingMaskIntoConstraints = false
        addSubview(output)

        input.placeholder = "Please enter text."
        input.textAlignment = .center
        input.keyboardType = .alphabet
        input.autocorrectionType = .no
        input.autocapitalizationType = .none
        input.borderStyle = .roundedRect
        input.translatesAutoresizingMaskIntoConstraints = false
        addSubview(input)
        
        NSLayoutConstraint.activate([
            output.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            output.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            output.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            output.bottomAnchor.constraint(equalTo: input.topAnchor, constant: -15),
            input.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            input.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
