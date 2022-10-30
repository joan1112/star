//
//  UIFontExtensions.swift
//  CoinBull
//
//  Created by guanqiang on 2020/12/18.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit

public extension UIFont {
    class func regularFont(_ fontSize: CGFloat) -> UIFont {
        return fontWithName("Roboto-Regular", fontSize)
    }
    class func dinFont(_ fontSize: CGFloat) -> UIFont {
        return fontWithName("PingFang-SC-Medium", fontSize)
    }
    class func boldFont(_ fontSize: CGFloat) -> UIFont {
        return fontWithName("PingFang-SC-Bold", fontSize)
    }
    class func  RobotoBoldFont(_ fontSize: CGFloat) -> UIFont {
        return fontWithName("  Roboto-Bold", fontSize)
    }
  
    class func HeavyFont(_ fontSize: CGFloat) -> UIFont {
        return fontWithName("PingFang-SC-Heavy", fontSize)
    }
    
    class func fontWithName(_ fontName: String, _ fontSize: CGFloat) -> UIFont {
        if let font: UIFont = UIFont(name: fontName, size:fontSize) {
            return font
        }
        return UIFont.systemFont(ofSize: fontSize)
    }
   
}

