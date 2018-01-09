//
//  SimpleViewController.swift
//  RxMVVMSample
//
//  Created by 須藤将史 on 2018/01/10.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SimpleViewController: UIViewController {
    private let simpleView: SimpleView
    private let viewModel: SimpleViewModel
    private let disposeBag = RxSwift.DisposeBag()
    
    init() {
        self.simpleView = SimpleView()
        self.viewModel = SimpleViewModel(input: simpleView.input.rx.text.asDriver())
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = simpleView
        self.title = "Echo"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.outputText
            .drive(simpleView.output.rx.text)
            .disposed(by: disposeBag)
    }
}
