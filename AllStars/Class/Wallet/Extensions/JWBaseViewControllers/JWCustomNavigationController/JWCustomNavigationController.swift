//
//  JWNavigationController.swift
//  CoinBull
//
//  Created by WuQiaoqiao on 16/2/29.
//  Copyright © 2016年 Joe. All rights reserved.
//

import UIKit

class JWCustomNavigationController: UINavigationController,UINavigationControllerDelegate, UIGestureRecognizerDelegate {
     
//    var dismissFuncBlock: DismissFunc?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactivePopGestureRecognizer?.delegate = self
    
        //修改NavigationBar title的属性
        let dict:NSDictionary = [NSAttributedString.Key.foregroundColor:  UIColor.white,NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)]
        self.navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedString.Key : Any]
        self.delegate = self
   
       
//            self.navigationController?.navigationBar.setBackgroundImage(imageNamed("nav_back_white"), for: .default)

        
//        self.navigationController?.navigationBar.backgroundColor = GSColor.navColor.color

    }
    
    
   
//    func dismissActionBlock(actionBlock: @escaping DismissFunc) {
//
//        dismissFuncBlock = actionBlock
//    }
  

    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count >= 1 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
        
        if  (self.interactivePopGestureRecognizer != nil) {
        
            self.interactivePopGestureRecognizer?.isEnabled = true
        }
        print("push===>>>> :::: \(self)")
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        if navigationController.viewControllers.count == 1 {
        
            navigationController.interactivePopGestureRecognizer?.isEnabled = false
        }else
        {
            navigationController.interactivePopGestureRecognizer?.isEnabled = true
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        navigationController.setNavigationBarHidden(viewController.navBarIsNeedHidden, animated: animated)
    }
}
