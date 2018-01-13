//
//  SelectedBadgesViewController.swift
//  RxMVVMSample
//
//  Created by 須藤将史 on 2018/01/12.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class SelectedBadgesViewController: UIViewController {

    private let selectedBadgesModel: SelectedBadgesModelable
    private let mainView: SelectedBadgesView
    private let backButton: UIBarButtonItem
    
    private var viewModel: SelectedBadgesScreenViewModel?
    private let disposeBag = RxSwift.DisposeBag()
    
    init(dependency selectedBadgesModel: SelectedBadgesModelable) {
        self.selectedBadgesModel = selectedBadgesModel
        self.mainView = SelectedBadgesView()
        self.backButton = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = mainView
        self.title = "Selected Badges"
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewModel = SelectedBadgesScreenViewModel(
            input: backButton.rx
                .tap
                .asSignal(onErrorSignalWith: .empty()),
            dependency: (
                selectedModel: selectedBadgesModel,
                wireframe: PresentedViewControllerWireframe(willDismiss: self)
            )
        )
        self.viewModel = viewModel // MARK: Prevent removing by ARC.
        
        let selectedDataSource = RxDataSources.RxCollectionViewSectionedAnimatedDataSource<RxDataSources.AnimatableSectionModel<String, Badge>>(configureCell: { (dataSource, collectionView, indexPath, badge) -> UICollectionViewCell in
            return BadgeCell.dequeue(from: collectionView, for: indexPath, badge: badge)
        }, configureSupplementaryView: { (dataSource, collectionView, string, indexPath) -> UICollectionReusableView in
            return UICollectionViewCell()
        })
        
        viewModel.selectedViewModel.selectedBadges
            .map { badges in
                [RxDataSources.AnimatableSectionModel(model: "Selected", items: badges)]
            }
            .drive(mainView.selectedCollectionView.rx.items(dataSource: selectedDataSource))
            .disposed(by: disposeBag)
    }
}
