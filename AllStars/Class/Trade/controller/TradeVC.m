//
//  TradeVC.m
//  AllStars
//
//  Created by Mac on 2021/10/9.
//

#import "TradeVC.h"
#import "TradeListCell.h"
#import "SaleVC.h"
#import "RetrieveVC.h"
#import "ProjectListModel.h"

@interface TradeVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation TradeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"交易大厅", nil);
    self.dataArr = @[].mutableCopy;
    [self.view addSubview:self.myTableView];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    [self requestData];
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
        [_myTableView registerClass:[TradeListCell class] forCellReuseIdentifier:@"TradeListCell"];
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
    return 105;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TradeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TradeListCell"];
    if (!cell) {
        cell = [[TradeListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"TradeListCell"];
    }
    ProjectListModel *model = self.dataArr[indexPath.row];
    cell.titleL.text = model.name;
    cell.contentL.text = model.desc;
//    [cell.coverV sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
    if (indexPath.row == 0) {
        cell.coverV.image = MYIMAGE(@"paiMai");
    }else{
        cell.coverV.image = MYIMAGE(@"huiShou");
    }
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
    [self.view showToastWithText:@"开发中" afterDelay:0];
//    if (indexPath.row == 0) {
//        SaleVC *vc = [SaleVC new];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//    if (indexPath.row == 1) {
//        RetrieveVC *vc = [RetrieveVC new];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    
}

-(void)requestData{
    [[CSNetworkTool shareManager]postMethodName:URL_projectList parameter:@{@"tab":@"TRADE"} images:nil success:^(id responseObject, BOOL loadSuccess) {
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
@end
