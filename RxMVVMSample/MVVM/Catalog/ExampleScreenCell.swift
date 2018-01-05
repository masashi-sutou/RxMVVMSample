//
//  ExampleScreenCell.swift
//  RxMVVMSample
//
//  Created by 須藤将史 on 2018/01/06.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import UIKit

final class ExampleScreenCell: UITableViewCell {
    static let reuseIdentifier = "ScreenCell"
    
    var screen: ExampleScreen? {
        didSet {
            textLabel?.text = screen?.title
        }
    }
    
    class func register(to tableView: UITableView) {
        tableView.register(self, forCellReuseIdentifier: reuseIdentifier)
    }
}
