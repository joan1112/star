//
//  GameVC.m
//  AllStars
//
//  Created by Mac on 2021/10/9.
//

#import "GameVC.h"
#import "GameListCell.h"
#import "AllStars-Swift.h"
#import "ProjectListModel.h"
#import "CreatWalletPopView.h"
#import "VerifyPassWordVC.h"
#import "PassWordSetVC.h"
#import "GameWebVC.h"
#import "PopViewInfoModel.h"
#import "PopUpView.h"
#import "GameListModel.h"
/*
{"image":"star_icon",
"title":"星辰魔盒",
"des":"星辰魔盒可以抽奖获得NFT英雄。第一期绝版 60种。期待您的参与！",
"url":""
},
*/
@interface GameVC ()<UITableViewDelegate,UITableViewDataSource,CreateWalletPopViewDelegate,PopUpViewDelegate>
@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic, strong) CreatWalletPopView *creatWalletView;
@property(nonatomic,strong)NSMutableArray *popViewArr;
@property(nonatomic,strong)NSMutableArray *gamesArr;

@end

@implementation GameVC

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CViewBgColor;
    self.dataArr = @[].mutableCopy;
    self.popViewArr = @[].mutableCopy;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    self.navigationItem.title = NSLocalizedString(@"游戏大厅", nil);
    [self.view addSubview:self.myTableView];
    [self requestData];
    [self requestPopViewData];
    
   NSString *path = [[NSBundle mainBundle]pathForResource:@"games" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"00000-=====%@",dic);
    
    self.gamesArr = [GameListModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];

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
        //        [_myTableView registerNib:[UINib nibWithNibName:@"CreateListPopCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CreateListPopCell"];
        [_myTableView registerClass:[GameListCell class] forCellReuseIdentifier:@"GameListCell"];
        if (@available(iOS 11.0, *))
        {
            _myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _myTableView;
}


#pragma mark -- UITableViewDelegate & dataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.gamesArr.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 245;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GameListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GameListCell"];
    if (!cell) {
        cell = [[GameListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"GameListCell"];
    }
//    ProjectListModel *model = self.dataArr[indexPath.row];
//    cell.titleL.text = model.name;
//    cell.contentL.text = model.desc;
//    [cell.coverV sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
    GameListModel *model = self.gamesArr[indexPath.row];
    cell.coverV.image = MYIMAGE(model.image);
    cell.titleL.text = NSLocalizedString(model.title, nil);
    cell.contentL.text = NSLocalizedString(model.des, nil);
//
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  CGFLOAT_MIN;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return  CGFLOAT_MIN;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return  nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0) {
//        if ([UserInfoConfig shareManager].address.length==0) {
//            self.creatWalletView = [[CreatWalletPopView alloc]initWithFrame:CGRectMake(35, (KScreenHeight-300)/2, KScreenWidth-70, 300)];
//            self.creatWalletView.delegate = self;
//            [self.creatWalletView showPopView];
//        }else{
//            DAppWebViewController *vc = [[DAppWebViewController alloc]init];
//            NSString *url;
//            NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"myLanguage"];
//            if ([str hasPrefix:@"zh"]) {
//
//                url = [NSString stringWithFormat:@"%@?sys=ios&lang=ch",magicBox];
//            }else{
//                url = [NSString stringWithFormat:@"%@?sys=ios&lang=en",magicBox];
//            }
//            vc.homepage = url;
//
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//    }else
        if (indexPath.row ==0) {
        if ([UserInfoConfig shareManager].address.length==0) {
            self.creatWalletView = [[CreatWalletPopView alloc]initWithFrame:CGRectMake(35, (KScreenHeight-300)/2, KScreenWidth-70, 300)];
            self.creatWalletView.delegate = self;
            [self.creatWalletView showPopView];
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
        GameListModel *model = self.gamesArr[indexPath.row];
        GameWebVC *vc = [GameWebVC new];
        if ([model.url isEqualToString:@"rush"]) {
            vc.isRotate = @"1";
        }
        vc.urlS = [NSString stringWithFormat:@"%@play/%@",buildBaseUrl,model.url];
        NSLog(@"%@", vc.urlS);
        [self.navigationController pushViewController:vc animated:YES];
        
    }
   
    
}
-(void)requestData{
    [[CSNetworkTool shareManager]postMethodName:URL_projectList parameter:@{@"tab":@"GAME"} images:nil success:^(id responseObject, BOOL loadSuccess) {
//        [self.view hideHUD];
        if (loadSuccess) {
            NSArray *arr = [responseObject objectForKey:@"data"];
            for (NSDictionary *dic in arr) {
                [self.dataArr addObject:[ProjectListModel mj_objectWithKeyValues:dic]];
            }
            [self.myTableView reloadData];
        }else{
//         [ZQProgressHUD showErrorWithTitle:responseObject[@"msg"]];
            [self.view showHUDWithText:responseObject[@"msg"]];
        }
     
    } failure:^(NSError *error) {

   }];
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
                          @"position":@(2)
    };
    
    [[CSNetworkTool shareManager]postMethodName:URL_homePopUp parameter:dic images:nil success:^(id responseObject, BOOL loadSuccess) {
//        [self.view hideHUD];
        if (loadSuccess) {
            NSArray *arr= [responseObject objectForKey:@"data"];
            if (self.popViewArr.count>0) {
                [self.popViewArr removeAllObjects];
            }
            NSMutableArray *newArr = @[].mutableCopy;
            for (NSDictionary *dic in arr) {
                PopViewInfoModel *model = [PopViewInfoModel new];
                model = [PopViewInfoModel mj_objectWithKeyValues:dic];
                [newArr addObject:model];
            }
            self.popViewArr = newArr;
            if (newArr.count==0) {
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
    
    for (PopViewInfoModel *model in arr) {
        PopUpView *view = [[PopUpView alloc ]initWithFrame:CGRectMake((KScreenWidth-235)/2, (KScreenHeight-325)/2, 235, 325)];
        [view.contentV sd_setImageWithURL:[NSURL URLWithString:model.link_img]];
        view.tag = model.ID.intValue+100;
        view.delegate = self;
        [view showPopView];
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
-(void)popUpJumpAction:(NSInteger)index{
    for (PopViewInfoModel *model in self.popViewArr) {
        if (model.ID.intValue == index) {
            GameWebVC *vc = [GameWebVC new];
            vc.urlS = model.link_url;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
@end
