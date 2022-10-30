//
//  TRToast.swift
//  Turing
//
//  Created by guanqiang on 2020/12/15.
//  Copyright © 2021 Hkk All rights reserved.
//

import UIKit
import SVProgressHUD
//import SwiftEntryKit

final class TRToast {
    
    var backView:UIView?
    var midView:UIView?

    enum ToastType {
        case success
        case failed
    }
    
    static func initialize() {
        SVProgressHUD.setFont(UIFont.systemFont(ofSize: 14))
        SVProgressHUD.setMinimumSize(CGSize(width: 96, height: 50))
        SVProgressHUD.setCornerRadius(6)
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.setHapticsEnabled(false)
        SVProgressHUD.setBackgroundColor(UIColor.black.withAlphaComponent(0.6))
        SVProgressHUD.setMinimumDismissTimeInterval(TimeInterval(1))
        SVProgressHUD.setMaximumDismissTimeInterval(TimeInterval(60))
        SVProgressHUD.setImageViewSize(CGSize(width: 0, height: -10))
//        SVProgressHUD.setMaxSupportedWindowLevel(UIWindow.Level.init(rawValue: .greatestFiniteMagnitude))
    }
    static func copyText(copyText:String?) {
//        guard  let copy = copyText, !copyText!.isEmpty else { return }
//        AppUtil.savePasteBoardString(msg: copy)
//        TRToast.toast(message: LocalizedString(key: "复制成功"))
    }
    static func toast(message: String?, duration: TimeInterval = 0) {
        guard let message = message, !message.isEmpty else { return }

        SVProgressHUD.showInfo(withStatus: message)
        SVProgressHUD.dismiss(withDelay: 2);
        
    }
    //提币提示样式
    static func toastWithDrawMsg(title:String? , message: String?, duration: TimeInterval = 0 , btnTitlesArraay:[String]) {
        guard let message = message, !message.isEmpty else { return }
        SVProgressHUD.showInfo(withStatus: message)
    }
  
    @objc func confirmClick()  {
        
        for view in  UIApplication.shared.keyWindow!.subviews {
            
            if view.tag == 10000 || view.tag == 20000 {
                
                view.removeFromSuperview()
            }
        }
        
    }
//    static func toast(message: String, type: ToastType = .failed) {
//        var attributes = EKAttributes()
//        attributes.name = "toastMessageName"
//        attributes.displayMode = .light
//        attributes.position = .top
//        attributes.windowLevel = .statusBar
//        let widthConstraint = EKAttributes.PositionConstraints.Edge.ratio(value: 0.95)
//        let heightConstraint = EKAttributes.PositionConstraints.Edge.intrinsic
//        attributes.positionConstraints.size = .init(width: widthConstraint, height: heightConstraint)
//
//        let labelContent = EKProperty.LabelContent(
//            text: message,
//            style: EKProperty.LabelStyle(
//                font: UIFont.systemFont(ofSize: 14, weight: .medium),
//                color: .white,
//                alignment: .center,
//                displayMode: .inferred
//            )
//        )
//
//        let noteView = EKNoteMessageView(with: labelContent)
//        noteView.verticalOffset = 12
//        noteView.horizontalOffset = 20
//        let contentView: UIView = noteView
//        contentView.backgroundColor = .hex(0xD11119)
//        contentView.layer.cornerRadius = 8
//        SwiftEntryKit.display(entry: contentView, using: attributes)
//    }
}
