//
//  MineVC.m
//  AllStars
//
//  Created by Mac on 2021/10/9.
//

#import "MineVC.h"
#import "MineHeadView.h"
#import "ChangeSideVC.h"
#import "NSBundle+Language.h"
#import "RootTabBarViewController.h"
#import "MyInviteVC.h"
#import "MyCollectVC.h"
#import "WalletManageVC.h"
#import "YBPopupMenu.h"
#import "WalletRecvVC.h"
#import "WalletSendVC.h"
#import "WalletInfoVC.h"
#import "CoinListCell.h"
#import "AddCoinVC.h"
#import "MineListCell.h"
#import "LikeTableViewCell.h"
@interface MineVC ()<UITableViewDelegate,UITableViewDataSource,MineHeadViewDelegate,YBPopupMenuDelegate,WalletInfoVCDelegate>
@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)MineHeadView *headView;
@property(nonatomic,strong)NSString *STARSTR;
@property(nonatomic,strong)NSString *STLSTR;
@property(nonatomic,strong)NSString *BNBSTR;
@property(nonatomic,copy)NSArray *dataArr;

@end

@implementation MineVC{
    NSArray *iconArr;
    NSArray *titleArr;
    NSArray *originArr;
    NSArray *balanceArr;
    BOOL closeStatus;
    NSArray *collectArr;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"address"];
    if (str.length>0) {
        self.headView.nameL.text = str;
    }else{
        self.headView.nameL.text = @"--------";
        self.dataArr = @[@{@"num":@"---"},@{@"num":@"---"},@{@"num":@"---"}];        [self.myTableView reloadData];
    }
    if ([UserInfoConfig shareManager].address.length>0) {
        [self requestData]; //收藏的卡片
    }
    NSString *filePath = [NSString stringWithFormat:@"%@/Documents/config.txt", NSHomeDirectory()];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    if (result) {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
        NSString *str = [dic objectForKey:@"foundStatus"];
        if (str.intValue == 1) {
            [self.headView.foundBtn setImage:MYIMAGE(@"data_open") forState:UIControlStateNormal];
            closeStatus = NO;
            [self.myTableView reloadData];
        }else{
            [self.headView.foundBtn setImage:MYIMAGE(@"data_close") forState:UIControlStateNormal];
            closeStatus = YES;
            [self.myTableView reloadData];
        }
    }else{
        NSDictionary *dic = @{@"foundStatus":@"1"};
        [dic writeToFile:filePath atomically:YES];
    }
            
    //刷新余额
    if ([UserInfoConfig shareManager].address.length>0&&[UserInfoConfig shareManager].STARSTR.length>0) {
//        balanceArr = [UserInfoConfig shareManager].balaceArr;
        self.STARSTR = [UserInfoConfig shareManager].STARSTR;
        self.STLSTR = [UserInfoConfig shareManager].STLSTR;
        self.BNBSTR = [UserInfoConfig shareManager].BNBSTR;
    }else{
        self.STARSTR = @"--";
        self.STLSTR = @"--";
        self.BNBSTR = @"--";
    }
    [self.myTableView reloadData];
    [self getBanlanceData];

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
//               NSString *BNBS = [ct getBalance];
//               NSString *sltS = [ct getStlTokenBalance];
//               NSArray *arr = @[starS,sltS,BNBS];
//               [UserInfoConfig shareManager].balaceArr = arr;
               dispatch_async(dispatch_get_main_queue(), ^(){
//                   self->balanceArr = arr;
                   self.STARSTR = starS;
                   [UserInfoConfig shareManager].STARSTR = starS;

                   [self.myTableView reloadData];
                      });
           });
         dispatch_async(concurrent_queue, ^{
            NSString *BNBS = [ct getBalance];
            dispatch_async(dispatch_get_main_queue(), ^(){
                self.BNBSTR = BNBS;
                [UserInfoConfig shareManager].BNBSTR = BNBS;

                [self.myTableView reloadData];
                   });
        });
        dispatch_async(concurrent_queue, ^{
            NSString *sltS = [ct getStlTokenBalance];
           dispatch_async(dispatch_get_main_queue(), ^(){
               self.STLSTR = sltS;
               [UserInfoConfig shareManager].STLSTR = sltS;

               [self.myTableView reloadData];
                  });
       });
             
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self initData];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    self.navigationItem.title = NSLocalizedString(@"我的", nil);
    [self.view addSubview:self.myTableView];
    self.myTableView.tableHeaderView = self.headView;
//    self.myTableView.tableFooterView = self.footView;
   
}
-(void)initData{
    self.STARSTR = @"--";
    self.STLSTR = @"--";
    self.BNBSTR = @"--";
    self.dataArr = @[@{@"num":@"---"},@{@"num":@"---"},@{@"num":@"---"}];

}
-(MineHeadView*)headView{
    if (!_headView) {
        _headView = [[MineHeadView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 246)]; //260
        _headView.delegate = self;
    }
    return _headView;
}


-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-kNavAndTabHeight) style:UITableViewStyleGrouped];
        _myTableView.backgroundColor =CViewBgColor;
        _myTableView.dataSource =self;
        _myTableView.delegate = self;
        _myTableView.estimatedRowHeight = 0;
        _myTableView.estimatedSectionHeaderHeight = 0;
        _myTableView.estimatedSectionFooterHeight = 0;
        _myTableView.showsVerticalScrollIndicator=NO;
        [_myTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        [_myTableView registerNib:[UINib nibWithNibName:@"CoinListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CoinListCell"];
        [_myTableView registerNib:[UINib nibWithNibName:@"MineListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineListCell"];
        [_myTableView registerClass:[LikeTableViewCell class] forCellReuseIdentifier:@"cell"];
        if (@available(iOS 11.0, *))
        {
            _myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _myTableView;
}


#pragma mark -- UITableViewDelegate & dataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return iconArr.count;
    if (section==0) {
        return 3;
    }
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        return 115;
    }
    return 49;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        NSArray *iconA = @[@"star-coin",@"stl-coin",@"bsc_icon"];
        NSArray *nameA = @[@"STAR",@"STL",@"BNB"];
        CoinListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CoinListCell"];
        cell.contentView.backgroundColor = CViewBgColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.iconV.image = MYIMAGE(iconA[indexPath.row]);
        cell.nameL.text = nameA[indexPath.row];
        if (closeStatus) {
            cell.valueL.text = @"***";
        }else{
            if (indexPath.row==0) {
                cell.valueL.text = self.STARSTR;
            }else if (indexPath.row==2){
                cell.valueL.text = self.BNBSTR;
            }else{
                cell.valueL.text = self.STLSTR;

            }
    //        cell.valueL.text = balanceArr[indexPath.row];
        }
        return cell;
    }else if (indexPath.section==1){
        LikeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.contentView.backgroundColor = CViewBgColor;
        [cell setViewWithData:self.dataArr];
        return cell;
    }else{
        MineListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineListCell"];
        cell.contentView.backgroundColor = CViewBgColor;
        if (indexPath.section==3) {
            cell.subTitles.hidden = YES;
            cell.titleLabs.text = NSLocalizedString(@"邀請獎勵", nil);
            cell.leftImg.image = [UIImage imageNamed:@"invite"];

        }else{
            cell.leftImg.image = [UIImage imageNamed:@"mine7"];

            cell.subTitles.hidden = NO;
            cell.titleLabs.text = NSLocalizedString(@"语言", nil);

            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"myLanguage"]hasPrefix:@"en"]) {
                cell.subTitles.text  = @"English";
            }else{
                cell.subTitles.text  = @"中文";
            }

        }
     
        return cell;

    }
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 6;
    }else if(section==1){
        return 12;
    }
    return  8;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section==0){
        UIView *bgv  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 12)];
        UIView *view  = [[UIView alloc]initWithFrame:CGRectMake(25, 0, KScreenWidth-50, 12)];
        view.backgroundColor = kUIColorFromRGB(0x11171C);
        [bgv addSubview:view];
        return bgv;
    }else{
        return nil;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return  0.01;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 120)];
    UIView *bgv = [[UIView alloc]initWithFrame:CGRectMake(25, 0, KScreenWidth-50, 105)];
    bgv.backgroundColor = kUIColorFromRGB(0x11171C);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth-50, 105)
                                                       byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight
                                                             cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame =bgv.bounds;
    maskLayer.path = maskPath.CGPath;
    bgv.layer.mask = maskLayer;
    UIView *bgv1 = [[UIView alloc]initWithFrame:CGRectMake(3, 0, bgv.width-6, 47)];
    bgv1.backgroundColor = kUIColorFromRGB(0x1E2934);
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, bgv.width-6, 47)
                                                       byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight|UIRectCornerTopLeft|UIRectCornerTopRight
                                                             cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame =bgv1.bounds;
    maskLayer1.path = maskPath1.CGPath;
    bgv1.layer.mask = maskLayer1;
    [view addSubview:bgv];
    [bgv addSubview:bgv1];
    
    UIImageView *dotV = [Tool createImageViewWithFrame:CGRectMake((bgv1.width-24)/2, (bgv1.height-6)/2, 24, 6) image:MYIMAGE(@"dot1_icon") placeholderImge:nil];
    [bgv1 addSubview:dotV];
    UILabel *title = [Tool createLabelWithFrame:CGRectMake(0, bgv1.bottom, KScreenWidth-50, 25) textColor:[UIColor whiteColor] textFont:MYFONT(12) textAligion:NSTextAlignmentCenter labelText:@"Don't see your token？"];
    [bgv addSubview:title];
    UIButton *addBtn = [Tool createButtonWithFrame:CGRectMake((bgv.width-95)/2, title.bottom, 95, 24) title:@"添加代币" titleColor:kUIColorFromRGB(0x363B3E) textFont:MYFONT(12) backgroudColor:nil target:self action:@selector(addCoinAction)];
    UIImage *bg = [UIColor gradientImageWithView:addBtn fromColor:@"#C8AC7C" toColor:@"#F9EFBC" startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) cornerRadius:5];
    addBtn.backgroundColor = [UIColor colorWithPatternImage:bg];
    [bgv addSubview:addBtn];
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
//    if (indexPath.section == 2) {//邀请
//        MyInviteVC *invite = [[MyInviteVC alloc]init];
//        [self.navigationController pushViewController:invite animated:YES];
//
//    }else
    if (indexPath.section==2){
        MineListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [self laungeChangeAction:cell.subTitles];
    }else{
        return;;
    }
}
- (void)changeLanguageTo:(NSString *)language {
    // 设置语言
    [NSBundle setLanguage:language];
    
    // 然后将设置好的语言存储好，下次进来直接加载
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:@"myLanguage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // 我们要把系统windown的rootViewController替换掉
    RootTabBarViewController *VC = [[RootTabBarViewController alloc]init];
    UIWindow *window =  [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    window.rootViewController = VC;
    // 跳转到设置页
    VC.selectedIndex = 3;
}
//-(void)chineseAction{
////    [self.laugageChangeView removeFromSuperview];
////    self.laugageChangeView = nil;
//    [self changeLanguageTo:@"zh-Hans"];
//}
//-(void)englishAction{
////    [self.laugageChangeView removeFromSuperview];
////    self.laugageChangeView = nil;
//    [self changeLanguageTo:@"en"];
//}

-(void)addCoinAction{
    AddCoinVC *vc = [AddCoinVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark MineHeadViewDelegate
-(void)hidenDataAction:(BOOL)value{
    if (value) { //close
        closeStatus = YES;
    }else{
        closeStatus = NO;
    }
    [self.myTableView reloadData];
}
-(void)headSetAction{
    if ([UserInfoConfig shareManager].address.length==0) {
        return;
    }
    WalletManageVC *vc= [WalletManageVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)headSendAction{
//    [self.view showToastWithText:NSLocalizedString(@"开发中", nil)];
    if ([UserInfoConfig shareManager].address.length==0) {
        return;
    }
    WalletSendVC *vc= [WalletSendVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)headRecvAction{
    if ([UserInfoConfig shareManager].address.length==0) {
        return;
    }
    WalletRecvVC *vc= [WalletRecvVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)headMoreAction{
    if ([UserInfoConfig shareManager].address.length==0) {
        return;
    }
    WalletInfoVC *vc= [WalletInfoVC new];
    vc.deletate = self;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark WalletInfoVCDelegate
-(void)backToUpdateUser{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistpath = [paths objectAtIndex:0];
    NSLog(@"path = %@",plistpath);
    NSString *filename=[plistpath stringByAppendingPathComponent:@"/account.txt"];
    NSArray *oldArr = @[];
    oldArr = [NSArray arrayWithContentsOfFile:filename];
    if (oldArr.count == 0 ) {
        UserInfoModel *model = [UserInfoModel new];
        model.address = @"";
        model.pass = @"";
        model.publickKey = @"";
        model.privteKey = @"";
        model.mnemonics = @"";
        [[UserInfoConfig shareManager]saveUserInfo:model];
        self.STLSTR = @"0";
        self.STARSTR = @"0";
        self.BNBSTR = @"0";
        [self.myTableView reloadData];
    }else{
        NSDictionary *dic = oldArr[0];
        UserInfoModel *model = [UserInfoModel new];
        model = [UserInfoModel mj_objectWithKeyValues:dic];
        [[UserInfoConfig shareManager]saveUserInfo:model];
        self.headView.nameL.text = [UserInfoConfig shareManager].address;
        [self requestData]; //卡片
        self.STARSTR = @"--";
        self.STLSTR = @"--";
        self.BNBSTR = @"--";
        [self.myTableView reloadData];
        // 余额
        if ([UserInfoConfig shareManager].address.length>0) {
            [self getBanlanceData];
        }
    }
    
}

-(void)laungeChangeAction:(UILabel*)sender{
    [YBPopupMenu showRelyOnView:sender titles:@[NSLocalizedString(@"中文", nil),NSLocalizedString(@"英文", nil)] icons:@[] menuWidth:95 delegate:self];
}
#pragma mark YBPopupMenuDelegate
- (void)ybPopupMenu:(YBPopupMenu *)ybPopupMenu didSelectedAtIndex:(NSInteger)index
{
    //推荐回调
    if (index == 0) {
        [self changeLanguageTo:@"zh-Hans"];
//        [self.footView.changeBtn setTitle:@"中文" forState:UIControlStateNormal];
    }else{
        [self changeLanguageTo:@"en"];

    }
}

-(void)requestData{
    NSDictionary *dic = @{@"address":[UserInfoConfig shareManager].address};
    [[CSNetworkTool shareManager]postMethodName:URL_getCardCount parameter:dic images:nil success:^(id responseObject, BOOL loadSuccess) {
        if (loadSuccess) {
            NSArray *arr = [responseObject objectForKey:@"data"];
            self.dataArr = arr;
            [self.myTableView reloadData];

            
        }else{
            [self.view showHUDWithText:responseObject[@"msg"]];
        }
     
    } failure:^(NSError *error) {

   }];
    
}
@end
