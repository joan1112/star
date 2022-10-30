//
//  Utility.swift
//  Turing
//
//  Created by guanqiang on 2020/12/15.
//  Copyright © 2021 Hkk All rights reserved.
//

import UIKit

/// 是否是刘海屏
public let isIPhoneX: Bool = {
    var result = false
    if #available(iOS 11.0, *) {
        guard let window = UIApplication.shared.windows.first else {
            return false
        }
        result = window.safeAreaInsets.bottom > 0
    }
    return result
}()

/// 屏幕宽度
let kScreenWidth: CGFloat = CGFloat(UIScreen.main.bounds.size.width)

/// 屏幕高度
let kScreenHeight: CGFloat = CGFloat(UIScreen.main.bounds.size.height)

/// 1像素宽高
let OnePixel: CGFloat = CGFloat(1.0 / (UIScreen.main.scale))

/// 状态栏高度
let kStatusBarHeight: CGFloat = CGFloat(UIApplication.shared.statusBarFrame.size.height)

/// 导航栏高度
let kNavigationBarHeight: CGFloat = 44.0

/// tabbar 高度
let kTabBarHeight: CGFloat = 49.5

/// 设备屏幕安全区到底部的高度
let kTabbarOffset: CGFloat = (isIPhoneX ? (34.0) : (0.0))

/// 导航栏 + 状态栏高度
let kNavigationTopHeight: CGFloat = (kStatusBarHeight + kNavigationBarHeight)

/// tabbar + 安全区到底部高度
let kTabbarBottomHeight: CGFloat = (kTabBarHeight + kTabbarOffset)

@objcMembers class Utility {
    
    public enum CaculateType {
        case add, subtract, multip, divid
    }
    
    class func decimalNumber(_ target: String, _ floats: Int = Int(Int16.max), _ value: String = "0", _ type: CaculateType = .add, _ isAddZero: Bool = false) -> String {
        var addValue = "0"
        var targetValue = "0"
        if target.count > 0 { targetValue = target }
        if value.count > 0 { addValue = value }
        let num1 = NSDecimalNumber.init(string: targetValue)
        let num2 = NSDecimalNumber.init(string: addValue)
        
        var mode: NSDecimalNumber.RoundingMode = .down
        let handler = decimalNumberHandler(floats, mode)
        var finalString: String = ""
        switch type {
        case .add:
            mode = (num1.doubleValue + num2.doubleValue) >= 0 ? .down : .up
            finalString = num1.adding(num2, withBehavior: handler).stringValue
            break
        case .subtract:
            mode = (num1.doubleValue - num2.doubleValue) >= 0 ? .down : .up
            finalString = num1.subtracting(num2, withBehavior: handler).stringValue
            break
        case .multip:
            mode = (num1.doubleValue * num2.doubleValue) >= 0 ? .down : .up
            finalString = num1.multiplying(by: num2, withBehavior: handler).stringValue
            break
        case .divid:
            if num2.doubleValue == 0 {
                return "0"
            }else {
                mode = (num1.doubleValue / num2.doubleValue) >= 0 ? .down : .up
                finalString = num1.dividing(by: num2, withBehavior: handler).stringValue
            }
            break
        }
        if isAddZero == false || floats == 0 { return finalString }
        return finalString.makeUpZero(floats)
    }

    /// 计算方式
    class func decimalNumberHandler(_ floats: Int, _ mode: NSDecimalNumber.RoundingMode = .down) -> NSDecimalNumberHandler {
        let handler = NSDecimalNumberHandler.init(roundingMode: mode, scale: Int16(floats), raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)
        return handler
    }
    
    /// window
    class func getWindow() -> UIWindow? {
        guard let view = UIApplication.shared.keyWindow?.rootViewController?.view else {
            return nil
        }
        return view.window
    }
}
