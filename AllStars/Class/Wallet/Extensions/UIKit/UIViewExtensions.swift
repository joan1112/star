//
//  UIViewExtensions.swift
//  Turing
//
//  Created by guanqiang on 2020/12/15.
//  Copyright © 2021 Hkk All rights reserved.
//

import UIKit

extension UIView {
    
    // fast init: rect
    class func view(rect: CGRect? = nil,
                    backColor: UIColor? = nil,
                    superView: UIView? = nil) -> UIView {
        let view = UIView()
        if let r = rect {
            view.frame = r
        }
        if let bColor = backColor {
            view.backgroundColor = bColor
        }
        if let s = superView {
            s.addSubview(view)
        }
        return view
    }

    /// 左
    var left: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    /// width
    var width : CGFloat {
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame =  frame
        }
        get {
            return frame.width
        }
    }

    /// height
    var height : CGFloat {
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame =  frame
        }
        get {
            return frame.height
        }
    }

    /// 右
    var right: CGFloat {
        get {
            return left + width
        }
        set {
            frame.origin.x = newValue - width
        }
    }
    
    /// 上
    var top: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }

    /// 下
    var bottom: CGFloat {
        get {
            return top + height
        }
        set {
            frame.origin.y = newValue - height
        }
    }
    
//    /// centerX
//    var centerX : CGFloat {
//        set {
//            var center = self.center
//            center.x = newValue
//            self.center =  center
//        }
//        get {
//            return center.x
//        }
//    }
//
//    /// centerY
//    var centerY : CGFloat {
//        set {
//            var center = self.center
//            center.y = newValue
//            self.center =  center
//        }
//        get {
//            return center.y
//        }
//    }
//
//    /// size
//    var size : CGSize {
//        set {
//            var frame = self.frame
//            frame.size = newValue
//            self.frame = frame
//        }
//        get {
//            return frame.size
//        }
//    }
    
    func cornerRadius(r: CGFloat) -> Self {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = r
        return self
    }
    
    func borderColor(c: UIColor?) -> Self {
        self.layer.masksToBounds = true
        if let color = c {
            self.layer.borderColor = color.cgColor
        } else {
            self.layer.borderColor = nil
        }
        return self
    }
    
    func borderWidth(w: CGFloat) -> Self {
        self.layer.masksToBounds = true
        self.layer.borderWidth = w
        return self
    }
    
    func setCornersRadius(_ corners: UIRectCorner, _ cornerRadius: CGFloat) -> Void {
        let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    // MARK: - 父 vc
    var parentViewController: UIViewController? {
        weak var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    /// 截图
    func hyGetViewScreenshot() -> UIImage? {
        /// 设置屏幕倍率可以保证截图的质量
        let scale:CGFloat = UIScreen.main.scale
        
        UIGraphicsBeginImageContextWithOptions( self.frame.size, true, scale)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let frame = self.bounds
        let rect =  CGRect.init(x: frame.origin.x * scale, y: frame.origin.y * scale, width: frame.width * scale, height: frame.height * scale)
        let imageRef = image?.cgImage;
        let subImageRef = imageRef!.cropping(to: rect);
        return UIImage(cgImage: subImageRef!)
    }
    
    /// 截图
    var screenshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
extension UIView {
    // MARK: - x
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }
    
    // MARK: - y
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue
            frame                 = tempFrame
        }
    }
    
//    // MARK: - height
//    var height: CGFloat {
//        get {
//            return frame.size.height
//        }
//        set(newValue) {
//            var tempFrame: CGRect = frame
//            tempFrame.size.height = newValue
//            frame                 = tempFrame
//        }
//    }
//
//    // MARK: - width
//    var width: CGFloat {
//        get {
//            return frame.size.width
//        }
//        set(newValue) {
//            var tempFrame: CGRect = frame
//            tempFrame.size.width = newValue
//            frame = tempFrame
//        }
//    }
    
    // MARK: - size
    var size: CGSize {
        get {
            return frame.size
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
    
    // MARK: - centerX
    var centerX: CGFloat {
        get {
            return center.x
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    // MARK: - centerY
    var centerY: CGFloat {
        get {
            return center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter;
        }
    }
    
    // MARK: - maxX
    var maxX : CGFloat {
        get {
            return frame.maxX
        }
    }
    
    // MARK: - maxY
    var maxY : CGFloat {
        get {
            return frame.maxY
        }
    }
    
    // MARK: - minY
    var minY : CGFloat {
        get {
            return frame.minY
        }
    }
    
//    var bottom : CGFloat {
//        get {
//            return frame.size.height + frame.origin.y
//        }
//    }
//    
//    var right : CGFloat {
//        get {
//            return frame.size.width + frame.origin.x
//        }
//    }
    
    func mediateY(_ subViewHeight:CGFloat) -> CGFloat {
        return ((self.height - subViewHeight)/2)
    }
    
    func mediateX(_ subViewWhite:CGFloat) -> CGFloat {
        return ((self.width - subViewWhite)/2)
    }
    
    
    // MARK: - 设置圆角
    func setViewBorder(cornerRadius:CGFloat = 3, color:UIColor) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = color.cgColor;
        self.layer.borderWidth = 1;
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = self.layer.contentsScale
    }
    
    func setViewBorderWidth(_ borderWidth:CGFloat = 1, _ borderColor:UIColor) {
        self.layer.borderColor = borderColor.cgColor;
        self.layer.borderWidth = borderWidth;
    }
    
    // MARK: - 设置阴影
    func setViewShadowColor(shadowOpacity:Float,shadowColor:UIColor,shadowOffset:CGSize) {
        
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = shadowOffset
    }
    
    /// 设置单独某个位置圆角
    ///
    /// - Parameters:
    ///   - make: 圆角范围
    ///   - corners: 设置圆角位置
    /// - Returns: CAShapeLayer
    class func changeMaskLayer(rect:CGRect ,make: CGSize, corners: UIRectCorner) -> CAShapeLayer {
        let maskPath = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: make)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = rect
        maskLayer.path = maskPath.cgPath
        return maskLayer
    }
    
    
    /// 在view中获取view所在控制器
    ///
    /// - Returns: UIViewController
    func setViewController() -> UIViewController? {
        var next:UIView? = self
        repeat{
            if let nextResponder = next?.next {
                if nextResponder.isKind(of: UIViewController.self) {
                    return (nextResponder as! UIViewController)
                }
            }
            next = next?.superview
        }while next != nil
        return nil
    }
    
}
