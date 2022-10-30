//
//  AppDelegate.m
//  AllStars
//
//  Created by Mac on 2021/10/9.
//

#import "AppDelegate.h"
#import "RootTabBarViewController.h"
#import "HomeVC.h"
#import "Flurry.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window{
    if (_allowRotation == YES) {   // 如果属性值为YES,仅允许屏幕向左旋转,否则仅允许竖屏
        return UIInterfaceOrientationMaskLandscapeRight;  // 这里是屏幕要旋转的方向
    }else{
        return (UIInterfaceOrientationMaskPortrait);
    }
}
// 返回是否支持设备自动旋转
- (BOOL)shouldAutorotate
{
    if (_allowRotation == 1) {
        return YES;
    }
    return NO;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //语言设置
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"myLanguage"] && ![[[NSUserDefaults standardUserDefaults] objectForKey:@"myLanguage"] isEqualToString:@""]) {
        NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"myLanguage"];
        [NSBundle setLanguage:str];
    }else{
        NSString *currentLanguage = [[NSLocale preferredLanguages]objectAtIndex:0];
        if ([currentLanguage hasPrefix:@"zh"]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"zh_CN" forKey:@"myLanguage"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:@"en_US" forKey:@"myLanguage"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    NSString *filePath = [NSString stringWithFormat:@"%@/Documents/account.txt", NSHomeDirectory()];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    if (result) {
        NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
        if (arr.count>0) {
            NSDictionary *dic = [arr firstObject];
            UserInfoModel *model = [UserInfoModel mj_objectWithKeyValues:dic];
            [[UserInfoConfig shareManager] saveUserInfo:model];
        }
    }
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = CNavBgColor;
    RootTabBarViewController *VC = [[RootTabBarViewController alloc]init];
    //    UIWindow *window =  [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    self.window.rootViewController = VC;
    [self.window makeKeyAndVisible];
    // Flurry  SGT7QWMGYWH22BDC3PHK
    [Flurry startSession:@"SGT7QWMGYWH22BDC3PHK"
      withSessionBuilder:[[[FlurrySessionBuilder new]
                           withCrashReporting:YES]
                          withLogLevel:FlurryLogLevelDebug]];
//    //状态栏
    return YES;
}

-(void)updateVersion{
    NSString * strurl = @"itms-apps://itunes.apple.com/app/id11612020610";//替换为自己App的ID
    NSURLSession *session=[NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:strurl];
    
    //3.创建可变的请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        //8.解析数据
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSArray * results = dict[@"results"];
        NSDictionary * dic = results.firstObject;
        NSString * lineVersion = dic[@"version"];//版本号
        NSString * releaseNotes = dic[@"releaseNotes"];//更新说明
        NSString * trackViewUrl = dic[@"trackViewUrl"];//链接
        HFLog(@"App store版本号:%@",lineVersion);
        HFLog(@"更新说明:%@",releaseNotes);
        HFLog(@"App下载链接:%@",trackViewUrl);
        
        NSCharacterSet *nonDigitCharacterSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        
        //获取字符串中的数字
        app_Version = [[app_Version componentsSeparatedByCharactersInSet:nonDigitCharacterSet] componentsJoinedByString:@""];//本地的app版本
        lineVersion = [[lineVersion componentsSeparatedByCharactersInSet:nonDigitCharacterSet] componentsJoinedByString:@""];//App store的app版本
        HFLog(@"结果是本地的app版本:%@ \n App store的app版本:%@ ",app_Version,lineVersion);
        
        // 获取NSUserDefaults对象
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:lineVersion forKey:@"App_store_version"];
        [defaults synchronize];  //如果要立刻保存就需要这行代码
        
        if ([lineVersion integerValue]>[app_Version integerValue]) {//App
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strurl] options:@{} completionHandler:nil];
        }else{
            HFLog(@"111没有新版本不用更新提示");
        }
        
    }];
    //7.执行任务
    [dataTask resume];
}
@end
