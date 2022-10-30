//
//  UIButtonExtensions.swift
//  Turing
//
//  Created by guanqiang on 2020/12/15.
//  Copyright © 2021 Hkk All rights reserved.
//

import UIKit

extension UIButton {

    class func commonButton(text: String, superView: UIView?, fontSize: CGFloat = 16) -> UIButton {
        /// 按钮
        let b = UIButton.button(text: text, textColor: .white, font: UIFont.systemFont(ofSize: fontSize, weight: .medium)).cornerRadius(r: 5)
        superView?.addSubview(b)
        b.setBackgroundImage(UIImage.createImage(UIColor.disableColor()), for: .disabled)
        b.setBackgroundImage(UIImage.createImage(UIColor.mainColor()), for: .normal)
        return b
    }
    
    class func button(rect: CGRect? = nil,
                      text: String? = nil,
                      textColor: UIColor? = nil,
                      backColor: UIColor? = nil,
                      font: UIFont? = nil,
                      target: AnyObject? = nil,
                      sel: Selector? = nil,
                      superView: UIView? = nil) -> UIButton {
        let button = UIButton.init(type: .custom)
        if let r = rect {
            button.frame = r
        }
        if let t = text {
            button.setTitle(t, for: .normal)
        }
        if let tCololr = textColor {
            button.setTitleColor(tCololr, for: .normal)
        }
        if let bColor = backColor {
            button.backgroundColor = bColor
        }
        if let f = font {
            button.titleLabel?.font = f
        }
        if let t = target, let s = sel {
            button.addTarget(t, action: s, for: .touchUpInside)
        }
        if let s = superView {
            s.addSubview(button)
        }
        return button
    }

    /// 选中效果，背景图片
    func setNormalSelectedImage(_ norImage: UIImage?, _ selectedImage: UIImage?) -> Void {
        setImage(norImage, for: .normal)
        setImage(selectedImage, for: .selected)
    }
    
    /// 点击效果，背景
    func setNormalHighlightedBackImageWithColor(_ norColor: UIColor?, _ highlightedColor: UIColor?) -> Void {
        setBackgroundImage(UIImage.createImage(norColor ?? .white), for: .normal)
        setBackgroundImage(UIImage.createImage(highlightedColor ?? .white), for: .highlighted)
    }
    
    /// 点击效果，文字颜色
    func setNormalHighlightedTextColor(_ norColor: UIColor, _ highlightedColor: UIColor) -> Void {
        setTitleColor(norColor, for: .normal)
        setTitleColor(highlightedColor, for: .highlighted)
    }
}
