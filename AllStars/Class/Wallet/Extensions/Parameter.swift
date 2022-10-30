//
//  Parameter.swift
//  CoinBull
//
//  Created by Joe on 16/3/1.
//  Copyright © 2016年 Joe. All rights reserved.
//

import Foundation
import UIKit 
@_exported import SnapKit
//@_exported import RxCocoa
//@_exported import RxSwift
//import MyUUID
//import AdSupport


enum NotificationNames : String{
    
    case kLoginSuccessNotification = "kLoginSuccessNotificationKey"

    case kLoginStatusChangedNotification = "kLoginStatusChangedNotificationKey"
    case kWebsocketDidReceiveNotification = "kWebsocketDidReceiveNotificationKey"
    case kToSimulatedTradingNotificationKey = "kToSimulatedTradingNotificationKey"
    case kBuyPowerSuccess = "kBuyPowerSuccess"


    var stringValue : String {
        return "k" + rawValue
    }
    
    var name: NSNotification.Name {
        return NSNotification.Name(rawValue: stringValue)
    }
}

/**
 *全局导入
 */
 @_exported import HandyJSON
/**
debugPrint

:param: message printMessage
:param: file    printFile
:param: method  printMethod
:param: line    printLine
*/
func DLog<T>(message: T, file: String = #file, method: String = #function, line: Int = #line) {
     
    #if DEBUG
    print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    #endif
}

func LocalizedString(key:String) -> String {
    

    return key
}
//
//func getUUIDByKeyChain() -> String {
//       var strUUID = KeyChainStore.load("io.exChange.CoinBull.usernamepassword") as? String
//       if strUUID == Optional<String>.none {
//           strUUID = ASIdentifierManager.shared().advertisingIdentifier.uuidString
//           if (strUUID as AnyObject).count == 0 || strUUID == "00000000-0000-0000-0000-000000000000" {
//               var uuidRef = CFUUIDCreate(kCFAllocatorDefault)
//               strUUID = (CFBridgingRetain(CFUUIDCreateString(kCFAllocatorDefault, uuidRef)) as! String)
//               uuidRef = nil
//           }
//           KeyChainStore.save("io.exChange.CoinBull.usernamepassword", data: strUUID as Any)
//       }
//       return strUUID!
//   }
///**获取存储的UUID*/
//func getUUID() -> String {
//
//    let uuid = getUUIDByKeyChain()
//
//    return uuid
//}

func doFeedbackGenerator(){
     
    let impactFeedBack = UIImpactFeedbackGenerator(style: .light)
    impactFeedBack.prepare()
    impactFeedBack.impactOccurred()
}

fileprivate func imageWithName(_ name : String,
                   file: String,
                   method: String,
                   line: Int) -> UIImage {
    let image = UIImage(named: name)
    assert(image != nil, "❌ <\((file as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: ""))>SEL(\(method))[\(line)]: 本地图片<\(name)>不存在 \nassert")
    return image!
}

func _I(_ name : String,
         file: String = #file,
         method: String = #function,
         line: Int = #line)->UIImage{
    return imageWithName(name,file: file,method: method,line: line)
}

//struct Margin {
//    static let left: CGFloat = 16-
//    static let right: CGFloat = -16-
//    static let top: CGFloat = 10-
//    static let bottom: CGFloat = -10-
//}
