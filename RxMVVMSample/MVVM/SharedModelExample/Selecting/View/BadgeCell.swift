//
//  BadgeCell.swift
//  RxMVVMSample
//
//  Created by 須藤将史 on 2018/01/13.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import UIKit

final class BadgeCell: UICollectionViewCell {
    
    let titleLabel: UILabel
    var badge: Badge? {
        didSet {
            guard let badge = self.badge else {
                titleLabel.text = nil
                backgroundColor = UIColor.black
                return
            }
            
            titleLabel.text = badge.title
            backgroundColor = badge.color
        }
    }
    
    override init(frame: CGRect) {
        titleLabel = UILabel()
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 10, weight: .heavy)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        super.init(frame: frame)
        
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = min(bounds.width, bounds.height) / 2
    }
    
    static func dequeue(from collectionView: UICollectionView, for indexPath: IndexPath, badge: Badge) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(BadgeCell.self),
                                                            for: indexPath) as? BadgeCell else {
            fatalError("Please register BadgeCell")
        }
        
        cell.badge = badge
        return cell
    }
}
