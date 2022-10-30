//
//  RootTabBarViewController.m
//  AllStars
//
//  Created by Mac on 2021/10/9.
//

#import "RootTabBarViewController.h"
#import "HomeVC.h"
#import "GameVC.h"
#import "TradeVC.h"
#import "MineVC.h"
#import "RootNavigationController.h"


@interface RootTabBarViewController ()<UINavigationControllerDelegate,UITabBarControllerDelegate,UITabBarDelegate>

@end

@implementation RootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UITabBar appearance] setTranslucent:NO];
    self.delegate = self;
    if (@available(iOS 13.0, *)) {
        UITabBarAppearance *appearance = [[UITabBarAppearance alloc] init];
        appearance.backgroundColor = [UIColor colorWithPatternImage:[UIColor gradientImageWithView:self.view fromColor:@"#334052" toColor:@"#1E2934" startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 1) cornerRadius:0]];
        self.tabBar.standardAppearance = appearance;
        if (@available(iOS 15.0, *)) {
            self.tabBar.scrollEdgeAppearance = appearance;
        } else {
            // Fallback on earlier versions
        }
    } else {
        [[UITabBar appearance] setBackgroundColor:[UIColor colorWithPatternImage:[UIColor gradientImageWithView:self.view fromColor:@"#334052" toColor:@"#1E2934" startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 1) cornerRadius:0]]];
    }

    [self setUpAllChildViewController];

}
- (void)setUpAllChildViewController{
    
    [self setUpOneChileViewController:[HomeVC new] title:NSLocalizedString(@"首页", nil) image:[UIImage imageNamed:@"tabbar.home.unselect"] selectedImage:[UIImage imageNamed:@"tabbar.home.select"]];
    
    [self setUpOneChileViewController:[GameVC new] title:NSLocalizedString(@"游戏", nil) image:[UIImage imageNamed:@"tabbar.market.unselect"] selectedImage:[UIImage imageNamed:@"tabbar.market.select"]];
    
//    [self setUpOneChileViewController:[TradeVC new] title:NSLocalizedString(@"交易", nil) image:[UIImage imageNamed:@"tabbar.assets.unselect"] selectedImage:[UIImage imageNamed:@"tabbar.assets.select"]];

    NSString *varL = @"我的";
    [self setUpOneChileViewController:[MineVC new] title:NSLocalizedString(varL, nil) image:[UIImage imageNamed:@"tabbar.mine.unselect"] selectedImage:[UIImage imageNamed:@"tabbar.mine.select"]];
    
}

// 添加一个控制器
- (void)setUpOneChileViewController:(UIViewController *)vc title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage{
    vc.tabBarItem.title = title;
    //    // 设图片 并防止图片被渲染
    vc.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
        if (@available(iOS 13.0, *)) {
                // iOS13 及以上
               //选中颜色
            self.tabBar.tintColor = kUIColorFromRGB(0xE2D09E);
               //默认颜色
            self.tabBar.unselectedItemTintColor = kUIColorFromRGB(0x707781);
         }
        else {
               // iOS13 以下
               UITabBarItem *item = [UITabBarItem appearance];
               [item setTitleTextAttributes:@{ NSForegroundColorAttributeName:kUIColorFromRGB(0x707781)} forState:UIControlStateNormal];
               [item setTitleTextAttributes:@{ NSForegroundColorAttributeName:kUIColorFromRGB(0xE2D09E)} forState:UIControlStateSelected];
         }
    
    RootNavigationController *nav = [[RootNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
}
#pragma mark - UITabBarDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    UINavigationController *navigationController = (UINavigationController *)viewController;
    UIViewController *mainViewController = navigationController.viewControllers.firstObject;
//    if ([mainViewController  isKindOfClass:[CSClassificationViewController class]]) {
//        CSClassificationViewController*vc = (CSClassificationViewController*)mainViewController;
//        vc.updateData = YES;
//    }
    return YES;
}
-(void)setPushTask:(NSString *)pushTask{
    _pushTask = pushTask;
//    if (pushTask && ![pushTask isEqualToString:@""]) {
//        UINavigationController * selectedNav = self.viewControllers[self.selectedIndex];
//        UIViewController *topViewController = [selectedNav.viewControllers lastObject];
//        [CSRouteManager protocolAnalysisURL:pushTask withRootViewController:topViewController];
//    }
}

@end
