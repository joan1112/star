//
//  UILabelExtensions.swift
//  Turing
//
//  Created by guanqiang on 2020/12/15.
//  Copyright © 2021 Hkk All rights reserved.
//

import UIKit

extension UILabel {

  
    class func label(rect: CGRect? = .zero,
                     text: String? = nil,
                     textColor: UIColor? = nil,
                     backColor: UIColor? = nil,
                     font: UIFont? = nil,
                     fontSize: CGFloat? = nil,
                     alignment: NSTextAlignment? = .left,
                     superView: UIView? = nil) -> UILabel {
        let label = UILabel()
        if let r = rect {
            label.frame = r
        }
        if let t = text {
            label.text = t
        }
        if let tColor = textColor {
            label.textColor = tColor
        }
        if let bColor = backColor {
            label.backgroundColor = bColor
        }
        if let f = font {
            label.font = f
        }
        if let fSize = fontSize {
            label.font = .systemFont(ofSize: fSize)
        }
        if let al = alignment {
            label.textAlignment = al
        }
        if let s = superView {
            s.addSubview(label)
        }
        return label
    }
}
