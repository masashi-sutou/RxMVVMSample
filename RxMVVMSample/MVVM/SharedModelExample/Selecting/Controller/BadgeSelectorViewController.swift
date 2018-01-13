//
//  BadgeSelectorViewController.swift
//  RxMVVMSample
//
//  Created by 須藤将史 on 2018/01/11.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class BadgeSelectorViewController: UIViewController {
    typealias Dependency = (
        selectedBadgesModel: SelectedBadgesModelable,
        selectableBadgesModel: SelectableBadgesModelable
    )
    
    private let dependency: Dependency
    private let mainView: BadgeSelectorView
    private let doneButton: UIBarButtonItem
    private var viewModel: BadgesSelectorScreenViewModel?
    private let disposeBag = RxSwift.DisposeBag()
    
    init(dependency: Dependency) {
        self.dependency = dependency
        
        self.mainView = BadgeSelectorView()
        self.doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = mainView
        self.navigationItem.rightBarButtonItem = doneButton
        self.title = "Select Badges"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewModel = BadgesSelectorScreenViewModel(
            input: (
                doneTap: doneButton.rx
                    .tap
                    .asSignal(onErrorSignalWith: .empty()),
                selectedTap: mainView.selectedCollectionView.rx
                        .modelSelected(Badge.self)
                        .asSignal(onErrorSignalWith: .empty()),
                selectableTap: mainView.selectableCollectionView.rx
                        .modelSelected(Badge.self)
                        .asSignal(onErrorSignalWith: .empty())
            ),
            dependency: (
                selectedModel: dependency.selectedBadgesModel,
                selectableModel: dependency.selectableBadgesModel,
                wireframe: BadgeSelectorWireframe(on: self)
            )
        )
        self.viewModel = viewModel // MARK: Prevent removing by ARC.
        
        let selectedDataSource = RxCollectionViewSectionedAnimatedDataSource<RxDataSources.AnimatableSectionModel<String, Badge>>(configureCell: { (dataSource, collectionView, indexPath, badge) -> UICollectionViewCell in
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
        
        viewModel.selectedViewModel.badgeDidDeselect
            .emit(onNext: { [weak self] badge in
                guard let me = self else { return }
                DispatchQueue.main.async {
                    me.scroll(to: badge)
                }
            })
            .disposed(by: disposeBag)
        
        let selectableDataSource = RxCollectionViewSectionedAnimatedDataSource<RxDataSources.AnimatableSectionModel<String, Badge>>(configureCell: { (dataSource, collectionView, indexPath, badge) -> UICollectionViewCell in
            return BadgeCell.dequeue(from: collectionView, for: indexPath, badge: badge)
        }, configureSupplementaryView: { (dataSource, collectionView, string, indexPath) -> UICollectionReusableView in
            UICollectionViewCell()
        })
        
        viewModel.selectableViewModel.selectableBadges
            .map { badges in
                [RxDataSources.AnimatableSectionModel(model: "Selectable", items: badges)]
            }
            .drive(mainView.selectableCollectionView.rx.items(dataSource: selectableDataSource))
            .disposed(by: disposeBag)
        
        viewModel.completionViewModel
            .canComplete
            .drive(doneButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    private func scroll(to badge: Badge) {
        guard let index = dependency.selectedBadgesModel.currentSelection.index(of: badge), isAvailableIndex(index) else {
            return
        }
        
        mainView.selectedCollectionView.scrollToItem(
            at: IndexPath(row: index, section: 0),
            at: .centeredHorizontally,
            animated: true
        )
    }
    
    /*
     MARK: This is a workaround for animated cell changes.
           It is necessary because we cannot detect when the new cell is added.
     */
    private func isAvailableIndex(_ index: Int) -> Bool {
        guard let dataSource = mainView.selectedCollectionView.dataSource else {
            return false
        }
        
        let numberOfItems = dataSource.collectionView(mainView.selectedCollectionView, numberOfItemsInSection: 0)
        return index < numberOfItems
    }
}
