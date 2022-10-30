//
//  GameWebVC.m
//  AllStars
//
//  Created by Mac on 2021/12/16.
//

#import "GameWebVC.h"
#import <WebKit/WebKit.h>
@interface GameWebVC ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic,strong) WKWebView *webView;
@end

@implementation GameWebVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear :animated];
    self.navigationController.navigationBar.hidden = YES;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, kNavBarHeight, 25, 25);
    [btn setImage:[UIImage imageNamed:@"gameClose"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(leftBarButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    if ([self.isRotate isEqualToString:@"1"]) {
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        app.allowRotation = YES;
        [self setNewOrientation:YES];
        btn.mj_y = 20;
        
    }
  
}
-(void)setNewOrientation:(BOOL)isFull{
    if (isFull) {
        NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight];
            [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    }else{
        NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
           [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    }
    
}

//导航栏的点击事件
-(void)leftBarButtonItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CViewBgColor;
    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
     _webView.backgroundColor = CViewBgColor;
    _webView.scrollView.scrollEnabled=YES;
    // UI代理
    _webView.UIDelegate = self;
    // 导航代理
    _webView.navigationDelegate = self;
    // 是否允许手势左滑返回上一级, 类似导航控制的左滑返回
    _webView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    //加载网络url
    NSURLRequest *_request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlS] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15.0];
    [_webView loadRequest:_request];
    
     //添加监测网页加载进度的观察者
    [self.webView addObserver:self
                      forKeyPath:@"estimatedProgress"
                         options:0
                         context:nil];
      //添加监测网页标题title的观察者
    [self.webView addObserver:self
                      forKeyPath:@"title"
                         options:NSKeyValueObservingOptionNew
                         context:nil];
}

   //kvo 监听进度 必须实现此方法
-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                      context:(void *)context{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]
        && object == _webView) {
       NSLog(@"网页加载进度 = %f",_webView.estimatedProgress);
//        self.progressView.progress = _webView.estimatedProgress;
//        if (_webView.estimatedProgress >= 1.0f) {
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                self.progressView.progress = 0;
//            });
//        }
    }else if([keyPath isEqualToString:@"title"]
             && object == _webView){
//        self.navigationItem.title = _webView.title;
    }else{
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
//     //移除观察者
//       [_webView removeObserver:self
//                     forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
//       [_webView removeObserver:self
//                     forKeyPath:NSStringFromSelector(@selector(title))];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (app.allowRotation) {
        app.allowRotation = NO;
        NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
           [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    }
    

}
@end

