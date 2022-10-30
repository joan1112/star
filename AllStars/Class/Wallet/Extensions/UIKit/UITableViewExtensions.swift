//
//  UITableViewExtensions.swift
//  Turing
//
//  Created by guanqiang on 2020/12/15.
//  Copyright © 2021 Hkk All rights reserved.
//

import UIKit

extension UITableView {
    
    class func tableView(_ style: UITableView.Style = .plain, _ delegate: AnyObject? = nil, _ backColor: UIColor? = nil, _ superView: UIView? = nil) -> UITableView {
        return tableView(CGRect(x: 0, y: 0, width: 0, height: 0), style, delegate, backColor, superView)
    }
    
    class func tableView(_ rect: CGRect, _ style: UITableView.Style = .plain, _ delegate: AnyObject? = nil, _ backColor: UIColor? = nil, _ superView: UIView? = nil) -> UITableView {
        let tableView = UITableView.init(frame: rect, style: style)
        if delegate != nil {
            tableView.delegate = delegate as? UITableViewDelegate
            tableView.dataSource = delegate as? UITableViewDataSource
        }
        if backColor != nil {tableView.backgroundColor = backColor}
        tableView.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.tableFooterView = UIView()
        if superView != nil {superView?.addSubview(tableView)}
        return tableView
    }
}
