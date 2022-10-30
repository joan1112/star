//
//  Tools.swift
//  CoinBull
//
//  Created by hkk on 2020/12/18.
//  Copyright © 2020 Joe. All rights reserved.
//

import Foundation
//import Kingfisher

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach{addSubview($0)}
    }
}
extension UIImage {
    
    static func themeImageNamed(imageName:String) -> UIImage {
       
            let temp = UIImage.init(named:imageName + "_night")
            if let exsitImg = temp {
                return exsitImg
            }else {
                if let img = UIImage.init(named: imageName) {
                    return img
                }
            }
            return UIImage()
       
    }
}
//
//  CBTextView.swift
//  CoinBull
//
//  Created by Lee on 7/13/20.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit

extension Array{
    @discardableResult func zf_enumerate(_ function : (_ offset: Int, _ element: Element)->())->Array{
        for aug in self.enumerated(){
            function(aug.offset, aug.element)
        }
        return self
    }
}
extension Dictionary {
    @discardableResult func zf_enumerate(_ function : (_ key: Key, _ value: Value)->())->Dictionary{
        for aug in self{
            function(aug.key, aug.value)
        }
        return self
    }
}

extension String {
    
    /// 按照指定的分割规则数组,分割字符串,插入字符
    func insert(indexs:[Int],separeteBy:String?) -> String{
        guard let separeteBy = separeteBy else {return self}
        let separeteString = self as NSString
        // 每次插入前从自己原始的字符串中 截取的开始下标
        var start = 0
        // 保存拼接完成的字符串
        var targetString : String = ""
        // 循环遍历插入下标数组
        for (idx,index) in indexs.enumerated(){
            // 判断截取是否会越界
            // 1. 不会越界 截取字符串,添加分隔符
            if (index + start) <= separeteString.length{
                let newString = separeteString.substring(with: NSRange.init(location: start, length: index))
                // 最后一个不添加分隔符
                targetString.append(newString + ((idx < indexs.count - 1 && start + index < separeteString.length) ? separeteBy : ""))
                start = start + index
            }else{
                // 2. 越界了 截取到最大位数
                guard separeteString.length - start > 0 else{
                    break
                }
                let newString = separeteString.substring(with: NSRange.init(location: start, length: separeteString.length - start))
                // 最后一个不添加分隔符
                targetString.append(newString)
                break
            }
        }
        return targetString
    }
    
    func isValidateIdCard()->Bool{
        let floatRegex = "^[A-Za-z0-9]+$"
        let floatTest = NSPredicate(format: "SELF MATCHES %@",floatRegex )
        return floatTest.evaluate(with: self)
    }
    
    func isValidateUInt()->Bool{
        let floatRegex = "^\\d+$"
        let floatTest = NSPredicate(format: "SELF MATCHES %@",floatRegex )
        return floatTest.evaluate(with: self)
    }
    
    func isValidateFloat()->Bool{
        let floatRegex = "^[0-9]+(.[0-9]{1,2})?$"
        let floatTest = NSPredicate(format: "SELF MATCHES %@",floatRegex )
        return floatTest.evaluate(with: self)
    }
    
    /// 验证是否是大写字母
    func isValidateCapital()->Bool{
        let regex = "^[A-Z]+$"
        let test = NSPredicate(format: "SELF MATCHES %@",regex)
        return test.evaluate(with: self)
    }
    
    /// 验证是否是小写字母
    func isValidateLowercase()->Bool{
        let regex = "^[a-z]+$"
        let test = NSPredicate(format: "SELF MATCHES %@",regex)
        return test.evaluate(with: self)
    }
    
    /// 验证是否是英文字母
    func isValidateLetter()->Bool{
        let regex = "^[A-Za-z]+$"
        let test = NSPredicate(format: "SELF MATCHES %@",regex)
        return test.evaluate(with: self)
    }
    
    /// 传入正则表达式验证
    func isValidate(regex:String)->Bool{
        let test = NSPredicate(format: "SELF MATCHES %@",regex)
        return test.evaluate(with: self)
    }
    
    func filter(by setString:String)->String{
        let setToRemove = NSCharacterSet(charactersIn: setString).inverted
        return self.components(separatedBy: setToRemove).joined(separator: "")
    }
    
    var numberString : String {
        let setToRemove = NSCharacterSet(charactersIn: "1234567890.").inverted
        var numbers = self.components(separatedBy: setToRemove)
        var passPoint : Bool = false
        for (idx,number) in numbers.enumerated().reversed(){
            if !passPoint {
                if number.contains("."){
                    let points = number.components(separatedBy: ".")
                    if points.count != 2{
                        var pointNumber : String = ""
                        for beforePoint in points[0..<points.count-1] {
                            pointNumber.append(beforePoint.replacingOccurrences(of: ".", with: ""))
                        }
                        numbers[idx] = pointNumber.appending(".").appending(points.last ?? "")
                    }
                    passPoint = true
                }
            }else{
                numbers[idx] = number.replacingOccurrences(of: ".", with: "")
            }
        }
        return numbers.joined()
    }
    
    /// 补全小数点后几位
    mutating func formatAfterPoint(less:Int) {
        // 没有小数点的 添加小数点到最后
        if !contains(".") , less > 0{
            append(".")
        }
        if afterPoint <= less {
            for _ in afterPoint..<less {
                append("0")
            }
        }
    }
    
    /// 检测字符串的 doubleValue 是不是符合要求
    func doubleValueValidate(maxNumber:Double,afterPoint:Int) -> Bool{
        // 检测是否超过最大数字限制
        guard ns_String.doubleValue <= maxNumber else {
            return false
        }
        // 如果小数点后的数字大于0 就限制
        if afterPoint > 0{
            // 限制点的数量
            guard self.components(separatedBy: ".").count <= 2 else {
                return false
            }
            // 限制小数点后的数量
            if components(separatedBy: ".").count == 2 {
                guard let afterPointString = components(separatedBy: ".").last , afterPointString.count <= afterPoint else {
                    return false
                }
                return true
            }else{
                // 使用.分割为 0-1段时 表示没有点存在.但是限制了小数点后的位数.
                return true
            }
        }else{
            // afterPoint <= 0 时, 不含有.就是合格的 doubleValue
            return !contains(".")
        }
        
        
    }
    
    /// 检测字符串的 doubleValue 是不是符合要求
    func doubleValueValidate(minNumber:Double,afterPoint:Int) -> Bool{
        // 检测是否超过最大数字限制
        guard ns_String.doubleValue > minNumber else {
            return false
        }
        // 如果小数点后的数字大于0 就限制
        if afterPoint > 0{
            // 限制点的数量
            guard self.components(separatedBy: ".").count <= 2 else {
                return false
            }
            // 限制小数点后的数量
            if components(separatedBy: ".").count == 2 {
                guard let afterPointString = components(separatedBy: ".").last , afterPointString.count <= afterPoint else {
                    return false
                }
                return true
            }else{
                // 使用.分割为 0-1段时 表示没有点存在.但是限制了小数点后的位数.
                return true
            }
        }else{
            // afterPoint <= 0 时, 不含有.就是合格的 doubleValue
            return !contains(".")
        }
        
        
    }
    
    ///邮箱的正则表达判断
    func isValidateEmail()->Bool {
        let emailRegex = "^(([a-zA-Z0-9]+[\\.-]?)*[a-zA-Z0-9_]+)+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$" // 正则表达式
//        let emailRegex = "^[A-Za-z0-9\\u4e00-\\u9fa5]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@",emailRegex ) // 正则表达对象
        guard emailTest.evaluate(with: self) else {return false } // 进行校验
        let subs = self.components(separatedBy: "@") // 分割前后字符串
        guard subs.count == 2 else {return false} // 校验分割后的数量
        guard subs.first!.count <= 64 && subs.last!.count <= 255 else {return false } // 校验分割后的长度
        return true // 全通过返回 true
    }
    
    //MARK: - 修改密码的正则表达判断
    func isValidatePassword()->Bool
    {
        if self.count < 8 || self.count > 16 {
            
            return false
        }
        return true
//        let passwordRegex = "^(?=.*[0-9].*)(?=.*[A-Z].*)(?=.*[a-z].*).{8,16}$"
//        let regextestPassword = NSPredicate(format: "SELF MATCHES %@",passwordRegex)
//        return regextestPassword.evaluate(with: self)
    }

    func isValidateMobile()->Bool
    {
        let mobile = "^[1][3,4,5,7,8][0-9]{9}$"
        //"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
        //        let  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        //        let  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        //        let  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        return regextestmobile.evaluate(with: self)
        //        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        //        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        //        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        //        if ( )
        //            || (regextestcm.evaluate(with: self)  == true)
        //            || (regextestct.evaluate(with: self) == true)
        //            || (regextestcu.evaluate(with: self) == true))
        //        {
        //            return true
        //        }
        //        return false
    }
    
    var afterPoint : Int {
        return components(separatedBy: ".").last?.count ?? 0
    }
    
    func bwy_replaceWith(notAllowType:[String:String]?)->String{
        var str = self
        notAllowType?.zf_enumerate({origin,replace in str = str.replacingOccurrences(of: origin, with: replace)})
        return str
    }
    
    var ns_String : NSString
    {
        return self as NSString
    }
    
    var url : URL? {
        return URL(string: self)
    }
    
    /// 截取字符串 并防止截取字符串崩溃
    func bwy_subString(to index : Int)->String{
        guard index >= 0 else {return self}
        return ns_String.substring(to: index)
//        return String(self[self.index(self.startIndex, offsetBy: self.count > index ? index : self.count)])
    }
    
    /// 截取某一下标左边字符串
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }

    /// 业务需要去空格检查
    var bwy_isEmpty : Bool {
        return ns_String.replacingOccurrences(of: " ", with: "").isEmpty
    }
    
    /// 清除头尾的空格
    var la_removeWhiteSpaces : String {
        return trimmingCharacters(in: .whitespaces)
    }
    
    func notAllow(_ keys : [String])->String{
        var newString = self
        for key in keys {
            newString = newString.replacingOccurrences(of: key, with: "")
        }
        return newString
    }
    
    static func priceString(value:Double)->String{
        return String.init(format: "%.2f", value)
    }
    
    func zf_attributed(font:UIFont,color:UIColor) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [NSAttributedString.Key.font : font,
                                                             NSAttributedString.Key.foregroundColor : color])
    }
    
    func copy(times:Int)->String {
        var new = ""
        for _ in (0..<times) {
            new += self
        }
        return new
    }
}

enum CBTextLimitType: String {
    case All = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890"             // 字母数字都可以
    case Float = "1234567890."                                                              // 小数
    case UInt = "1234567890"                                                                // 正整数
    case Letter = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM"                    // 英文字母
    case Capital = "QWERTYUIOPASDFGHJKLZXCVBNM"                                             // 大写字母
    case Lowercase = "qwertyuiopasdfghjklzxcvbnm"                                           // 小写字母
    /// 密码
    case Password = "!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
    /// 十六进制
    case Hexadecimal = "0123456789abcdefABCDEFXx"
    /// 助记词
    case Mnemonic = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM "
    /// 搜索框
    case searchBar = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890 _"
}

class CBTextField: UITextField, UITextFieldDelegate {
    /// 限制输入的类型
    var limitType : CBTextLimitType? {
        didSet{
            guard let limit = limitType else {
                keyboardType = .default
                return
            }
            switch limit {
            case .Float:
                keyboardType = .decimalPad
            case .UInt:
                keyboardType = .numberPad
            case .All,.Letter,.Capital,.Lowercase,.Password,.Mnemonic,.searchBar:
                keyboardType = .asciiCapable
            default:
                break
            }
        }
    }
    /// 限制输入的最大数字
    var maxNumber : Double?
    /// 限制输入的最小数字
    var minNumber: Double?
    /// 小数点后有几位
    var afterPoint : Int?
    /// 最大字符数量
    var maxCount : Int?
    /// 文字改变的通知
    var textChange : ((CBTextField,String?)->())?
    /// 点击了回车按钮的 block
    var returnAction : ((UITextField) -> Bool)?

    var clearAction : ((UITextField) -> Bool)?
    
    /// 不允许输入的字符
    var notAllow : [String:String]?
    
    // 分割间隔
    var inserts : [Int]?
    // 分割符号
    var separete : String?
    
    // 取出 没有分隔符和不允许输入的字符的的字符串
    // 取出 没有分隔符的字符串
    var pureText : String {
        get{
            guard var str = pureString() else {return ""}
            str = str.bwy_replaceWith(notAllowType: notAllow)
            if let maxCount = maxCount , (str.count) > maxCount{str = str.ns_String.substring(to: maxCount)}
            return str
        }
        set{
            subMaxCount()
            replaceNotAllowString()
            pureString(newValue:newValue)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        delegate = self
//        NotificationCenter.default.addObserver(self, selector: #selector(textChanged(noti:)), name: UITextField.textDidChangeNotification, object: nil)
    }
    
    func setLeftImage(margin:CGFloat,image:UIImage){
        let icon = UIImageView(image: image)
        let container = UIView()
        // 设置左右两边的margin 添加到宽度中
        let leftSpace = UIView(frame: CGRect(x: 0, y: 0, width: margin, height: icon.bounds.height))
        icon.frame = CGRect(x: margin, y: 0, width: icon.bounds.width, height: icon.bounds.height)
        // 图片居中显示
        icon.contentMode = .center
        
        let rightSpce = UIView(frame: CGRect(x: margin + icon.bounds.width, y: 0, width: margin, height: icon.bounds.height))
        container.addSubview(leftSpace)
        container.addSubview(icon)
        container.addSubview(rightSpce)
        container.frame = CGRect(x: 0, y: 0, width: icon.bounds.width + margin * 2, height: icon.bounds.height)
        leftView = container
        leftViewMode = .always
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return returnAction?(self) ?? true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return clearAction?(self) ?? true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 检查是否包含不允许输入的字符
        guard string == string.bwy_replaceWith(notAllowType: notAllow) else {return false}
        if let newString = textField.text?.ns_String.replacingCharacters(in: range, with: string){
            // 进行分割显示
            if let inserts = inserts {
                // 限制文字最大数量
                if maxCount == nil {
                    maxCount = 0
                    for number in inserts{maxCount! += number}
                }
                
                // 文字类型限制
                guard let limit = limitType else {return false}
                // 最大长度限制
                guard (textField.text ?? "").filter(by: limit.rawValue).count + string.filter(by: limit.rawValue).count - range.length <= maxCount! else{return false}
                // 过滤文字后如果没有有用字符串则返回
                let inputReplaceText = string.filter(by: limit.rawValue)
                guard !(text != "" && inputReplaceText == "") else {return false}
                
                // 记录之前选中的位置
                let selectRange = selectedRange
                
                // 替换文字
                let text_loc = textFieldSeperateString(inputString: (textField.text ?? ""),selectRange:selectRange, range: range, replacementText: inputReplaceText , seperate: separete, inserts: inserts, filterSet: limit.rawValue)
                textField.text = text_loc.text
                setSelectedRange(range: NSRange.init(location: selectRange.location + text_loc.indexOffset, length: 0))
                textChange?(self,self.text)
                return false
            }

            // 检查是否限制了类型
            if var limitType = limitType?.rawValue  {
                if let separete = separete {limitType = limitType.appending(separete)}
                // 过滤字符串
                guard string == string.filter(by: limitType) else {
                    return false
                }
            }
//            // 检测是否超过了最小数字限制
//            if let minNumber = minNumber {
//                return newString.doubleValueValidate(minNumber: minNumber, afterPoint: afterPoint ?? 0)
//            }
            
            // 检测是否超过最大数字限制
            if let maxNumber = maxNumber {
                return newString.doubleValueValidate(maxNumber: maxNumber, afterPoint: afterPoint ?? 0)
            }
        }
        
        
        
        guard let maxCount = maxCount else {return true}
        /// 不是中文的直接截取
        let currentCount = text?.count ?? 0 // textView.ns_text.length
        let newTextCount = string.count
        
        /// 正常截取最大范围
        func subMaxRange()->Bool{
            
            // 判断是否已经超出了最大范围
            guard currentCount <= maxCount && self.text != nil else {
                self.text = self.text!.ns_String.substring(to: maxCount)
                return false
            }
            
            if  newTextCount + currentCount > maxCount // (text as NSString).length + count > maxCount
            {
                // 超出限制截取超出部分
                let subStr = NSString(string: string).substring(to: maxCount - currentCount)
                guard subStr.count > 0 else {
                    return false
                }
                let mStr = NSMutableString(string: text ?? "")
                mStr.insert(subStr, at: range.location)
                text = mStr as String
                return false
            }else{
                return true
            }
        }
        
        // 不是中文就正常截取
        guard let lang = UITextInputMode.activeInputModes.first?.primaryLanguage , lang == "zh-Hans" else{
            return subMaxRange()
        }
        
        // 没有高亮部分(拼音部分)就通过 正常截取
        guard let isPinyin = self.markedTextRange?.isEmpty , isPinyin == false else {
            return subMaxRange()
        }
        
        return true
    }
    
    @objc private func textChanged(noti:Notification)
    {
        guard (noti.object as? CBTextField) == self else {return}
        // 没有限制不操作
        if let maxCount = maxCount , (self.text?.ns_String.length ?? 0) > maxCount {
            // 检查是否有拼音存在,没有就截取范围内的
            if let text = self.text , !self.isPinyin {
                self.text = String(text[..<text.index(text.startIndex, offsetBy: maxCount)])
            }
        }
        guard (noti.object as? CBTextField) == self else {return}
        
        textChange?(self,self.text)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func subMaxCount(){
        if let maxCount = maxCount , (text?.count ?? 0) > maxCount{
            text = text?.ns_String.substring(to: maxCount)
        }
    }
    
    private func replaceNotAllowString(){
        // 检查是否包含不允许输入的字符
        text = text?.bwy_replaceWith(notAllowType: notAllow)
    }
    
    private func pureString()->String?{
        if inserts != nil && limitType != nil{
            return text?.filter(by: limitType!.rawValue)
        }else{
            return text
        }
    }
    private func pureString(newValue:String){
        if inserts != nil && limitType != nil{
            text = newValue.filter(by: limitType!.rawValue).insert(indexs: inserts!, separeteBy: separete)
        }else{
            text = newValue
        }
    }
}


/// 根据各项参数得出分隔符分割后的字符串以及光标偏移量
///
/// - Parameters:
///   - inputString: textView 当前的 text
///   - selectRange: 更改 text 之前的选中范围
///   - range: 需要更改的范围
///   - replacementText: 需要更改的文字
///   - seperate: 分隔符
///   - inserts: 插入的间隔
///   - filterSet: 限制的字符
/// - Returns: 最终结果赋值给 text
func textFieldSeperateString(inputString:String,selectRange:NSRange,range:NSRange,replacementText:String,seperate:String?,inserts:[Int],filterSet:String)->(text:String,indexOffset:Int){
    let newString = inputString.ns_String.replacingCharacters(in: range, with: replacementText)
    let returnString = newString.filter(by: filterSet).insert(indexs: inserts, separeteBy: seperate)
    var operatorOffset = replacementText.count
    // 1. 删除和增加的情况
    if replacementText == "" {
        // 没有选中文字时正常删除
        if selectRange.length == 0 {
            // 操作以后的偏移量 判断是不是在最左边和
            operatorOffset = (selectRange.location > 0 ? -1 : 0)
            // 删除的时候左移
            if replacementText == "" && selectRange.location > 2
            {
                // 删除前的左边第二个是不是分隔符
                operatorOffset = inputString.ns_String.substring(with: NSRange.init(location: selectRange.location-2, length: 1)) == seperate ? operatorOffset - 1 : operatorOffset
            }
        }else{
            // 选中了 判断 location 左边是不是分隔,如果是 offset-1
            if replacementText == "" && selectRange.location > 1
            {
                // 删除前的左边第二个是不是分隔符
                operatorOffset = inputString.ns_String.substring(with: NSRange.init(location: selectRange.location-1, length: 1)) == seperate ? operatorOffset - 1 : operatorOffset
            }
        }
        
    }else{
        // 防止越界的情况下判断光标右边是否是空格
        // 正常输入情况
        if returnString.count > selectRange.location + 1{
            if returnString.ns_String.substring(with: NSRange.init(location: selectRange.location, length: 1)) == seperate {
                operatorOffset += 1
            }
        }else {
            // 粘贴时
            // 操作前空格数 inputString
            let beforeCount = inputString.filter(by: filterSet).insert(indexs: inserts, separeteBy: seperate).count - inputString.filter(by: filterSet).count
            let afterCount = returnString.count - returnString.filter(by: filterSet).count
            // 偏移操作后,多出或者少了多少个空格
            operatorOffset += afterCount - beforeCount
            // 当全局的空格数量不变,检查更改部分是否有空格
            if beforeCount == afterCount {
                operatorOffset += replacementText.insert(indexs: inserts, separeteBy: seperate).count - replacementText.count
            }
        }
    }
    return (returnString,operatorOffset)
}


extension UITextField{
    
    var isPinyin : Bool {
        // 检查是不是中文输入法
        guard let lang = UITextInputMode.activeInputModes.first?.primaryLanguage , lang == "zh-Hans" else{
            return false
        }
        
        
        // 获取 蓝色部分文字
        guard let markedTextRange = markedTextRange else {
            return false
        }
        
        // 蓝色部分不为空 就是中文输入中
        guard !markedTextRange.isEmpty else {
            return true
        }
        
        // 截取的文字不为空 则是中文
        return !(text(in: markedTextRange)?.isEmpty ?? false)
    }
    
    /// 获取当前选中的范围
    var selectedRange : NSRange {
        //        let beginning = beginningOfDocument
        //        let selectedRange = selectedTextRange
        //        let selectionStart = selectedRange.start
        //        let selectionEnd = selectedRange.end
        let location = offset(from: beginningOfDocument, to: selectedTextRange!.start)
        let length = offset(from: selectedTextRange!.start, to: selectedTextRange!.end)
        return NSRange.init(location: location, length: length)
    }
    
    /// 选中某个范围
    func setSelectedRange(range:NSRange){
        let startPosition = position(from: beginningOfDocument, offset: range.location)!
        let endPosition = position(from: beginningOfDocument, offset: range.location)!
        let selectionRange = textRange(from: startPosition, to: endPosition)
        selectedTextRange = selectionRange
    }
}
extension UITextView {
    
    var isPinyin : Bool {
        // 检查是不是中文输入法
        guard let lang = UITextInputMode.activeInputModes.first?.primaryLanguage , lang == "zh-Hans" else{
            return false
        }
        
        
        // 获取 蓝色部分文字
        guard let markedTextRange = markedTextRange else {
            return false
        }
        
        // 蓝色部分不为空 就是中文输入中
        guard !markedTextRange.isEmpty else {
            return true
        }
        
        // 截取的文字不为空 则是中文
        return !(text(in: markedTextRange)?.isEmpty ?? false)
    }
    
}

extension UIImage {
    /// color->UIImage
    class func colorImage(_ color : UIColor,size:CGSize? = nil)->UIImage?{
        let rect = CGRect(x: 0, y: 0, width: size?.width ?? 1.0, height: size?.height ?? 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

extension Array {
    
    
    /// 使用下标取数组元素 防止越界 自动判断是否
    func bwy_obj(in idx:Int?) -> Element?{
        // 是否传入了 idx
        guard let idx = idx else {return nil}
        // 是否越界
        guard count > idx else {return nil}
        // 是否小于0
        guard idx >= 0 else {return nil}
        return self[idx]
    }
    
    /// 安全的设置一个下标的元素,如果越界,则 append 到数组最后
    ///
    /// - Parameters:
    ///   - index: 下标
    ///   - obj: 对象
    mutating func bwy_set(index : Int , obj : Element){
        guard index >= 0 else {return}
        if index >= count {
            append(obj)
        }else{
            self[index] = obj
        }
    }
    
    /// 从 last 开始去下标 , 防止越界
    ///
    /// - Parameter offset: 0为 last, 1 取 last - 1
    func bwy_obj(last offset:Int?) -> Element?{
        guard let offset = offset else {return nil}
        let idx = count - 1 - offset
        return self.bwy_obj(in: idx)
    }
    
    func bwy_mergeAllDictionary()->[String:Any]?{
        var json = [String:Any]()
        guard let dicArr = self as? [[String : Any?]] else {return nil}
        dicArr.zf_enumerate { (_, dic) in
            dic.zf_enumerate({ (key, value) in
                json[key] = value
            })
        }
        guard json.count > 0 else {return nil}
        return json
    }
    
    func bwy_mergeAllArray()->[Any]?{
        var allArray : [Any] = []
        (self as? [[Any]])?.zf_enumerate({allArray = allArray + $1})
        return allArray.isEmpty ? nil : allArray
    }
    
    /// 给一个数组如[2,1,0,4] 来取出多维数组内的元素
    func objIn(indexs : [Int])->Any?{
        var obj : Any = self
        for i in 0..<indexs.count{
            // 判断是否是数组
            guard let objArr = obj as? [Any] else{
                return nil
            }
            // 防止越界
            if objArr.count == 0 || indexs[i] >= objArr.count {
                return nil
            }
            obj = objArr[indexs[i]]
        }
        // 判断是否是数组
        if let objArr = obj as? [Any]{
            // 返回数组
            return objArr
        }else{
            // 不是,返回目标 obj
            return obj
        }
    }
    
    
    func mapObj(indexs : [Int])->[Element]?{
        var returnValue : [Element] = []
        indexs.zf_enumerate { (_, idx) in
            guard let v = self.bwy_obj(in: idx) else{return}
            returnValue.append(v)
        }
        guard returnValue.count == indexs.count else {return nil}
        return returnValue
    }
    
    ///取数组top n
    func safe_prefix(_ end: Int) -> [Element]? {
        if end < 0 {
            return self
        }
        if end > count - 1 {
            return self
        }
        return Array(self.prefix(end))
    }
    
    
    
}

public func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

public func shuffleArray<T:Any>(arr:[T]) -> [T] {
    var data:[T] = arr
    for i in 1..<arr.count {
        let index:Int = Int(arc4random()) % i
        if index != i {
            data.swapAt(i, index)
        }
    }
    return data
}

extension UIImageView {
//    func setImage(_ url: String, placeHolder: UIImage = UIImage(), cornerRadius: CGFloat = 0, size: CGSize? = nil, roundingCorners: RectCorner = .all) {
//        
////        self.kf.setImage(with: URL(string: url), placeholder: placeHolder, options: [.scaleFactor(5), .transition(.fade(0.5)), .processor(RoundCornerImageProcessor.init(cornerRadius: cornerRadius, targetSize: size, roundingCorners: roundingCorners))])
//    }
    
    func setImage(_ url:String){
        self.sd_setImage(with: URL.init(string: url), completed: nil)
    }
}

