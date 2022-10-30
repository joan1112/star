//
//  StringExtensions.swift
//  CoinBull
//
//  Created by guanqiang on 2020/12/18.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit

public extension String {
    
    var doubleValue: Double {
        return Double(self) ?? 0
    }
    
    /// 去除某些字符
    func removeCharacters(inString string: String) -> String {
        var finaStr = ""
        self.forEach { (c) in
            if !string.contains(c) {
                finaStr.append(c)
            }
        }
        return finaStr
    }
    
    /// 小数位个数
    var beforePointCount: Int {
        guard self.count > 0 else {
            return 0
        }
        let array = self.components(separatedBy: ".")
        if array.count == 2 {
            return array.first?.count ?? 0
        }
        return self.count
    }
    
    /// 小数位个数
    var afterPointCount: Int {
        guard self.count > 0 else {
            return 0
        }
        let array = self.components(separatedBy: ".")
          if array.count == 2 {
            let last = array.last
            return last?.count ?? 0
        }
        return 0
    }
    
    //:MARK: ====== 空字符处理:  zeroHandle: "0" 时是否需要转为 "--"
    func emptyPlaceString(_ zeroHandle: Bool = false) -> String {
        if self.count <= 0 { return "--" }
        if zeroHandle && self.doubleValue == 0 { return "--" }
        return self
    }
    
    //:MARK: ====== 处理特殊样式数字，vaildConut: 小数点后有效数字位数， maxCount: 最大小数位数

    /// 从小数点后第一个有效数字算起(最多取 vaildConut 位)
    /// 最终小数位不超过 maxCount
    /// 末尾删除无效 “0”
    func specialHandle(_ vaildConut: Int = 2, _ maxCount: Int = 8) -> String {
        let value = Utility.decimalNumber(self, 20)
        if value.doubleValue == 0 { return "0" }
        if !value.contains(".") { return value }
        
        let firstStr = value.split(separator: ".").first!
        let lastStr = value.split(separator: ".").last!
        
        var temArr = [String]()
        var temVaildConut = 0 /// 有效数字个数
        var isVaild = false
        for index in lastStr.indices {
            let value = String(lastStr[index])
            if temVaildConut >= vaildConut { break }
            if value != "0" { isVaild = true }
            if isVaild { temVaildConut = temVaildConut + 1 }
            if temArr.count < maxCount { temArr.append(value) }
        }
        while (temArr.count > 0 && Int(temArr.last!) == 0) { temArr.removeLast() }
        return temArr.count > 0 ? (firstStr + "." + temArr.joined(separator: "")) : String(firstStr)
    }
    
    func handleValidNum(_ maxCount: Int = 8) -> String {
        if self.doubleValue == 0 {
            var finalStr = ""
            while finalStr.count < maxCount - 1 {
                finalStr.append("0")
            }
            return "0." + finalStr + "1"
        }else {
            return self.specialHandle()
        }
    }
    
    //:MARK: ====== 被某个数整除, 去除余数
    func handleDivideNum(_ vtargetValue: String, _ floats: Int) -> String {
        if vtargetValue.doubleValue == 0 { return Utility.decimalNumber(self, floats) }
        let value = Utility.decimalNumber(self, 20)
        let temp = Utility.decimalNumber(value, 0, vtargetValue, .divid, false)
        let finalValue = Utility.decimalNumber(temp, floats, vtargetValue, .multip, false)
        return finalValue
    }

    //:MARK: ====== 按小数点位数 补齐 0
    func makeUpZero(_ floats: Int) -> String {
        let arr = self.components(separatedBy: ".")
        var finalStr = ""
        if arr.count == 2 {
            finalStr = arr.last ?? ""
        }
        while finalStr.count < floats {
            finalStr.append("0")
        }
        return (arr.first ?? "0") + "." + finalStr
    }
    
    //:MARK: ====== 删除无效的 “0” 和 “.”
    func deleteInvalidNum() -> String {
        var outNumber = self
        var i = 0
        if self.contains(".") {
            while i < self.count {
                if outNumber.hasSuffix("0") {
                    outNumber.remove(at: outNumber.index(before: outNumber.endIndex))
                    i = i + 1
                }else {
                    break
                }
            }
            if outNumber.hasSuffix(".") {
                outNumber.remove(at: outNumber.index(before: outNumber.endIndex))
            }
        }
        return outNumber
    }
    //:MARK: ====== 隐藏手机号中间4位
    func replacePhone() -> String {
        if self.count >= 11{
            let start = self.index(self.startIndex, offsetBy: 3)
            let end = self.index(self.startIndex, offsetBy: 7)
            let range = Range(uncheckedBounds: (lower: start, upper: end))
            return self.replacingCharacters(in: range, with: "****")
        }
        return self
        
       }
    //:MARK: ====== 隐藏手机号中间4位
    func replaceEmail() -> String {
        let array = self.components(separatedBy: "@")
        guard let email = array.last else { return "" }
        
        var newAccount:String = ""
        
        if let account = array.first {
          
            if account.count > 2 {
                
//                newAccount = account.bwy_subString(to: 2)
                
            }
        }
        
        return newAccount + "****@" + email
       
       }
}
