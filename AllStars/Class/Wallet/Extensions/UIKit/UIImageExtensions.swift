//
//  UIImageExtensions.swift
//  Turing
//
//  Created by guanqiang on 2020/12/15.
//  Copyright © 2021 Hkk All rights reserved.
//

import UIKit

extension UIImage {
    
    static func createImage(_ color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        defer {
            UIGraphicsEndImageContext()
        }
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))

        guard let aCgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            return nil
        }
        return UIImage(cgImage: aCgImage)
    }
}
