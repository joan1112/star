//
//  SaleVC.m
//  AllStars
//
//  Created by Mac on 2021/10/14.
//

#import "SaleVC.h"

@interface SaleVC ()

@end

@implementation SaleVC{
    UIButton *goodsBtn;
    UIButton *auctionBtn;
    UIButton *NFTBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"拍卖行";
    [self loadSubView];
}

-(void)loadSubView{
    UIView *bgv = [[UIView alloc]initWithFrame:CGRectMake(60, 15, (KScreenWidth-120), 34)];
    bgv.backgroundColor = kUIColorFromRGB(0x4F5C6F);
    bgv.layer.cornerRadius = 5;
    bgv.layer.masksToBounds = YES;
    [self.view addSubview:bgv];
    
    goodsBtn = [Tool createButtonWithFrame:CGRectMake(3, 3, (bgv.width-12)/3, 28) title:@"商品" titleColor:[UIColor whiteColor] textFont:MYFONT(13) backgroudColor:[UIColor clearColor] target:self action:@selector(goodsAction)];
    goodsBtn.layer.cornerRadius = 5;
    goodsBtn.layer.masksToBounds = YES;
    [bgv addSubview:goodsBtn];
    
    auctionBtn = [Tool createButtonWithFrame:CGRectMake(goodsBtn.right+3, 3, (bgv.width-12)/3, 28) title:@"竞拍" titleColor:[UIColor whiteColor] textFont:MYFONT(13) backgroudColor:[UIColor clearColor] target:self action:@selector(goodsAction)];
    auctionBtn.layer.cornerRadius = 5;
    auctionBtn.layer.masksToBounds = YES;
    [bgv addSubview:auctionBtn];
    
    NFTBtn = [Tool createButtonWithFrame:CGRectMake(auctionBtn.right+3, 3, (bgv.width-12)/3, 28) title:@"我的NFT" titleColor:[UIColor whiteColor] textFont:MYFONT(13) backgroudColor:[UIColor clearColor] target:self action:@selector(goodsAction)];
    NFTBtn.layer.cornerRadius = 5;
    NFTBtn.layer.masksToBounds = YES;
    [bgv addSubview:NFTBtn];
}
-(void)goodsAction{
    
}
@end
