//
//  MyCollectVC.m
//  AllStars
//
//  Created by Mac on 2021/10/13.
//

#import "MyCollectVC.h"
#import "MyCollectListCell.h"

@interface MyCollectVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)UIView *headV;
@property(nonatomic,strong)UILabel *countL;
@end

@implementation MyCollectVC{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的收藏";
    [self.view addSubview:self.myTableView];
    self.myTableView.tableHeaderView = self.headV;

}

-(UIView*)headV{
    if (!_headV) {
        _headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 42)];
        UILabel *titleL = [Tool createLabelWithFrame:CGRectMake(15, 0, 200, 42) textColor:kUIColorFromRGB(0xffffff) textFont:MYFONT(13) textAligion:NSTextAlignmentLeft labelText:@"我的NFT收藏"];
        [_headV addSubview:titleL];
        _countL= [Tool createLabelWithFrame:CGRectMake(KScreenWidth-215, 0, 200, 42) textColor:CLineColor textFont:MYFONT(13) textAligion:NSTextAlignmentRight labelText:@"9999个"];
        [_headV addSubview:_countL];
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
        //        [_myTableView registerNib:[UINib nibWithNibName:@"CreateListPopCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CreateListPopCell"];
        [_myTableView registerClass:[ MyCollectListCell class] forCellReuseIdentifier:@"MyCollectListCell"];
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
    return 2;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCollectListCell"];
    if (!cell) {
        cell = [[MyCollectListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MyCollectListCell"];
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
    
}
@end
