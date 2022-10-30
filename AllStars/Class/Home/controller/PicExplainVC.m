//
//  PicExplainVC.m
//  AllStars
//
//  Created by Mac on 2021/10/12.
//

#import "PicExplainVC.h"
#import "PicExplainListCell.h"
#import "VariableRoundedBorderView.h"
#import "PicExplainDetailVC.h"

@interface PicExplainVC ()<UITableViewDelegate,UITableViewDataSource,PicExplainListCellDelegate>
@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)UIView *customNav;

@end

@implementation PicExplainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.customNav];
    [self.view addSubview:self.myTableView];

    NSString *headStr = @"规则：\n\n1、每1个月为1期，每期50+明星上线。\n\n2、抽到极品明星（金色、橙色）、称号组合明星（例：上帝之鞭），可前往交易大厅-回收站，进行高价回收销售掉。\n\n3、抽到自身无法组合的明星，可前往交易大厅-拍卖行进行拍卖，您也可以通过拍卖行购买明星，进行组合拍卖回收\n\n";
    UIView *headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 200)];
    
    UILabel *headL = [Tool createLabelWithFrame:CGRectMake(15, 20, KScreenWidth-30, 160) textColor:[UIColor whiteColor] textFont:MYFONT(13) textAligion:NSTextAlignmentLeft labelText:headStr];
    headL.numberOfLines = 0;
    [headV addSubview:headL];
    
    self.myTableView.tableHeaderView = headV;
}
-(UIView*)customNav{
    if (!_customNav) {
        _customNav = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth,kNavAndTabHeight)];
        _customNav.backgroundColor = CNavBgColor;
        UILabel *titleL = [Tool createLabelWithFrame:CGRectMake(100, BottomSafeH+20, KScreenWidth-200, 40) textColor:[UIColor whiteColor] textFont:MYFONT(17) textAligion:NSTextAlignmentCenter labelText:@"图鉴说明"];
        UIButton *backBtn = [Tool createButtonWithFrame:CGRectMake(15, BottomSafeH+25, 20, 20) normalImage:MYIMAGE(@"nav_back_white") selectImage:nil target:self action:@selector(backClick)];
//        UIButton *pictureBtn = [Tool createButtonWithFrame:CGRectMake(KScreenWidth-75, BottomSafeH+15, 60, 22) normalImage:MYIMAGE(@"tuJian") selectImage:nil target:self action:@selector(picClick)];
        [_customNav addSubview:backBtn];
        [_customNav addSubview:titleL];
//        [_customNav addSubview:pictureBtn];
    }
    return _customNav;
}
-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}


-(UITableView *)myTableView{
if (!_myTableView) {
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavAndTabHeight, KScreenWidth, KScreenHeight-kNavAndTabHeight) style:UITableViewStyleGrouped];
    _myTableView.backgroundColor =CViewBgColor;
    _myTableView.dataSource =self;
    _myTableView.delegate = self;
    _myTableView.estimatedRowHeight = 0;
    _myTableView.estimatedSectionHeaderHeight = 0;
    _myTableView.estimatedSectionFooterHeight = 0;
    _myTableView.showsVerticalScrollIndicator=NO;
    [_myTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
//    [_myTableView registerNib:[UINib nibWithNibName:@"PicExplainListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PicExplainListCell"];
    [_myTableView registerClass:[PicExplainListCell class] forCellReuseIdentifier:@"PicExplainListCell"];
    if (@available(iOS 11.0, *))
    {
        _myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}
    return _myTableView;
}


#pragma mark -- UITableViewDelegate & dataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PicExplainListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PicExplainListCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
//    if (!cell) {
//        cell = [[PicExplainListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"PicExplainListCell"];
//    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  70;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 70)];
    bgv.backgroundColor  = [UIColor clearColor];
    VariableRoundedBorderView *bgv1 = [[VariableRoundedBorderView alloc]initWithFrame:CGRectMake(15, 20, KScreenWidth-30, 50)];
    bgv1.borderColor = CLineColor;
    bgv1.borderWidth = 1.5;
    bgv1.corners = UIRectCornerTopLeft|UIRectCornerTopRight;
    bgv1.radius = 10;
    bgv1.BD = BorderDirectionTop|BorderDirectionLeft|BorderDirectionRight;
    [bgv1 setNeedsDisplay];
    bgv1.backgroundColor  = kUIColorFromRGB(0x341D11);
    [bgv addSubview:bgv1];
    
    UILabel*titleL = [Tool createLabelWithFrame:CGRectMake(15, 0, 150, 50) textColor:CLineColor textFont:MYFONT(15) textAligion:NSTextAlignmentLeft labelText:@"上帝之鞭"];
    [bgv1 addSubview:titleL];
    
    return bgv;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return  15;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *bgv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 15)];
    bgv.backgroundColor  = [UIColor clearColor];
    VariableRoundedBorderView *bgv1 = [[VariableRoundedBorderView alloc]initWithFrame:CGRectMake(15, 0, KScreenWidth-30, 15)];
    bgv1.borderColor = CLineColor;
    bgv1.borderWidth = 1.5;
    bgv1.corners = UIRectCornerBottomLeft|UIRectCornerBottomRight;
    bgv1.radius = 10;
    bgv1.BD = BorderDirectionBottom|BorderDirectionLeft|BorderDirectionRight;
    [bgv1 setNeedsDisplay];
    bgv1.backgroundColor  = kUIColorFromRGB(0x341D11);
    [bgv addSubview:bgv1];
    return bgv;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma mark mark PicExplainListCellDelegate
-(void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PicExplainDetailVC *vc = [PicExplainDetailVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
