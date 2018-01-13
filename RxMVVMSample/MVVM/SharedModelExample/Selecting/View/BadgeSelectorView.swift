//
//  BadgeSelectorView.swift
//  RxMVVMSample
//
//  Created by 須藤将史 on 2018/01/11.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import UIKit

final class BadgeSelectorView: UIView {
    let selectedCollectionView: UICollectionView
    let selectableCollectionView: UICollectionView
    
    init() {
        let horizontalLayout = UICollectionViewFlowLayout()
        horizontalLayout.scrollDirection = .horizontal
        horizontalLayout.itemSize = CGSize(width: 80, height: 80)
        horizontalLayout.minimumLineSpacing = 10
        horizontalLayout.minimumInteritemSpacing = 10
        horizontalLayout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        selectedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: horizontalLayout)
        selectedCollectionView.translatesAutoresizingMaskIntoConstraints = false
        selectedCollectionView.backgroundColor = UIColor.groupTableViewBackground
        selectedCollectionView.register(BadgeCell.self, forCellWithReuseIdentifier: NSStringFromClass(BadgeCell.self))
        
        let verticalLayout = UICollectionViewFlowLayout()
        verticalLayout.scrollDirection = .vertical
        verticalLayout.itemSize = CGSize(width: 80, height: 80)
        verticalLayout.minimumLineSpacing = 10
        verticalLayout.minimumInteritemSpacing = 10
        verticalLayout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        selectableCollectionView = UICollectionView(frame: .zero, collectionViewLayout: verticalLayout)
        selectableCollectionView.translatesAutoresizingMaskIntoConstraints = false
        selectableCollectionView.backgroundColor = .white
        selectableCollectionView.register(BadgeCell.self, forCellWithReuseIdentifier: NSStringFromClass(BadgeCell.self))
        
        super.init(frame: .zero)

        backgroundColor = .white
        addSubview(selectableCollectionView)
        addSubview(selectedCollectionView)
        
        NSLayoutConstraint.activate([
            selectedCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            selectedCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            selectedCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            selectedCollectionView.heightAnchor.constraint(equalToConstant: 100),
            selectableCollectionView.topAnchor.constraint(equalTo: selectedCollectionView.bottomAnchor),
            selectableCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            selectableCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            selectableCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
