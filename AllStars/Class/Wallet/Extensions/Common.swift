//
//  Common.swift
//  SwiftScanner
//
//  Created by Jason on 2018/11/29.
//  Copyright © 2018 Jason. All rights reserved.
//

import Foundation

//let bundle = Bundle(for: LoadingView.self)

/// 宽度适配(已经 * 0.5)
func KW(W: CGFloat) -> CGFloat {
    return W * kScreenWidth / 375 * 0.5
}
/// 高度适配(已经 * 0.5) UI高度位1624
func KH(H: CGFloat) -> CGFloat {
    return (isIPhoneX) ? ( H / 1.2173913 ) * 736 / 667 * 0.5 :  ( H / 1.2173913 ) * kScreenHeight / 667 * 0.5
}
/// 国际化图片加载
public func imageNamed(_ name:String)-> UIImage{
    
//    let Language =  LanguageTools.shareInstance.getLanguage()
    var imgName = name
//    if Language.hasPrefix("en") {
//        
//        imgName = name + "_en"
//    }
//   else if Language.hasPrefix("ja") {
//        
//        imgName = name + "_ja"
//    }
//   else if Language.hasPrefix("ko") {
//        
//        imgName = name + "_ko"
//    }

    guard let image = UIImage(named: imgName, in: Bundle.main, compatibleWith: nil) else{
        return UIImage()
    }
    
    return image
    
}
public func FitWidthCGFloatAuto(_ float:CGFloat)->CGFloat {
//    let min = UIScreen.main.bounds.height < UIScreen.main.bounds.width ? UIScreen.main.bounds.height :UIScreen.main.bounds.width
    return float
//    return min / 375 * float
}
public func FitHightCGFloatAuto(_ float:CGFloat)->CGFloat {
//    let max = UIScreen.main.bounds.height > UIScreen.main.bounds.width ? UIScreen.main.bounds.height :UIScreen.main.bounds.width
    return float

//   return max / 667 * float
}
