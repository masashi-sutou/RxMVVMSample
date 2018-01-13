//
//  SelectedBadgesView.swift
//  RxMVVMSample
//
//  Created by 須藤将史 on 2018/01/13.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import UIKit

final class SelectedBadgesView: UIView {
    let selectedCollectionView: UICollectionView
    
    init() {
        let verticalLayout = UICollectionViewFlowLayout()
        verticalLayout.scrollDirection = .vertical
        verticalLayout.itemSize = CGSize(width: 80, height: 80)
        verticalLayout.minimumLineSpacing = 10
        verticalLayout.minimumInteritemSpacing = 10
        verticalLayout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        selectedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: verticalLayout)
        selectedCollectionView.translatesAutoresizingMaskIntoConstraints = false
        selectedCollectionView.backgroundColor = .white
        selectedCollectionView.register(BadgeCell.self, forCellWithReuseIdentifier: NSStringFromClass(BadgeCell.self))
        
        super.init(frame: .zero)
        
        backgroundColor = .white
        addSubview(selectedCollectionView)
        
        NSLayoutConstraint.activate([
            selectedCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            selectedCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            selectedCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            selectedCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
