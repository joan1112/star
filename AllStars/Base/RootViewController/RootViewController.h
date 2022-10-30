//
//  RootViewController.h
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/18.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFNoInternetView.h"
#import "HFTimeOutView.h"


/**
 VC 基类
 */
@interface RootViewController : UIViewController

/**
 *  修改状态栏颜色
 */
@property (nonatomic, assign) UIStatusBarStyle StatusBarStyle;

@property (strong, nonatomic) UIImageView *spButton;
/**
 *  显示请求超时页面
 */
-(void)showTimeOutView;
/**
 *  隐藏请求超时页面
 */
- (void)hiddenTimeOutView;
/**
 *  为控制器扩展方法，刷新网络时候执行，建议必须实现  //再次刷新
 */
- (void)reloadRequest;
/**
 *  显示无网络页面
 */
-(void)showNoInternetView;
/**
 *  隐藏没有网络页面
 */
- (void)hiddenNoInternetView;
/**
 *  显示没有数据页面
 */
-(void)showNoDataImage:(UIImage*)image withTitle:(NSString*)title;
-(void)showNoDataImage:(UIImage*)image withTitle:(NSString*)title offSetY:(CGFloat)value;
/**
 *  移除无数据页面
 */
-(void)removeNoDataImage;

/**
 *  加载视图
 */
- (void)showLoadingAnimation;

/**
 *  停止加载
 */
- (void)stopLoadingAnimation;
-(void)createCoinBtn;

/**
 *  是否显示返回按钮,默认情况是YES
 */
@property (nonatomic, assign) BOOL isShowLeftBack;

/**
 是否隐藏导航栏
 */
@property (nonatomic, assign) BOOL isHidenNaviBar;

/**
 *  默认返回按钮的点击事件，默认是返回，子类可重写
 */
- (void)backBtnClicked;

//取消网络请求
- (void)cancelRequest;
-(BOOL)gardenNetWork;

@end
