//
//  WalletManageVC.m
//  AllStars
//
//  Created by Mac on 2021/11/8.
//

#import "WalletManageVC.h"
#import "WalletListCell.h"
#import "VerifyPassWordVC.h"
#import "PassWordSetVC.h"
#import "AddressListModel.h"
#import "CreatWalletPopView.h"

@interface WalletManageVC ()<UITableViewDelegate,UITableViewDataSource,CreateWalletPopViewDelegate>
@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)UIView *headV;
@property(nonatomic,strong)UIView *footV;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic, strong) CreatWalletPopView *creatWalletView;
@property(nonatomic,assign)NSInteger selectIndex;

@end

@implementation WalletManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"钱包管理", nil);
    self.dataArr = @[].mutableCopy;
    [self.view addSubview:self.myTableView];
    self.myTableView.tableHeaderView = self.headV;
    self.myTableView.tableFooterView = self.footV;

    [self updateData];
}

-(void)updateData{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistpath = [paths objectAtIndex:0];
    NSLog(@"path = %@",plistpath);
    NSString *filename=[plistpath stringByAppendingPathComponent:@"/account.txt"];
    NSArray *oldArr = @[];
    oldArr = [NSArray arrayWithContentsOfFile:filename];
    for (NSDictionary *dic in oldArr) {
        AddressListModel *model = [AddressListModel new];
        model = [AddressListModel  mj_objectWithKeyValues:dic];
        NSString *str= [[NSUserDefaults standardUserDefaults] objectForKey:@"address"];
        if ([model.address isEqualToString:str]) {
            model.selected = @"1";
        }else{
            model.selected = @"0";
        }
        [self.dataArr addObject:model];
    }
    [self.myTableView reloadData];
}

-(UIView*)footV{
    if (!_footV) {
        _footV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 72)];
        UIButton *addBtn = [Tool createButtonWithFrame:CGRectMake(35, 20, KScreenWidth-70, 52) title:NSLocalizedString(@"添加钱包", nil) titleColor:[UIColor whiteColor] textFont:MYFONT(18) backgroudColor:CNavBgColor target:self action:@selector(addWalletAction)];
        addBtn.layer.cornerRadius = 5;
        addBtn.layer.masksToBounds = YES;
        [_footV addSubview:addBtn];
    }
    return _footV;
}
-(UIView*)headV{
    if (!_headV) {
        _headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 65)];
        UIImageView *iconV = [Tool createImageViewWithFrame:CGRectMake(18, 10, 32, 32) image:MYIMAGE(@"bsc_icon") placeholderImge:nil];
        [_headV addSubview:iconV];
        UILabel *titleL= [Tool createLabelWithFrame:CGRectMake(iconV.right+10, 10, 200, 32) textColor:CLineColor textFont:MYFONT(18) textAligion:NSTextAlignmentLeft labelText:@"BSC"];
        [_headV addSubview:titleL];
    }
    return _headV;
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
        [_myTableView registerNib:[UINib nibWithNibName:@"WalletListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WalletListCell"];
//        [_myTableView registerClass:[ MyCollectListCell class] forCellReuseIdentifier:@"MyCollectListCell"];
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
    return self.dataArr.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WalletListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WalletListCell"];
    cell.contentView.backgroundColor = CViewBgColor;
    AddressListModel *model = self.dataArr[indexPath.row];
    cell.titleL.text = model.address;
    if (model.selected.intValue == 1) {
        cell.chooseV.hidden = NO;
        cell.bgv.layer.borderColor = CLineColor.CGColor;
        cell.bgv.layer.borderWidth = 1;
    }else{
        cell.chooseV.hidden = YES;
        cell.bgv.layer.borderColor = CViewBgColor.CGColor;
        cell.bgv.layer.borderWidth = 1;
    }
    [cell.coBtn addTarget:self action:@selector(copyAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.coBtn.tag = 1000+indexPath.row;
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
//    AddressListModel *model = self.dataArr[indexPath.row];
//    if ([model.selected isEqualToString:@"0"]) {
//
//    }else{
//        return;
//    }
    [self.dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (indexPath.row == idx) {
           
            AddressListModel *model = obj;
            if ([model.selected isEqualToString:@"0"]) {
                //更新当前用户
                model.selected = @"1";
                UserInfoModel *newModel = [UserInfoModel new];
                newModel.pass = model.pass;
                newModel.address = model.address;
                newModel.privteKey = model.privteKey;
                newModel.publickKey = model.publickKey;
                newModel.mnemonics = model.mnemonics;
                [[UserInfoConfig shareManager]saveUserInfo:newModel];
                [UserInfoConfig shareManager].STARSTR = @"--";
                [UserInfoConfig shareManager].STLSTR = @"--";
                [UserInfoConfig shareManager].BNBSTR = @"--";

                [self.view showToastWithText:NSLocalizedString(@"切換成功", nil)];
//                [self.dataArr replaceObjectAtIndex:idx withObject:model];
            }else{
                return;
            }
                    
          
        }else{
            AddressListModel *model = obj;
            model.selected = @"0";
            [self.dataArr replaceObjectAtIndex:idx withObject:model];
        }
    }];
    [self.myTableView reloadData];
}
-(void)copyAction:(UIButton*)btn{
    AddressListModel *model = self.dataArr[btn.tag-1000];
    [self.view showToastWithText:NSLocalizedString(@"复制成功", nil)];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = model.address;
}
-(void)addWalletAction{
    
    self.creatWalletView = [[CreatWalletPopView alloc]initWithFrame:CGRectMake(35, (KScreenHeight-300)/2, KScreenWidth-70, 300)];
    self.creatWalletView.delegate = self;
    [self.creatWalletView showPopView];

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
@end
