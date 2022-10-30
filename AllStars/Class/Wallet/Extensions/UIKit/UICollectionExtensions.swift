//
//  UICollectionExtensions.swift
//  Turing
//
//  Created by guanqiang on 2020/12/15.
//  Copyright © 2021 Hkk All rights reserved.
//

import UIKit

extension UICollectionView {
    
    class func initCollectionView(_ rect: CGRect, layout: UICollectionViewFlowLayout, _ delegate: AnyObject? = nil, _ backColor: UIColor? = nil, _ superView: UIView? = nil) -> UICollectionView {
        let collectionView = UICollectionView.init(frame: rect, collectionViewLayout: layout)
        if delegate != nil {
            collectionView.delegate = delegate as? UICollectionViewDelegate
            collectionView.dataSource = delegate as? UICollectionViewDataSource
        }
        if backColor != nil {collectionView.backgroundColor = backColor}
        collectionView.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        collectionView.alwaysBounceVertical = true
        if superView != nil {superView?.addSubview(collectionView)}
        return collectionView
    }
}
