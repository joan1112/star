//
//  UIViewControllerExtensions.swift
//  CoinBull
//
//  Created by guanqiang on 2020/12/29.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit

extension UIViewController {

    /// 是否需要隐藏导航栏
    static var kNavBarIsNeedHidden: String = "kNavBarIsNeedHidden"
    var navBarIsNeedHidden: Bool {
        get {
            return objc_getAssociatedObject(self, &UIViewController.kNavBarIsNeedHidden) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &UIViewController.kNavBarIsNeedHidden, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
