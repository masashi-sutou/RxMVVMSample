//
//  CatalogViewController.swift
//  RxMVVMSample
//
//  Created by 須藤将史 on 2018/01/06.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class CatalogViewController: UIViewController {

    typealias Dependency = CatalogWireframeable
    
    private let dependency: Dependency
    private let tableView: UITableView
    private let disposeBag = RxSwift.DisposeBag()
    private var viewModel: CatalogViewModel?
    
    init(dependency: Dependency) {
        self.dependency = dependency
        self.tableView = UITableView(frame: .zero, style: .grouped)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = tableView
        self.title = "Examples"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ExampleScreenCell.register(to: tableView)
        
        let input: RxCocoa.Signal<Int> = tableView.rx
            .itemSelected.do(onNext: { [weak self] indexPath in
                guard let me = self else { return }
                me.tableView.deselectRow(at: indexPath, animated: true)
            })
            .map { indexPath in indexPath.row }
            .asSignal(onErrorSignalWith: .empty())
        let viewModel = CatalogViewModel(input: input, dependency: dependency)
        self.viewModel = viewModel
        
        viewModel.screens
            .drive(tableView.rx.items(cellIdentifier: ExampleScreenCell.reuseIdentifier, cellType: ExampleScreenCell.self), curriedArgument: { _, screen, cell in
                cell.screen = screen
            })
            .disposed(by: disposeBag)
    }
}
