//
//  RootTabBarViewController.swift
//  CoinBull
//
//  Created by Joe on 16/2/29.
//  Copyright © 2016年 Joe. All rights reserved.
//

import UIKit
//import GPassword

enum QuickShowType:Int {
    case bind = 1
    case touchIdLogin = 2
    case faceLogin = 3
    case guesterLogin = 4
    case guestureBInd = 5
}

class RootTabBarController : UITabBarController {
    
//    var allControllersType: [TRTabbarControllerType] {
//        return TRTabbarControllerType.allCases
//    }
//    
//    override func viewDidLoad() {
//        tabBar.tintColor = UIColor.mainColor()
//        delegate = self
//        setupViewControllers()
//        setupTabbar()
//        setupItems()
//    }
//
//    private func setupTabbar() {
//        if #available(iOS 13.0, *) {
//            let appearence = tabBar.standardAppearance.copy()
//            appearence.shadowImage = UIImage.colorImage(.clear)
//            appearence.stackedLayoutAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3)
//            tabBar.standardAppearance = appearence
//        } else {
//            tabBar.shadowImage = UIImage.colorImage(.clear)
//        }
//        
//    }
//    
//    @discardableResult
//    func setupViewControllers() -> [TRTabbarControllerType] {
//        let arr = allControllersType.map{$0.rootNavigationController}
//        setViewControllers(arr, animated: false)
//        return allControllersType
//    }
//    
//    func setupItems() {
//        if let items = self.tabBar.items {
//            for (index, item) in items.enumerated() {
//                let type = allControllersType[index]
//                item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.hex(0x7E95B7), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)], for: UIControl.State.normal)
//                item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.mainColor(), NSAttributedString.Key.font:UIFont.systemFont(ofSize: 10)], for: UIControl.State.selected)
//                item.image = UIImage(named: type.info.unSelImage)?.withRenderingMode(.alwaysOriginal)
//                item.selectedImage = UIImage(named: type.info.selImage)?.withRenderingMode(.alwaysOriginal)
//            }
//        }
//    }
//    
//   
//    
//}
//
//extension RootTabBarController : UITabBarControllerDelegate {
//    
//    
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        guard let index = viewControllers?.firstIndex(of: viewController) else {return true}
//        
//        let type = allControllersType[index]
//        if type.shouldLogin && !TRUserInfoModel.isLogin() {
////            TRRoute.gotoLoginController { (_, _) in
////                self.selectedIndex = index
////            }
//            return false
//        }
//        return true
//    }
//    
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        guard let button = getTabBarButton() else { return }
////        tabBarButtonClick(tabBarButton: button)
////        errorCount = 0
//    }
//}
//
//extension RootTabBarController {
//    func getTabBarButton() -> UIControl? {
//        var tabBarButtons = [UIView]()
//        for tabbarBtn in tabBar.subviews {
//            if tabbarBtn.isKind(of: NSClassFromString("UITabBarButton")!) {
//                tabBarButtons.append(tabbarBtn)
//            }
//        }
//        if let tabBarButton = tabBarButtons.bwy_obj(in: selectedIndex) as? UIControl {
//            return tabBarButton
//        }
//        return nil
//    }
//    
//    func tabBarButtonClick(tabBarButton: UIControl) {
//        //
////        doFeedbackGenerator()
////        for imageView in tabBarButton.subviews {
////            if imageView.isKind(of: NSClassFromString("UITabBarSwappableImageView")!){
////                let animation = CASpringAnimation()
////                animation.keyPath = "transform.scale"
////                animation.fromValue = NSNumber(value: 0.8)
////                animation.toValue = NSNumber(value: 1.0)
////                animation.duration = 0.3
////                animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
////                imageView.layer.add(animation, forKey: nil)
////            }
////        }
//    }
}

