//
//  HomeVC.m
//  AllStars
//
//  Created by Mac on 2021/10/9.
//

#import "HomeVC.h"
#import "SDCycleScrollView.h"
#import "TXScrollLabelView.h"
#import "HomeCardScrollView.h"
#import "HeroCardInfoModel.h"
#import "CreatWalletPopView.h"
#import "PassWordSetVC.h"
#import "VerifyPassWordVC.h"
#import "WkWebViewVC.h"
#import "GameWebVC.h"
#import "AllStars-Bridging-Header.h"
#import "AllStars-Swift.h"
#import "BannerInfoModel.h"
#import "PopViewInfoModel.h"
#import "PopUpView.h"
#import "LanguageTool.h"
@interface HomeVC ()<SDCycleScrollViewDelegate,TXScrollLabelViewDelegate,CreateWalletPopViewDelegate,PopUpViewDelegate>
@property(nonatomic,strong)UIView *customNav;
@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)UIView *headV;
@property (nonatomic,strong) SDCycleScrollView *cycleScrollView; //轮播图
@property (nonatomic,strong) TXScrollLabelView *scrollLabelView;
@property (nonatomic,strong) HomeCardScrollView *cardScrollView;
@property(nonatomic,strong)NSMutableArray *bannerArr;
@property(nonatomic,strong)NSMutableArray *heroArr;
@property(nonatomic,strong)NSMutableArray *popViewArr;
@property (nonatomic, strong) CreatWalletPopView *creatWalletView;
@end

@implementation HomeVC{
    UIImageView *gameJumpV;
    UIView *scrollBg;
    UIButton *unLoginBtn;
    UILabel *loginL;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"myLanguage"]hasPrefix:@"en"]) {
        gameJumpV.image = MYIMAGE(@"moBoxJump_en");
    }else{
        gameJumpV.image = MYIMAGE(@"moBoxJump_zh");
    }

    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getBanlanceData) name:@"getBanlanceDataNotice" object:nil];
    // 判读是否登录了钱包
    if ([UserInfoConfig shareManager].address.length == 0) {
//        self.creatWalletView = [[CreatWalletPopView alloc]initWithFrame:CGRectMake(35, (KScreenHeight-300)/2, KScreenWidth-70, 300)];
//        self.creatWalletView.delegate = self;
//        [self.creatWalletView showPopView];
        unLoginBtn.hidden = NO;
        loginL.hidden = YES;
    }else{
        unLoginBtn.hidden = YES;
        loginL.hidden = NO;
        loginL.text = [NSString stringWithFormat:@" %@  ",[UserInfoConfig shareManager].address];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestBanaerData];
    [self requestCard];
    self.bannerArr = @[].mutableCopy;
    self.heroArr = @[].mutableCopy;
    self.popViewArr = @[].mutableCopy;
    [self.view addSubview:self.customNav];
    [self.view addSubview:self.myTableView];
    [self creatRewardView];
//            [self getBanlanceData];
            [self requestPopViewData];
   

  
}
-(void)getBanlanceData{
    if ([UserInfoConfig shareManager].address.length>0) {
        //账号余额
        coinTranstion *ct = [[coinTranstion alloc] init];
        ct.jsonDic = @{@"stlToken":stlToken,
                      @"from":[UserInfoConfig shareManager].address,
                      @"token":starToken
        };
        dispatch_queue_t concurrent_queue = dispatch_queue_create("come.stars", DISPATCH_QUEUE_CONCURRENT);
           dispatch_async(concurrent_queue, ^{
               NSString *starS = [ct getTokenBalance];
               NSString *BNBS = [ct getBalance];
               NSString *sltS = [ct getStlTokenBalance];
               NSArray *arr = @[starS,sltS,BNBS];
               [UserInfoConfig shareManager].balaceArr = arr;
           });
             
        
    }
}
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.customNav.bottom, KScreenWidth, KScreenHeight-kNavAndTabHeight) style:UITableViewStyleGrouped];
        _myTableView.backgroundColor =CViewBgColor;
        _myTableView.tableHeaderView = self.headV;
    }
    return _myTableView;
}
-(UIView*)headV{
    if (!_headV) {
        _headV  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 850)];
        [_headV addSubview:self.cycleScrollView];
        [self loadSubViews];
    }
    return _headV;
}
-(UIView*)customNav{
    if (!_customNav) {
        _customNav = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, kNavBarAndStatusBarHeight)];
        _customNav.backgroundColor = CNavBgColor;
        
        UIImageView *iconV = [Tool createImageViewWithFrame:CGRectMake(10, kNavBarAndStatusBarHeight-55 , 89, 55) image:MYIMAGE(@"all-star") placeholderImge:nil];
        iconV.contentMode = UIViewContentModeScaleAspectFit;
        [_customNav addSubview:iconV];
        
        unLoginBtn = [Tool createButtonWithFrame:CGRectMake(KScreenWidth-70, kNavBarAndStatusBarHeight-35, 55, 25)  title:@"Conect" titleColor:CNavBgColor textFont:MYBOLDFONT(11) backgroudColor:nil target:self action:@selector(loginAction)];
        UIImage *bg = [UIColor gradientImageWithView:unLoginBtn fromColor:@"#003FFF" toColor:@"#00FFFF" startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) cornerRadius:12.5];
        unLoginBtn.backgroundColor = [UIColor colorWithPatternImage:bg];
        [_customNav addSubview:unLoginBtn];
        
        loginL = [Tool createLabelWithFrame:CGRectMake(KScreenWidth-90, kNavBarAndStatusBarHeight-35, 75, 25) textColor:kUIColorFromRGB(0x008AFF) textFont:MYBOLDFONT(11) textAligion:NSTextAlignmentCenter labelText:[NSString stringWithFormat:@" %@   ",[UserInfoConfig shareManager].address]];
        loginL.lineBreakMode = NSLineBreakByTruncatingMiddle;
        loginL.layer.borderColor = kUIColorFromRGB(0x008AFF).CGColor;
        loginL.layer.borderWidth = 1;
        loginL.layer.cornerRadius = 12.5;
        loginL.layer.masksToBounds = YES;
        [_customNav addSubview:loginL];
    }
    return  _customNav;
}
-(void)loginAction{
    self.creatWalletView = [[CreatWalletPopView alloc]initWithFrame:CGRectMake(35, (KScreenHeight-300)/2, KScreenWidth-70, 300)];
    self.creatWalletView.delegate = self;
    [self.creatWalletView showPopView];
    [self.view bringSubviewToFront:self.creatWalletView];
}
-(SDCycleScrollView*)cycleScrollView{
    if (!_cycleScrollView) {
        //todo 增加适配
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0, KScreenWidth, 200) delegate:self placeholderImage:[UIImage imageNamed:@""]]; //-45
        if ([[Tool iphoneType] isEqualToString:@"iPhone 5s"]) {
            _cycleScrollView.frame = CGRectMake(0, 0, KScreenWidth, 130);
        }else if ([[Tool iphoneType] isEqualToString:@"iPhone X"] || [[Tool iphoneType] isEqualToString:@"iPhone XR"] ||[[Tool iphoneType] isEqualToString:@"iPhone XS"] ||[[Tool iphoneType] isEqualToString:@"iPhone XS Max"]){
//            _cycleScrollView.frame = CGRectMake(0, -44, KScreenWidth, kBannerH);
        }
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _cycleScrollView.backgroundColor = CViewBgColor;
        _cycleScrollView.currentPageDotColor = CLineColor;
        _cycleScrollView.pageDotColor = [UIColor whiteColor];
        _cycleScrollView.pageControlDotSize = CGSizeMake(7, 7);
        _cycleScrollView.pageControlBottomOffset = 0;
    }
    _cycleScrollView.userInteractionEnabled = YES;
    return _cycleScrollView;
}
#pragma mark SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    HFLog(@"轮播_____%ld",(long)index);
    BannerInfoModel *model = self.bannerArr[index];
    if (model.link_url.length == 0) {
        return;
    }
    if (model.link_direction.intValue == 1) { //横屏
        if ([UserInfoConfig shareManager].address.length==0) {
            self.creatWalletView = [[CreatWalletPopView alloc]initWithFrame:CGRectMake(35, (KScreenHeight-300)/2, KScreenWidth-70, 300)];
            self.creatWalletView.delegate = self;
            [self.creatWalletView showPopView];
            [self.view bringSubviewToFront:self.creatWalletView];
        }else{
            DAppWebViewController *vc = [[DAppWebViewController alloc]init];
            NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"myLanguage"];
            NSString *url;
            NSString *baseUrl = buildBaseUrl;
            if ([str hasPrefix:@"zh"]) {
               
                url = [NSString stringWithFormat:@"%@?address=%@&sys=ios&language=1",baseUrl,[UserInfoConfig shareManager].address];
            }else{
                url = [NSString stringWithFormat:@"%@?address=%@&sys=ios",baseUrl,[UserInfoConfig shareManager].address];
            }
            vc.homepage = url;
            vc.fromS = @"1";
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        GameWebVC *vc = [GameWebVC new];
        vc.urlS = model.link_url;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
-(TXScrollLabelView*)scrollLabelView{
    if (!_scrollLabelView) {
        self.scrollLabelView = [TXScrollLabelView scrollWithTextArray:@[] type:TXScrollLabelViewTypeLeftRight velocity:1 options:UIViewAnimationOptionCurveEaseInOut inset:UIEdgeInsetsZero];
        /** Step3: 设置代理进行回调 */
        self.scrollLabelView.scrollLabelViewDelegate = self;
        /** Step4: 布局(Required) */
        self.scrollLabelView.frame = CGRectMake(40, 0, scrollBg.width-60, 34);
        [scrollBg addSubview:self.scrollLabelView];
        //偏好(Optional), Preference,if you want.
        self.scrollLabelView.scrollInset = UIEdgeInsetsMake(0, 10 , 0, 10);
        self.scrollLabelView.scrollSpace = 10;
        self.scrollLabelView.font = [UIFont systemFontOfSize:12];
        self.scrollLabelView.scrollTitleColor = kUIColorFromRGB(0xffffff);
        self.scrollLabelView.textAlignment = NSTextAlignmentCenter;
        self.scrollLabelView.backgroundColor = [UIColor clearColor];
        /** Step5: 开始滚动(Start scrolling!) */
        [self.scrollLabelView beginScrolling];
    }
    return _scrollLabelView;
}
- (void)loadSubViews{
    
    scrollBg = [[UIView alloc]initWithFrame:CGRectMake(15, self.cycleScrollView.bottom-20, KScreenWidth-30, 34)];
    scrollBg.backgroundColor = kUIColorFromRGB(0x4D617C);
    scrollBg.layer.cornerRadius = 5;
    scrollBg.layer.masksToBounds = YES;
    [_headV addSubview:scrollBg];
    UIImageView *iconV = [Tool createImageViewWithFrame:CGRectMake(8, 10, 17, 14) image:MYIMAGE(@"laBa") placeholderImge:nil];
    [scrollBg addSubview:iconV];
    //去掉滚动条
    scrollBg.hidden = YES;
    
    
//    gameJumpV = [Tool createImageViewWithFrame:CGRectMake(15, self.cycleScrollView.bottom+30, KScreenWidth-30, 91) image:MYIMAGE(@"homeMidImg") placeholderImge:nil];
//    gameJumpV.userInteractionEnabled = YES;
//    gameJumpV.contentMode = UIViewContentModeScaleAspectFill;
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"myLanguage"]hasPrefix:@"en"]) {
//        gameJumpV.image = MYIMAGE(@"moBoxJump_en");
//    }else{
//        gameJumpV.image = MYIMAGE(@"moBoxJump_zh");
//    }
//    [_headV addSubview:gameJumpV];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gameEnterAction)];
//    tap.numberOfTapsRequired = 1;
//    [gameJumpV addGestureRecognizer:tap];
    
    UIView *titleV = [Tool createViewFrame:CGRectMake((KScreenWidth-210)/2, self.cycleScrollView.bottom+30, 210, 30) startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) colorS:@[(__bridge id)[UIColor colorWithRed:30/255.0 green:41/255.0 blue:52/255.0 alpha:0.0].CGColor,(__bridge id)[UIColor colorWithRed:30/255.0 green:41/255.0 blue:52/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:30/255.0 green:41/255.0 blue:52/255.0 alpha:0.0].CGColor] locationS: @[@(0.0),@(0.5f),@(1.0f)]];
    [_headV addSubview:titleV];
    UILabel *titleL = [Tool createLabelWithFrame:titleV.bounds textColor:CLineColor textFont:MYBOLDFONT(18) textAligion:NSTextAlignmentCenter labelText:NSLocalizedString(@"史诗级明星", nil)];
    [titleV addSubview:titleL];
    
    self.cardScrollView = [[HomeCardScrollView alloc]initWithFrame:CGRectMake(0, titleV.bottom+15, KScreenWidth, 310)];
    [_headV addSubview:self.cardScrollView];
    
    UIView *joinV = [Tool createViewFrame:CGRectMake((KScreenWidth-210)/2, self.cardScrollView.bottom+30, 210, 30) startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) colorS:@[(__bridge id)[UIColor colorWithRed:30/255.0 green:41/255.0 blue:52/255.0 alpha:0.0].CGColor,(__bridge id)[UIColor colorWithRed:30/255.0 green:41/255.0 blue:52/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:30/255.0 green:41/255.0 blue:52/255.0 alpha:0.0].CGColor] locationS: @[@(0.0),@(0.5f),@(1.0f)]];
    [_headV addSubview:joinV];
    UILabel *joinL = [Tool createLabelWithFrame:joinV.bounds textColor:CLineColor textFont:MYBOLDFONT(18) textAligion:NSTextAlignmentCenter labelText:NSLocalizedString(@"加入我们社区", nil)];
    [joinV addSubview:joinL];
    
    UIView *teleV = [Tool createViewFrame:CGRectMake(15, joinV.bottom+15, KScreenWidth-30, 135) startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) colorS:@[(__bridge id)[UIColor colorWithRed:57/255.0 green:35/255.0 blue:83/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:38/255.0 green:57/255.0 blue:84/255.0 alpha:1.0].CGColor] locationS: @[@(0.0),@(1.0f)]];
    teleV.layer.cornerRadius = 5;
    teleV.layer.masksToBounds = YES;
    [_headV addSubview:teleV];
    UIImageView *teleIcon = [Tool createImageViewWithFrame:CGRectMake(25, 42.5, 50, 50) image:MYIMAGE(@"teleIcon") placeholderImge:nil];
    teleIcon.layer.cornerRadius = 4;
    teleIcon.layer.masksToBounds = YES;
    [teleV addSubview:teleIcon];
    UILabel *telName = [Tool createLabelWithFrame:CGRectMake(teleIcon.right+15, teleIcon.top, 90, teleIcon.height) textColor:[UIColor whiteColor] textFont:MYBOLDFONT(18) textAligion:NSTextAlignmentLeft labelText:NSLocalizedString(@"电报", nil)];
    [teleV addSubview:telName];
//    UILabel *countN = [Tool createLabelWithFrame:CGRectMake(teleIcon.right+15, telName.bottom, 60, 25) textColor:CLineColor textFont:MYBOLDFONT(20) textAligion:NSTextAlignmentLeft labelText:@"60K+"];
//    [teleV addSubview:countN];
    UILabel *telcontentL = [Tool createLabelWithFrame:CGRectMake(telName.right+10, 27, KScreenWidth-225, 55) textColor:[UIColor whiteColor] textFont:MYBOLDFONT(11) textAligion:NSTextAlignmentLeft labelText:NSLocalizedString(@"交流不同的主题，分享你的游戏成果，寻找志同道合的朋友！加入我们的聊天吧！", nil)];
    telcontentL.numberOfLines = 4;
    [teleV addSubview:telcontentL];
    UIButton *subjectBtn = [Tool createButtonWithFrame:CGRectMake(telcontentL.left, telcontentL.bottom+10, 70, 25) title:NSLocalizedString(@"订阅", nil) titleColor:CNavBgColor textFont:MYBOLDFONT(13) backgroudColor:[UIColor clearColor] target:self action:@selector(subjectAction)];
    UIImage *bg = [UIColor gradientImageWithView:subjectBtn fromColor:@"#C8AC7C" toColor:@"#F9EFBC" startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) cornerRadius:5];
    [subjectBtn setBackgroundImage:bg forState:UIControlStateNormal];
    [teleV addSubview:subjectBtn];
    
}
-(void)subjectAction{
    NSString *urlString;
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"myLanguage"]hasPrefix:@"en"]) {
        urlString = @"https://t.me/ALLstar_EN";
    }else{
        urlString = @"https://t.me/ALLstar_CN";
    }
    WkWebViewVC *vc = [WkWebViewVC new];
    vc.urlS = urlString;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)scrollLabelView:(TXScrollLabelView *)scrollLabelView didClickWithText:(NSString *)text atIndex:(NSInteger)index{
    NSLog(@"%@--%ld",text, index);
}
#pragma mark CreateWalletPopViewDelegate
-(void)importWalletAction{
    [self.creatWalletView hidePopView];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"coinPass"]length]>0) {
        VerifyPassWordVC *VC = [VerifyPassWordVC new];
        VC.isImport = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }else{
        PassWordSetVC *VC = [PassWordSetVC new];
        VC.isImport = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }
}
-(void)createWalletAction{
    [self.creatWalletView hidePopView];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"coinPass"]length]>0) {
        VerifyPassWordVC *VC = [VerifyPassWordVC new];
        [self.navigationController pushViewController:VC animated:YES];
    }else{
        PassWordSetVC *VC = [PassWordSetVC new];
        [self.navigationController pushViewController:VC animated:YES];
    }
}
-(void)gameEnterAction{
    
    if ([UserInfoConfig shareManager].address.length == 0) {
        self.creatWalletView = [[CreatWalletPopView alloc]initWithFrame:CGRectMake(35, (KScreenHeight-300)/2, KScreenWidth-70, 300)];
        self.creatWalletView.delegate = self;
        [self.creatWalletView showPopView];
        [self.view bringSubviewToFront:self.creatWalletView];
    }else{
        DAppWebViewController *vc = [[DAppWebViewController alloc]init];
        NSString *url;
        NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"myLanguage"];
        if ([str hasPrefix:@"zh"]) {
            url = [NSString stringWithFormat:@"%@?sys=ios&lang=ch",magicBox];
        }else{
            url = [NSString stringWithFormat:@"%@?sys=ios&lang=en",magicBox];
        }
        vc.homepage = url;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
-(void)requestCard{
//     [self.view showHUD];
    NSDictionary *dic = @{@"cardTypeInt":@(1)};
    [[CSNetworkTool shareManager]postMethodName:URL_cardList parameter:dic images:nil success:^(id responseObject, BOOL loadSuccess) {
//        [self.view hideHUD];
        if (loadSuccess) {
            NSArray *arr = [responseObject objectForKey:@"data"];
            self.heroArr = [HeroCardInfoModel mj_objectArrayWithKeyValuesArray:arr];
            NSMutableArray *newArr = @[].mutableCopy;
            for (int i = 0; i < self.heroArr.count; i ++) {
                    
                    HeroCardInfoModel *model = self.heroArr[i];
                    
                    NSMutableArray *tempArray = [@[] mutableCopy];
                    
                    [tempArray addObject:model];
                    
                    for (int j = i+1; j < self.heroArr.count; j ++) {
                        
                        HeroCardInfoModel *model1 = self.heroArr[j];
                        
                        if([model.name isEqualToString:model1.name]){
                            
                            [tempArray addObject:model1];
                            
                            [self.heroArr removeObjectAtIndex:j];
                            j -= 1;
                        }
                    }
                    [newArr addObject:tempArray];
                }
            NSMutableArray *finalArr = @[].mutableCopy;
            for (int i = 0; i<newArr.count; i++) {
                NSArray *arr = newArr[i];
                __block HeroCardInfoModel *tempModel = [HeroCardInfoModel new];
                [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    tempModel = arr[0];
                    if (idx>0) {
                        HeroCardInfoModel *model = arr[idx];
                        if (model.quality.intValue>tempModel.quality.intValue) {
                            tempModel = model;
                        }
                    }
                }];
                [finalArr addObject:tempModel];
            }
            
            self.cardScrollView.dataArr = finalArr;
            [self.cardScrollView.collectionView  reloadData];
            
        }else{
//         [ZQProgressHUD showErrorWithTitle:responseObject[@"msg"]];
            [self.view showHUDWithText:responseObject[@"msg"]];
        }
     
    } failure:^(NSError *error) {

   }];
    
}
-(void)requestBanaerData{
    NSString *currentLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:@"myLanguage"];
    NSString *langS;
    if ([currentLanguage hasPrefix:@"zh"]) {
        langS = @"2";
    }else{
        langS = @"1";
    }
    NSDictionary *dic = @{@"language":@(langS.intValue),
                          @"type":@(2)
    };
    
    [[CSNetworkTool shareManager]postMethodName:URL_homeBanaer parameter:dic images:nil success:^(id responseObject, BOOL loadSuccess) {
//        [self.view hideHUD];
        if (loadSuccess) {
            NSArray *arr= [responseObject objectForKey:@"data"];
            NSMutableArray *imageArr = @[].mutableCopy;
            if (self.bannerArr.count>0) {
                [self.bannerArr removeAllObjects];
            }
            for (NSDictionary *dic in arr) {
                BannerInfoModel *model = [BannerInfoModel new];
                model = [BannerInfoModel mj_objectWithKeyValues:dic];
                [self.bannerArr addObject:model];
            }
            for (int i=0; i<self.bannerArr.count-1; i++) {
                BannerInfoModel *tempModel = self.bannerArr[0];
                BannerInfoModel *model1 = self.bannerArr[i];
                BannerInfoModel *model2 = self.bannerArr[i+1];
                if (model1.weight.intValue < model2.weight.intValue) {
                    tempModel = self.bannerArr[i];
                    self.bannerArr[i] = self.bannerArr[i+1];
                    self.bannerArr[i+1] = tempModel;
                }
            }
            for (BannerInfoModel *model in self.bannerArr) {
              NSString *url = [model.link_img stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//编码

                [imageArr addObject:url];
            }
            self.cycleScrollView.imageURLStringsGroup = imageArr;
//            [self.cycleScrollView reloadInputViews];
            
        }else{
            [self.view showHUDWithText:responseObject[@"msg"]];
        }
     
    } failure:^(NSError *error) {

   }];
    
}
-(void)requestPopViewData{
    NSString *currentLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:@"myLanguage"];
    NSString *langS;
    if ([currentLanguage hasPrefix:@"zh"]) {
        langS = @"2";
    }else{
        langS = @"1";
    }
    NSDictionary *dic = @{@"language":@(langS.intValue),
                          @"type":@(2),
                          @"position":@(1)
    };
    
    [[CSNetworkTool shareManager]postMethodName:URL_homePopUp parameter:dic images:nil success:^(id responseObject, BOOL loadSuccess) {
//        [self.view hideHUD];
        if (loadSuccess) {
            NSArray *arr= [responseObject objectForKey:@"data"];
            if (self.popViewArr.count>0) {
                [self.popViewArr removeAllObjects];
            }
            NSMutableArray *newArr = [PopViewInfoModel mj_objectArrayWithKeyValuesArray:arr];
    
            self.popViewArr = newArr;
            if (newArr.count==0) {
                // 判读是否登录了钱包
                if ([UserInfoConfig shareManager].address.length == 0) {
                    self.creatWalletView = [[CreatWalletPopView alloc]initWithFrame:CGRectMake(35, (KScreenHeight-300)/2, KScreenWidth-70, 300)];
                    self.creatWalletView.delegate = self;
                    [self.creatWalletView showPopView];
                }
            }else{
                [self showPopView:newArr];
            }
            
            
        }else{
            [self.view showHUDWithText:responseObject[@"msg"]];
        }
     
    } failure:^(NSError *error) {

   }];
    
}

-(void)showPopView:(NSMutableArray*)arr{
    
    for (int i=0; i<arr.count-1; i++) {
        PopViewInfoModel *tempModel = arr[0];
        PopViewInfoModel *model1 = arr[i];
        PopViewInfoModel *model2 = arr[i+1];
        if (model1.weight.intValue > model2.weight.intValue) {
            tempModel = arr[i];
            arr[i] = arr[i+1];
            arr[i+1] = tempModel;
        }
    }
    //读取缓存
    NSString *filePath = [NSString stringWithFormat:@"%@/Documents/HomePop.txt", NSHomeDirectory()];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    if (result) {
        NSArray *oldArr = [NSArray arrayWithContentsOfFile:filePath];
        for (NSDictionary *dic in oldArr) {
            if ([[dic objectForKey:@"type"]intValue] == 1) {
                [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    PopViewInfoModel *model = arr[idx];
                    if (model.pop_type.intValue == 1) {
                        [arr removeObject:obj];
                    }
                }];
            }
            if ([[dic objectForKey:@"type"]intValue] == 3) {
                [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    PopViewInfoModel *model = arr[idx];
                    if (model.ID.intValue == [[dic objectForKey:@"id"]intValue]) {
                        if (model.pop_freq.intValue <= [[dic objectForKey:@"count"]intValue]) {
                            [arr removeObject:obj];
                        }
                    }
                }];
            }
        }

    }
    
    if (arr.count>0) {
        PopUpView *view = [[PopUpView alloc ]initWithFrame:CGRectMake((KScreenWidth*0.4)/2, (KScreenHeight*0.6)/2, KScreenWidth*0.6, KScreenHeight*0.4)];
        PopViewInfoModel *model = arr[0];
        HFLog(@"%@",model.link_img);
        view.tag = model.ID.intValue+100;
        view.delegate = self;
        [view showPopView];
      NSString *url =  [model.link_img stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//编码
        [view.contentV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",url]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            NSLog(@"%@",error);
        }];
    }
    //最后显示创建钱包
    if ([UserInfoConfig shareManager].address.length == 0) {
        self.creatWalletView = [[CreatWalletPopView alloc]initWithFrame:CGRectMake(35, (KScreenHeight-300)/2, KScreenWidth-70, 300)];
        self.creatWalletView.delegate = self;
        [self.creatWalletView showPopView];
    }
    //保存显示次数
    if (!result) {
        NSMutableArray *newArr = @[].mutableCopy;
        for (PopViewInfoModel *model in arr) {
            if (model.pop_type.intValue == 1) {
                NSDictionary *dic = @{@"count":@"1",
                                      @"id":model.ID,
                                      @"type":model.pop_type
                };
                [newArr addObject:dic];
            }
            if (model.pop_type.intValue == 3) {
                NSDictionary *dic = @{@"count":@"1",
                                      @"id":model.ID,
                                      @"type":model.pop_type
                };
                [newArr addObject:dic];
            }
        }
        [newArr writeToFile:filePath atomically:YES];
    }else{
        NSArray *oldArr = [NSArray arrayWithContentsOfFile:filePath];
        NSMutableArray *newArr = @[].mutableCopy;
        for (NSDictionary *dic in oldArr) {
            if ([[dic objectForKey:@"type"]intValue] == 1) {
                [newArr addObject:dic];
            }
            if ([[dic objectForKey:@"type"]intValue] == 3) {
                NSString *newValue =[NSString stringWithFormat:@"%d",[[dic objectForKey:@"count"]intValue]+1];
                [dic setValue:newValue forKey:@"count"];
                [newArr addObject:dic];
            }
        }
        [newArr writeToFile:filePath atomically:YES];
    }
}
-(void)creatRewardView{
    UIImageView *iconImg = [[UIImageView alloc]init];
    [self.view addSubview:iconImg];
    iconImg.userInteractionEnabled = YES;
    iconImg.layer.zPosition = 20;
    iconImg.contentMode = UIViewContentModeScaleAspectFit;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goReward)];
    [iconImg addGestureRecognizer:tap];
    iconImg.image = [UIImage imageNamed:[LanguageTool getImageNameWith:@"reward"]];
    [iconImg  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.view).offset(Height_NavBar+120);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(74);
    }];
}
-(void)goReward{
    if ([UserInfoConfig shareManager].address.length == 0) {
        [self loginAction];
        return;
    }
    DAppWebViewController *vc = [[DAppWebViewController alloc]init];
    vc.homepage = bdd;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)popUpJumpAction:(NSInteger)index{
    for (PopViewInfoModel *model in self.popViewArr) {
        if (model.ID.intValue == index) {
            if ([model.link_url containsString:@"http"]) {
                GameWebVC *vc = [GameWebVC new];
                vc.urlS = model.link_url;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                
            }
        }
    }
}
@end
