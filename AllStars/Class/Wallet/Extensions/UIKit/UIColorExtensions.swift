//
//  UIColorExtensions.swift
//  Turing
//
//  Created by guanqiang on 2020/12/15.
//  Copyright © 2021 Hkk All rights reserved.
//

import UIKit


extension UIColor {
    
    
    //    darkBlack
  
    
    class func coinYellowColor() -> UIColor {
        return hex(0xF2591B)
    }
//    CDA365
    class func hkYellowColor() -> UIColor {
        return hex(0xCDA365)
    }
//    darkBlack
    class func darkBlackColor() -> UIColor {
    return hex(0x333333)
    }
    /// 金色 EDC379
    
    class func kingColor() -> UIColor {
    return hex(0xEDC379)
    }
    class func lightBlueColor() -> UIColor {
    return hex(0xEBF0FA)
    }
    class func backBlueColor() -> UIColor {
    return hex(0xEBF0FA)
    }
    class func lineBlueColor() -> UIColor {
        return hex(0x336DE5).withAlphaComponent(0.2)
    }
//
    /// navtitle色 -- 黄色
    class func yellowColor() -> UIColor {
        return hex(0xFFD12F)
    }
    /// navtitle色 -- 白色
    class func cloudBgColor() -> UIColor {
        return hex(0xF5F7FA)
    }
    /// navtitle色 -- 白色
    class func navWhiteTitleColor() -> UIColor {
        return hex(0xFFFFFF)
    }
   
    ///
    /// navtitle色 -- 黑色
    class func navTitleColor() -> UIColor {
        return hex(0x111111)
    }
    /// navtitle色 -- 黑色
    class func navbackColor() -> UIColor {
        return hex(0xFFFFFF)
    }
    /// cell色 -- 白色
    class func lightWhiteBgColor() -> UIColor {
        return hex(0xFFFFFF).withAlphaComponent(0.5)
    }
    /// cell色 -- 白色
    class func cellBgColor() -> UIColor {
        return hex(0xFFFFFF)
    }
    /// shareBgColor
    class func shareBgColor() -> UIColor {
        return hex(0x0A2779)
    }
    /// cell背景色 -- 灰色
    class func cellContentBgColor() -> UIColor {
        return hex(0xF1F1F1)
    }
    /// cell背景色 -- 灰色
    class func hotgoodBgColor() -> UIColor {
        return hex(0xF6F6F6)
    }
    class func viewBgColor() -> UIColor {
        return hex(0xF4F7F8)
    }
    /// 主题色 -- 绿色
    class func mainColor() -> UIColor {
        return hex(0x334052)
    }
    class func loginWhite() -> UIColor {
        return hex(0xFFFFFF)
    }
    
    class func disableColor() -> UIColor {
        return hex(0xA7B1BB)
    }
    
    /// 涨幅颜色 --（绿色）
    class func riseColor() -> UIColor {
        return hex(0x00BA9A)
    }
    
    /// 跌幅颜色 --（红色）
    class func fallColor() -> UIColor {
        return hex(0xFE535B)
    }
    
    /// 跌幅颜色 --（不涨不跌的颜色）
    class func flatColor() -> UIColor {
        return hex(0x89A0A7)
    }
    /// 文字颜色 -- 红色
    class func textColorRed() -> UIColor {
        return hex(0xEA2424)
    }
    class func HomeRed() -> UIColor {
        return hex(0xE34242)
    }
    
    class func textLabelRed() -> UIColor {
        return hex(0xFCDEDE)
    }
    class func processColorYellow() -> UIColor {
        return hex(0xFF8A2B)
    }
    /// 背景颜色 -- 大黑色
    class func mainBlackColor() -> UIColor {
        return hex(0x262626)
    }
    /// 红包按钮背景
    class func yellowButtonColor() -> UIColor {
        return hex(0xF7D290)
    }
    /// 红包按钮颜色 -- 大黄
    class func yellowBacketColor() -> UIColor {
        return hex(0xFDE583)
    }
    /// 红包按钮颜色 -- 大红色
    class func redBacketMainColor() -> UIColor {
        return hex(0xDD1B07)
    }
    /// 红包按钮颜色 -- 大黑色
    class func redBacketTitleColor() -> UIColor {
        return hex(0x472009)
    }
    /// 文字颜色 -- 大黑色
    class func mainTitleColor() -> UIColor {
        return hex(0x1E2934)
    }
    /// 文字颜色 -- 取消按钮标题色
    class func copyColor() -> UIColor {
        return hex(0x0A2779)
    }
    /// 文字颜色 -- 取消按钮标题色
    class func cancelColor() -> UIColor {
        return hex(0xB3B3B3)
    }
    /// 文字颜色 -- 大黑色
    class func textColor272E30() -> UIColor {
        return hex(0x111111)
    }
    /// 文字颜色 -- 白色
    class func textColorFFFFFF() -> UIColor {
        return hex(0xFFFFFF)
    }
    /// View颜色 -- 粉红色
    class func bgRed() -> UIColor {
        return hex(0xEA2424).withAlphaComponent(0.15)
    }
    
    /// placeColor颜色 -- 浅色
    class func loginPlaceColor() -> UIColor {
        return hex(0xFFFFFF).withAlphaComponent(0.4)
    }
    /// placeColor颜色 -- 灰色
    class func loginBlackPlaceColor() -> UIColor {
        return hex(0x999999)
    }
    /// 文字颜色 -- 浅色
    class func textColorA7B1BB() -> UIColor {
        return hex(0xA7B1BB)
    }
    /// 文字颜色--副标题浅色
    class func textColorSubTitle() -> UIColor {
        return hex(0x555555)
    }
    /// 文字颜色--副标题浅色
    class func textColorSubTitle2() -> UIColor {
        return hex(0xB2B2B2)
    }
    /// 文字颜色--次浅色
    class func textLightColor() -> UIColor {
        return hex(0x999999)
    }
    /// cell文字颜色--次浅色
    class func cellLightColor() -> UIColor {
        return hex(0x666666)
    }
    /// cell文字颜色--次浅色
    class func shadowLightColor() -> UIColor {
        return hex(0x666666)
    }
   /// 主题--蓝色
    class func mainBgColor() -> UIColor {
        return hex(0x341D11 )
    }
    /// 设置资金密码--蓝色
     class func unselceBgColor() -> UIColor {
         return hex(0x8EAEF0)
     }
    /// 状态按钮--背景色
     class func statusBgColor() -> UIColor {
         return hex(0xDBDBDB)
     }
    class func buttonLineColor() -> UIColor {
        return hex(0xA8A8A8)
    }
    class func redBacketColor() -> UIColor {
        
        return hex(0xD53737)
    }
    /// cell分割线颜色
    class func cellLineColor() -> UIColor {
        return hex(0xE6E6E6)
    }
    /// 分割线颜色
    class func lineColor() -> UIColor {
        return hex(0xA7B1BB).withAlphaComponent(0.15)
    }
    class func setPassBackColor() -> UIColor {
        return hex(0x336DE5).withAlphaComponent(0.1)
    }
    class func labelBlueBackColor() -> UIColor {
        return hex(0x336DE5).withAlphaComponent(0.15)
    }
    /// 分割线颜色
    class func loginLineColor() -> UIColor {
        return hex(0xFFFFFF).withAlphaComponent(0.15)
    }
    /// kLine -- 白色
    class func kLineWhiteColor() -> UIColor {
        return .hex(0xEDF6F8)
    }
    
    /// kLine -- 浅黑色
    class func kLineLightDarkColor() -> UIColor {
        return hex(0x151E26)
    }
    
    /// kLine -- 黑色
    class func kLineDarkColor() -> UIColor {
        return hex(0x13191E)
    }
    
    /// kLine -- 文字颜色 - 灰色
    class func kLineTextGrayColor() -> UIColor {
        return hex(0x5A7079)
    }
    
    /// 边框颜色
    class func borderColor() -> UIColor {
        return hex(0xD9E1E7)
    }
    
    class func hex(_ hex: UInt) -> UIColor {
        return hexAlpha(hex, alpha: 1.0)
    }
    
    class func hexAlpha(_ hex: UInt, alpha: Float) -> UIColor {
        return UIColor(red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
                       blue: CGFloat(hex & 0x0000FF) / 255.0,
                       alpha: CGFloat(alpha))
    }
    
    /// 随机颜色
    class var randomColor: UIColor {
        get {
            let red = CGFloat(arc4random() % 256) / 255.0
            let green = CGFloat(arc4random() % 256) / 255.0
            let blue = CGFloat(arc4random() % 256) / 255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}
