//
//  ColorConfig.swift
//  CoinBull
//
//  Created by WuQiaoqiao on 2020/5/15.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit
enum GSColor {
    case  navColor
    case  tabbarColor
    case  bgColor
    case  lineColor
    case  btnColor
    case  tabNormal
    case  tabSelect
    case  titleColor
    case themeColor
    case brownColor

    var color: UIColor {
        
        var colorName = "global.bgColor"
        
        switch self {
        case .navColor:
             colorName = "navBg"
        case .tabbarColor:
             colorName = "navBg"
        case .bgColor:
            colorName = "global.bgColor"
        case .lineColor:
            colorName = "global.tintColor"
        case .btnColor:
            colorName = "global.btTitleColor"
        case .tabNormal:
            colorName = "tabbar.titleNormal"
        case .tabSelect:
            colorName = "tabbar.titleSelected"

        case .titleColor:
            colorName = "main.TitleColor"

        case .themeColor:
            colorName = "themeColor"
        case .brownColor:
            colorName = "zongSe"

        }
        if #available(iOS 11.0, *) {
            return UIColor.init(named: colorName) ?? .white
        } else {
            // Fallback on earlier versions
        }

        
    }
}
enum MyTS {
    case shadowColor
    case  titleColor
    case  bgColor
    case  subTitleColor
    case  subTitleColor2
    case  yellowColor
    case  greenColor
    case  addTitleColor
    case  lineColor
    case  sliderColor
    case midBackColor
    case  redColor
    
    var color: UIColor {
        
        var colorName = "global.bgColor"
        
        switch self {
            
            case .shadowColor:
                
                colorName = "ts.shadowColor"
            
            case .titleColor:
                
                colorName = "face.titleColor"
            
            case .bgColor:
                colorName = "ts.backColor"
            
            case .subTitleColor:
                
                colorName = "ts.subTitle"
            
            case .subTitleColor2:
                colorName = "ts.subTitle2"
            
            case .yellowColor:
                
                colorName = "ts.yellowColor"
            
            case .greenColor:
                
                colorName = "ts.greenColor"
            
            case .addTitleColor:
                
                colorName = "ts.addTitile"
            case .lineColor:
                colorName = "ts.lineColor"
            case .sliderColor:
                colorName = "ts.sliderColor"
            case .midBackColor:
                colorName = "ts.addMidBack"
            
            case .redColor:
                colorName = "themeColor"
            
        }
        
        return UIColor.init(named: colorName)!
    }
}

enum EEcolor {
    case unGet
    case getTed
    case timeOut
    case black
    var color: UIColor {
        
        var colorName = "ee.unGet"
        
        switch self {
            
        case .unGet:
                
            colorName = "ee.unGet"
           
        case .getTed:
                
            colorName = "ee.Geted"
           
        case .timeOut:
               
            colorName = "ee.timeOut"
         
        case .black:
            colorName = "ee.black"
        }
        return UIColor.init(named: colorName)!
    }
}
enum HomePage {
    case viewBg
    case navBg
    case priceDownBg
    case priceUpBg
    case cellTitle2
    case lineBg
    case shadow
    
    var color: UIColor {
        
        var colorName = "global.bgColor"
        
        switch self {
            case .viewBg:
                colorName = "global.bgColor"
            case .navBg:
                colorName = "global.bgColor"
            case .priceDownBg:
                
               
                colorName =  "home.priceUpBg"
            case .priceUpBg:
            
                colorName =  "home.priceDownBg"
            case .cellTitle2:
                colorName = "home.tableCellTitle2"
            case .lineBg:
                colorName = "home.tableCellTitle2"
            case .shadow:
                colorName = "home.shadowColor"
        }
        return UIColor.init(named: colorName)!
    }
}

enum ContractModul {
    case topItemTitle
    case buyTheme
    case sellTheme
    case segmentTitle
    case segmentTitleSelected
    case title
    case kLineTitle
    case shadow
    case eeColor

    var color: UIColor {
        var colorName = "global.bgColor"
        
        switch self {
            case .topItemTitle:
                colorName = "contract.topItemTitleColor"
            case .buyTheme:
                colorName = "contract.buyThemeColor"
            case .sellTheme:
                colorName = "contract.sellThemeColor"
            case .segmentTitle:
                colorName = "contract.segmentTitleColor"
            case .segmentTitleSelected:
                colorName = "contract.segmentSelectedTitleColor"
            case .title:
                colorName = "contract.titleColor"
            case .kLineTitle:
                colorName = "kLine.TitleColor"
            case .shadow:
                colorName = "contract.shadowColor"
            case .eeColor:
                colorName = "contract.eeLabelColor"

        }
        
        return UIColor.init(named: colorName)!
    }
}

enum AssetModul {
    case topBarTitle
    case cellSubTitle
    case cellBgColor
    case topBarTitleSelected
    case topBGColor
    case topBtnColor
    var color: UIColor {
        var colorName = "global.bgColor"
        
        switch self {
            case .topBarTitle:
                colorName = "asset.topBarTitleColor"
            case .topBarTitleSelected:
                colorName = "asset.topBarTitleSelectedColor"
        case .topBGColor:
            colorName = "asset.topBack"
            //            case .sellTheme:
            //                colorName = "contract.sellThemeColor"
            //            case .segmentTitle:
            //                colorName = "contract.segmentTitleColor"
            //            case .segmentTitleSelected:
            //                colorName = "contract.segmentSelectedTitleColor"
            //            case .title:
            //                colorName = "contract.titleColor"
            //            case .kLineTitle:
            //                colorName = "kLine.TitleColor"
        case .topBtnColor:
            
            colorName = "asset.topBtnColor"

        case .cellSubTitle:
            colorName = "asset.subTitle"

        case .cellBgColor:
            colorName = "asset.cellBgColor"
        }
        
        return UIColor.init(named: colorName)!
    }
}

enum LoginModul {
    case placeHolder
    case buttonDisable
    
    var color: UIColor {
        
        var colorName = "global.bgColor"
        
        switch self {
            case .placeHolder:
                colorName = "login.placeholder"
            case .buttonDisable:
                colorName = "login.buttonDisable"
            //                   case .priceDownBg:
            //                       colorName = "home.priceDownBg"
            //                   case .priceUpBg:
            //                       colorName = "home.priceUpBg"
            //                   case .cellTitle2:
            //                       colorName = "home.tableCellTitle2"
            //                   case .lineBg:
            //                       colorName = "home.tableCellTitle2"
            //                   case .shadow:
            //                       colorName = "home.shadowColor"
        }
        return UIColor.init(named: colorName)!
        
    }
}
enum ETFColor {
    
    case lineColor
    
    var color: UIColor {
        var colorName = "global.bgColor"
        
        switch self {
            case .lineColor:
                
                colorName = "bordLine.Color"
                break
            
        }
        return UIColor.init(named: colorName)!
        
    }
    
}
enum FaceLogin {
    
    case titleColor
    case btColor
    case bttitleColor
    case safeTitleColor
    case gestureNormal
    case gestureSelected
    case gestureError
    
    
    var color: UIColor {
        var colorName = "global.bgColor"
        
        switch self {
            case .titleColor:
                colorName = "face.titleColor"
            
            case .btColor:
                colorName = "fece.btColor"
            
            case .bttitleColor:
                colorName = "home.title3"
            
            case .safeTitleColor:
                colorName = "asset.titleColor2"
            
            case .gestureNormal:
                
                colorName = "gesture.normal"
            
            case .gestureSelected:
                
                colorName = "gesture.selected"
            
            case .gestureError:
                
                colorName = "gesture.error"
            
        }
        
        return .white
    }
}


enum Global {
    case theme
    case viewBg
    case navBg
    case priceDownBg
    case priceUpBg
    case kLineDown
    case kLineUp
    case cellTitle2
    case lineBg
    case tint
    
    case btTitle
    
    
    case loginLineBg
    case title3
    case title2
    
    
    var color: UIColor {
        
        var colorName = "global.bgColor"
        
        switch self {
            case .theme:
                colorName = "themeColor"
            case .viewBg:
                colorName = "global.bgColor"
            case .navBg:
                colorName = "global.bgColor"
            case .priceDownBg:
                
                colorName = "home.priceUpBg"
            case .priceUpBg:
                
                colorName = "home.priceDownBg"
            
            case .cellTitle2:
                colorName = "home.tableCellTitle2"
            case .lineBg:
                colorName = "global.lineBg"
            case .tint:
                colorName = "global.tintColor"
            
            case .btTitle:
                colorName = "global.btTitleColor"
            
            case .loginLineBg:
                colorName = "login.line"
            case .title3:
                colorName = "global.title3"
            
            case .title2:
                colorName = "title2"
            
            case .kLineUp:
                colorName = "home.priceUpBg"

            case .kLineDown:
                colorName = "home.priceUpBg"

        }
        
        return UIColor.init(named: colorName)!
    }
}

enum CoinBullAlert {
    
    case alertTitlt
    case alertBottom
    
    var color: UIColor {
        
        var colorName = "alert.alertTitleColor"
        
        switch self {
            case .alertTitlt:
                colorName = "alert.alertTitleColor"
            case .alertBottom:
                colorName = "alert.alertBottomColor"
        }
        return UIColor.init(named: colorName) ?? .black
    }
}

enum KlineClolor {
    
    case lineBack
    case titleNormal
    case down
    case up
    
    case titleSelect
    var color: UIColor {
        
        var colorName = "KLine.NewBack"
        
        switch self {
            case .up:
                
                colorName = "home.priceUpBg"

                
                break
            case .down:
                colorName = "home.priceUpBg"

                
                break
            case .lineBack:
                
                colorName = "KLine.NewBack"
                
                break
            case .titleSelect:
                
                colorName = "kline.SelectColor"
                
                break
            
            case .titleNormal:
                
                colorName = "kLine.TitleColor"
                
                break
        }
        return UIColor.init(named: colorName) ?? .black
    }
    
}
