//
//  RootViewController.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/18.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "RootViewController.h"


@interface RootViewController ()<HFNoInternetViewDelegate,HFTimeOutViewDelegate>

@property (nonatomic,strong) UIView* emptyDataView;

@end

@implementation RootViewController

- (UIStatusBarStyle)preferredStatusBarStyle{
    return _StatusBarStyle;
}
//动态更新状态栏颜色
-(void)setStatusBarStyle:(UIStatusBarStyle)StatusBarStyle{
    _StatusBarStyle=StatusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CViewBgColor;
    //是否显示返回按钮
    self.isShowLeftBack = YES;
    //默认导航栏样式：黑字
    //    self.StatusBarStyle = UIStatusBarStyleLightContent;
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 22, 22);
    [leftButton addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:MYIMAGE(@"nav_back_white") forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

   
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}

-(void)showNoDataImage:(UIImage*)image withTitle:(NSString*)title offSetY:(CGFloat)value
{
    if (_emptyDataView) {
        [_emptyDataView removeFromSuperview];
        _emptyDataView = nil;
    }
    _emptyDataView=[[UIView alloc] init];
    _emptyDataView.userInteractionEnabled = YES;
    [self.view.subviews enumerateObjectsUsingBlock:^(UITableView* obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UITableView class]]||[obj isKindOfClass:[UICollectionView class]]) {
            
            [self->_emptyDataView setFrame:CGRectMake(0, 280,obj.frame.size.width, KScreenHeight-280)];
            [obj addSubview:self->_emptyDataView];
            
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake((KScreenWidth-220)/2, 100, 220, 170)];
            imageV.image = image;
            [self->_emptyDataView addSubview:imageV];
            UILabel *titleL = [Tool createLabelWithFrame:CGRectMake(0, imageV.bottom+20, obj.frame.size.width, 23) textColor:kUIColorFromRGB(0x999999) textFont:MYFONT(15) textAligion:NSTextAlignmentCenter labelText:title];
            [self->_emptyDataView addSubview:titleL];
        }
    }];
    
}

-(void)showNoDataImage:(UIImage*)image withTitle:(NSString*)title
{
    if (_emptyDataView) {
        [_emptyDataView removeFromSuperview];
        _emptyDataView = nil;
    }
    _emptyDataView=[[UIView alloc] init];
    _emptyDataView.userInteractionEnabled = YES;
    [self.view.subviews enumerateObjectsUsingBlock:^(UITableView* obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UITableView class]]||[obj isKindOfClass:[UICollectionView class]]) {
            [self->_emptyDataView setFrame:CGRectMake(0, 0,obj.frame.size.width, obj.frame.size.height)];
            [obj addSubview:self->_emptyDataView];
            
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 220, 170)];
            imageV.image = image;
            imageV.center = self->_emptyDataView.center;
            [self->_emptyDataView addSubview:imageV];
            imageV.y = imageV.y-43;
            UILabel *titleL = [Tool createLabelWithFrame:CGRectMake(0, imageV.bottom+20, obj.frame.size.width, 23) textColor:kUIColorFromRGB(0x999999) textFont:MYFONT(15) textAligion:NSTextAlignmentCenter labelText:title];
            [self->_emptyDataView addSubview:titleL];
        }
    }];
    
}

-(void)removeNoDataImage{
    if (_emptyDataView) {
        [_emptyDataView removeFromSuperview];
        _emptyDataView = nil;
    }
}


/**
 *  是否显示返回按钮
 */
- (void) setIsShowLeftBack:(BOOL)isShowLeftBack
{
    _isShowLeftBack = isShowLeftBack;
    NSInteger VCCount = self.navigationController.viewControllers.count;
    //下面判断的意义是 当VC所在的导航控制器中的VC个数大于1 或者 是present出来的VC时，才展示返回按钮，其他情况不展示
    if (isShowLeftBack && ( VCCount > 1 || self.navigationController.presentingViewController != nil)) {
//        [self addNavigationItemWithImageNames:@[@"back_white"] isLeft:YES target:self action:@selector(backBtnClicked) tags:nil];
        
    } else {
        self.navigationItem.hidesBackButton = YES;
        UIBarButtonItem * NULLBar=[[UIBarButtonItem alloc]initWithCustomView:[UIView new]];
        self.navigationItem.leftBarButtonItem = NULLBar;
    }
}
- (void)backBtnClicked
{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}



//取消请求
- (void)cancelRequest
{
    
}

- (void)dealloc
{
    [self cancelRequest];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -  屏幕旋转
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    //当前支持的旋转类型
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    // 是否支持旋转
    return NO;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    // 默认进去类型
    return   UIInterfaceOrientationPortrait;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//显示无网络页面
-(void)showNoInternetView{
    NSInteger tag = 0;
    CGFloat YY = 0;
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[HFNoInternetView class]]) {
            tag++;
        }
        if ([view isKindOfClass:[UITableView class]]) {
            YY = view.y;
        }
    }
    if(tag>0)
        return;
    
    HFNoInternetView  * view = [[HFNoInternetView alloc] initWithFrame:CGRectMake(0, YY, KScreenWidth, KScreenHeight-YY)];
    view.delegate = self;
    [self.view addSubview:view];
}
- (void)hiddenNoInternetView{
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[HFNoInternetView class]]) {
            [view removeFromSuperview];
        }
    }
}
//显示超时页面
-(void)showTimeOutView{
    NSInteger tag = 0;
    CGFloat YY = 0;
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[HFTimeOutView class]]) {
            tag++;
        }
        if ([view isKindOfClass:[UITableView class]]) {
            YY = view.top;
        }
    }
    if(tag>0)
        return;
    
    HFTimeOutView  * view = [[HFTimeOutView alloc] initWithFrame:CGRectMake(0, YY, KScreenWidth, KScreenHeight-YY)];
    view.delegate = self;
    [self.view addSubview:view];
}
- (void)hiddenTimeOutView{
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[HFTimeOutView class]]) {
            [view removeFromSuperview];
        }
    }
}
- (void)reloadNetworkDataSource:(id)sender
{
    if ([self respondsToSelector:@selector(reloadRequest)]) {
        [self performSelector:@selector(reloadRequest)];
    }
}
-(void)refreshNetworkDataSource:(id)sender{
    if ([self respondsToSelector:@selector(reloadRequest)]) {
        [self performSelector:@selector(reloadRequest)];
    }
}
- (void)reloadRequest
{
    HFLog(@"必须由网络控制器(%@)重写这个方法(%@)，才可以使用再次刷新网络",NSStringFromClass([self class]),NSStringFromSelector(@selector(reloadRequest)));
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
//web页面判读网络
//-(BOOL)gardenNetWork{
//1. 检测网络
//    [self.view showHUD];
//    BOOL intenet = [Reachability isMayUseInternet];
//    if (intenet) { //有网
//        [self.view hideHUD];
//        [self hiddenNoInternetView];
//        return YES;
//    }else{
//        [self.view hideHUD];
//        [self.view showToastWithText:@"网络不给力，请稍后重试"];
//        [self showNoInternetView];
//        return NO;
//    }
//}
-(void)downLoadGift:(NSArray*)dataArr{
    for ( NSDictionary *dic in dataArr) {
        
        NSString *uStr = [dic objectForKey:@"swf"];
        if (uStr.length==0) {
            continue;
        }
        
        NSString *fileStr = [uStr substringWithRange:NSMakeRange(uStr.length-16, 16)];
        NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileStr];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL result = [fileManager fileExistsAtPath:filePath];
        
        if(!result){
            NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
            NSURL *url = [NSURL URLWithString:[dic objectForKey:@"swf"]];
            NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                
                if (error) {
                    NSLog(@"gif download error:%@", error);
                } else {
                    NSLog(@"gif download success, file path:%@",location.path);
                    //图片下载已完成，处理数据
                    NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileStr];
                    
                    //4.2 剪切文件到指定位置
                    [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:fullPath] error:nil];
                    
                    NSLog(@"1---%@",location);
                    NSLog(@"2---%@",fullPath);
                    NSLog(@"3---%@",response.suggestedFilename);
                    NSLog(@"4---%@",url.lastPathComponent);
                    
                }
            }];
            [task resume];
        }
        
    }
}
@end
