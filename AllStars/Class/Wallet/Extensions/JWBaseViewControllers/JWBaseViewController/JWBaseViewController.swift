//
//  JWBaseViewController.swift
//  CoinBull
//
//  Created by WuQiaoqiao on 16/2/29.
//  Copyright © 2016年 Joe. All rights reserved.
//

import UIKit
import LocalAuthentication
//import GPassword


extension Selector {
    
    static let methodLeftItemTapped = #selector(JWBaseViewController.leftItemTapped)
    static let methodRightItemTapped = #selector(JWBaseViewController.rightItemTapped)
    
}

extension UIViewController {
 
    var rootTabBarController: RootTabBarController? {
        
        let tabBarControl = self.tabBarController
        
        if tabBarControl is RootTabBarController {
            
            return tabBarControl as? RootTabBarController
        }
        
        return nil
    }
    
    var isCurrentViewController: Bool {
        get{
            var idx = 0
            let vcs = self.rootTabBarController?.viewControllers ?? []
            for (index, nvc) in vcs.enumerated() {
                
                if nvc == self.navigationController {
                    idx = index
                }
            }
            
            let lastVC = self.navigationController?.viewControllers.last
            if self.rootTabBarController?.selectedIndex != idx || lastVC != self || self.navigationController?.presentedViewController != nil {
                
                return false
            }else
            {
                return true
            }
        }
    }
}

class JWBaseViewController: UIViewController {
    
    var backRoot:Bool = false;

    var navigationBarShadowImageShow : Bool? {
        didSet
        {
            if !navigationBarShadowImageShow! {
//                self.navigationController?.navigationBar.shadowImage = UIImage.init()
            }
        }
    }
    
    var customNavigationController: JWCustomNavigationController? {
        
        let navigationControl = self.navigationController
         
        if navigationControl is JWCustomNavigationController {
            
            return navigationControl as? JWCustomNavigationController
        }
        
        return nil
    }
    //设置顶部蓝色背景，白色字体
    func setWhiteNoleftStyle()  {
//        UIApplication.shared.statusBarStyle = .lightContent
//
//        setNavigationBarBackgroundImage(backgroundImage: UIImage.colorImage(.mainBgColor())!)
//
//        setLeftNaviItemWithButton(leftButton: UIButton())
//
//        let dict:NSDictionary = [NSAttributedString.Key.foregroundColor: GSColor.navColor.color,NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)]
//        self.navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedString.Key : Any]
//
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];


    }
    //设置顶部蓝色背景，白色字体
    func setWhiteStyle()  {
//        UIApplication.shared.statusBarStyle = .lightContent
//
//        setNavigationBarBackgroundImage(backgroundImage: UIImage.colorImage(GSColor.navColor.color)!)
//
//        setLeftNaviItemWithTitle(imageName: "nav_back_white")
//
//        let dict:NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.navWhiteTitleColor(),NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)]
//        self.navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedString.Key : Any]
//
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];


    }
    func setBlackStyle()  {
                let dict:NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)]
                self.navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedString.Key : Any]
//        UIApplication.shared.statusBarStyle = .default
//
//        setNavigationBarBackgroundImage(backgroundImage: UIImage.colorImage(.cellBgColor())!)
//
//        setLeftNaviItemWithTitle(imageName: "nav_back_black")
//
//        let dict:NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.navTitleColor(),NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)]
//        self.navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedString.Key : Any]
        
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];


    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //默认返回按钮
        //        self.tabBarController
        navigationBarShadowImageShow = false
        self.view.backgroundColor = GSColor.bgColor.color
         setBlackStyle()
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .dark
        } else {
            // Fallback on earlier versions
        };
       
        setNavigationBarBackgroundImage(backgroundImage: UIImage.colorImage(GSColor.navColor.color)!)
        
        if self.navigationController?.viewControllers.count ?? 0 > 1 {
            setLeftNaviItemWithTitle(imageName: "nav_back_white")

        }
       
      
//        UIApplication.shared.statusBarStyle = .lightContent
//     
//        setLeftNaviItemWithTitle(imageName: "nav_back_white")
//          
//        let dict:NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.navWhiteTitleColor(),NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)]
//            
//        self.navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedString.Key : Any]
       
    }
     
    /**
     离开当前页面自动收起键盘
     
     - parameter animated: animated description
     */
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
    }
 
    
    deinit {
         
        DLog(message: "\(self)已销毁")
        
    }
    
    /**
     点击空白处完成编辑.
     
     - parameter touches: touches description
     - parameter event:   event description
     */ 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func setNavigationBarBackgroundImage(backgroundImage: UIImage) {
        
        self.navigationController?.navigationBar.setBackgroundImage(backgroundImage, for: UIBarMetrics.default)
    }
    
    @objc func leftItemTapped() {
        
        if ((self.navigationController?.presentingViewController) != nil && self.navigationController?.viewControllers.first == self) {
            
            self.dismiss(animated: true, completion: nil)
        }else
        {
            popViewControllerAnimated(animated: true)
        }
    }
    @objc func rightCustomTapped(sender:UIButton) { }
    @objc func rightItemTapped() { }
    
    /**
     *  @author qiaoqiao.wu
     *
     *  修改leftItem字体大小和颜色
     */
    func setLeftNaviItemWithTitle(title:String = "", imageName:String) {
        
        if(title.count > 0) {
            
            let leftItem = UIBarButtonItem(title: title, style: UIBarButtonItem.Style.plain, target: self, action:Selector.methodLeftItemTapped)
            
            self.navigationItem.leftBarButtonItem = leftItem
            
            let textAttributes = [kCTFontAttributeName:UIFont.systemFont(ofSize: 15),
                                  kCTForegroundColorAttributeName: UIColor.black]
            
            leftItem.setTitleTextAttributes(textAttributes as [NSAttributedString.Key : Any], for: UIControl.State.normal)
            leftItem.setTitleTextAttributes(textAttributes as [NSAttributedString.Key : Any], for: UIControl.State.highlighted)
            
            return
            
        }else if(imageName.count > 0) {
            
            let leftImage = imageNamed(imageName)
            
            let leftButton = UIButton(type: UIButton.ButtonType.system)
            
            leftButton.set(backgroundImage: leftImage)
            leftButton.frame = CGRect(x: 0, y: 0, width: leftImage.size.width, height: leftImage.size.height)
            leftButton.setEnlargeEdgeWithTop(25, left: 25, bottom: 25, right: 25)

            leftButton.addTarget(self, action:Selector.methodLeftItemTapped , for: UIControl.Event.touchUpInside)
            
            let leftItem = UIBarButtonItem(customView: leftButton)
            
            self.navigationItem.leftBarButtonItem = leftItem
        }
    }
    
    
    func setNavigationImage(name: String, edgeInsets: UIEdgeInsets = UIEdgeInsets.zero, contentModel: UIView.ContentMode = .left) {
        
        let logoView = UIImageView.init(frame: CGRect.zero)
        logoView.image = UIImage(named: name)
        logoView.contentMode = contentModel
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.addSubview(logoView)
        logoView.snp.makeConstraints { (make) in
            make.left.equalTo(edgeInsets.left)
            make.right.equalTo(-edgeInsets.right)
            make.top.equalToSuperview().offset(edgeInsets.top)
            make.bottom.equalToSuperview().offset(-edgeInsets.bottom)
        }
    }
    /**
     *  设置右边按钮；title和图片目前只能二选一，title优先级高于图片
     *
     *  @param title     title description
     *  @param imageName imageName description
     */
    func setRightNaviItemWithCustomBt(title:String = "", imageName:String, titleColor:UIColor = .mainBgColor()) {
        
              let rightButton2 = UIButton.button(rect: CGRect(x: 0, y: 0, width: 60, height: 40), target: self, sel: #selector(rightCustomTapped(sender:)))
    
                 rightButton2.layoutHorizontal(titleMargin: 5)
                 rightButton2.setEnlargeEdgeWithTop(15, left: 15, bottom: 15, right: 15)
        if imageName.count > 0 {
            rightButton2.setImage(UIImage(named: imageName), for: .normal)

        }
               rightButton2.setTitle(LocalizedString(key: title), for: .normal)
               rightButton2.titleLabel?.font = .dinFont(13)
               rightButton2.setTitleColor(titleColor, for: .normal)
               self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightButton2)
    }
    /**
     *  设置右边按钮；title和图片目前只能二选一，title优先级高于图片
     *
     *  @param title     title description
     *  @param imageName imageName description
     */
    func setRightNaviItemWithTitle(title:String = "", imageName:String) {
        
        if(title.count > 0) {
            
            let rightItem = UIBarButtonItem(title: title, style: UIBarButtonItem.Style.plain, target: self, action: Selector.methodRightItemTapped)
            
            self.navigationItem.rightBarButtonItem = rightItem
            
            let textAttributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15),
                                  NSAttributedString.Key.foregroundColor:UIColor.black]
            
            rightItem.setTitleTextAttributes(textAttributes, for: UIControl.State.normal)
            rightItem.setTitleTextAttributes(textAttributes, for: UIControl.State.highlighted)
            
            return
            
        }else if(imageName.count > 0) {
//            selectedItemImage.withRenderingMode(.alwaysOriginal)
            let rightImage = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
            
            let rightButton = UIButton(type: UIButton.ButtonType.system)

            rightButton.setImage(rightImage, for: UIControl.State.normal)
            rightButton.frame = CGRect(x: 0, y: 0, width: (rightImage?.size.width)! , height: (rightImage?.size.height)!)
            rightButton.setEnlargeEdgeWithTop(15, left: 15, bottom: 15, right: 15)

            rightButton.addTarget(self, action: Selector.methodRightItemTapped, for: UIControl.Event.touchUpInside)
            
            let rightItem = UIBarButtonItem(customView: rightButton)
            
            self.navigationItem.rightBarButtonItem = rightItem
        }
    }
    
    /**
     *  @author qiaoqiao.wu
     *
     *  自定义左边的按钮
     *
     *  @param leftButton leftButton description
     */
    func setLeftNaviItemWithButton(leftButton: UIButton) {
        
        leftButton.addTarget(self, action: Selector.methodLeftItemTapped, for: UIControl.Event.touchUpInside)
        
        leftButton.setEnlargeEdgeWithTop(30, left: 30, bottom: 30, right: 30)

        
        let leftItem = UIBarButtonItem(customView: leftButton)
        
        self.navigationItem.leftBarButtonItem = leftItem;
    }
    
    /**
     *  @author qiaoqiao.wu
     *
     *  自定义右边的按钮
     *
     *  @param rightButton rightButton description
     */
    func setRightNaviItemWithButton(rightButton: UIButton) {
        
        rightButton.addTarget(self, action: Selector.methodRightItemTapped, for:UIControl.Event.touchUpInside)
        
        let rightItem = UIBarButtonItem(customView: rightButton)
        
        self.navigationItem.rightBarButtonItem = rightItem
        
    }
    
    
    /**
     *  自定义Push 方法
     *
     *  @param viewController viewController description
     *  @param animated       animated description
     */
    
    func pushViewController(viewController: UIViewController, animated: Bool) {
        
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    
    /**
     *  自定义Pop 方法
     *
     *  @param animated animated description
     */
    func popViewControllerAnimated(animated: Bool) {
        
        if backRoot{
            self.navigationController?.popToRootViewController(animated: animated)
        }else{
            self.navigationController?.popViewController(animated: animated)

        }
    }
    
  
    //进入解锁界面
        
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    
      

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
                      

    }
    
   
   
   
}
