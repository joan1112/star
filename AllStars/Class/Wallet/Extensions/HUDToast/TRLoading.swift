//
//  TRLoading.swift
//  Turing
//
//  Created by guanqiang on 2020/12/15.
//  Copyright © 2021 Hkk All rights reserved.
//

import UIKit

class TRLoading: UIView {
    static let shared = TRLoading()

    var imgV = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = false
//        self.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
    }

    func getImgV() {
        DispatchQueue.main.async {
            self.imgV = UIImageView()
            self.imgV.image = UIImage(named: "loading")
            self.imgV.translatesAutoresizingMaskIntoConstraints = false
            self.imgV.layer.add(self.animation(), forKey: "rotate")
            self.addSubview(self.imgV)
            self.imgV.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
                make.width.height.equalTo(60)
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func loading() {
        dismissWithDelay{}
        guard let appDelegate = UIApplication.shared.delegate else {
            return
        }
        getImgV()
        appDelegate.window??.rootViewController?.view.addSubview(self)
    }

    func animation() -> CABasicAnimation{
        let animation = CABasicAnimation.init(keyPath: "transform.rotation.z")
//        animation.fillMode = CAMediaTimingFillMode.forwards;
        animation.toValue = Double.pi * 2.0
        animation.duration = 1
        animation.repeatCount = Float.greatestFiniteMagnitude
        return animation
    }

    func dismissWithDelay(_ f : (() -> ())? = nil){
        imgV.removeFromSuperview()
        self.removeFromSuperview()
        f?()
    }
}
