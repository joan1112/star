//
//  MagicBoxVC.m
//  AllStars
//
//  Created by Mac on 2021/10/12.
//

#import "MagicBoxVC.h"
#import "BuyBoxView.h"
#import "RuleDetailView.h"
#import "BuyResultView.h"
#import "PicExplainVC.h"
@interface MagicBoxVC ()
@property(nonatomic,strong)UIView *customNav;
@property(nonatomic,strong)BuyBoxView *buyView;
@property(nonatomic,strong)RuleDetailView *ruleDetailView;
@property(nonatomic,strong)BuyResultView *buyResultView;
@end

@implementation MagicBoxVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CViewBgColor;
    UIImageView *view = [Tool createImageViewWithFrame:self.view.bounds image:MYIMAGE(@"bg") placeholderImge:nil];
    UIImageView *boxView = [Tool createImageViewWithFrame:CGRectMake(30, kNavBarAndStatusBarHeight+100, KScreenWidth-60, KScreenWidth-60) image:MYIMAGE(@"moFang") placeholderImge:nil];
    boxView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:view];
    [self.view addSubview:boxView];
    [self.view addSubview:self.customNav];
    [self.view addSubview:self.buyView];
    
}

-(UIView*)customNav{
    if (!_customNav) {
        _customNav = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth,kNavBarAndStatusBarHeight)];
        _customNav.backgroundColor = [UIColor clearColor];
        UILabel *titleL = [Tool createLabelWithFrame:CGRectMake(100, BottomSafeH+10, KScreenWidth-200, 40) textColor:[UIColor whiteColor] textFont:MYFONT(17) textAligion:NSTextAlignmentCenter labelText:@"星辰魔盒"];
        UIButton *backBtn = [Tool createButtonWithFrame:CGRectMake(15, BottomSafeH+20, 20, 20) normalImage:MYIMAGE(@"nav_back_white") selectImage:nil target:self action:@selector(backClick)];
        UIButton *pictureBtn = [Tool createButtonWithFrame:CGRectMake(KScreenWidth-75, BottomSafeH+15, 60, 22) normalImage:MYIMAGE(@"tuJian") selectImage:nil target:self action:@selector(picClick)];
        [_customNav addSubview:backBtn];
        [_customNav addSubview:titleL];
        [_customNav addSubview:pictureBtn];
    }
    return _customNav;
}
-(BuyBoxView*)buyView{
    if (!_buyView) {
        _buyView = [[BuyBoxView alloc]initWithFrame:CGRectMake(0, KScreenHeight-250, KScreenWidth, 205)];
        [_buyView.ruleBtn addTarget:self action:@selector(ruleAction) forControlEvents:UIControlEventTouchUpInside];
        [_buyView.buyBtn addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyView;
}
-(RuleDetailView*)ruleDetailView{
    if (!_ruleDetailView) {
        _ruleDetailView = [[[NSBundle mainBundle]loadNibNamed:@"RuleDetailView" owner:self options:nil]firstObject];
    }
    return _ruleDetailView;
}
-(BuyResultView*)buyResultView{
    if (!_buyResultView) {
        _buyResultView = [[[NSBundle mainBundle]loadNibNamed:@"BuyResultView" owner:self options:nil]firstObject];
        [_buyResultView.receiveBtn addTarget:self action:@selector(receiveAction) forControlEvents:UIControlEventTouchUpInside];
        [_buyResultView.againBtn addTarget:self action:@selector(againAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyResultView;
}
-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)picClick{
    PicExplainVC *vc = [PicExplainVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)ruleAction{
    self.ruleDetailView.frame = self.view.bounds;
    [self.view addSubview:self.ruleDetailView];
}
-(void)buyAction{
    self.buyResultView.frame = self.view.bounds;
    [self.view addSubview:self.buyResultView];
}
-(void)receiveAction{
    [self.buyResultView removeFromSuperview];
    self.buyResultView = nil;
}
-(void)againAction{
    [self.buyResultView removeFromSuperview];
    self.buyResultView = nil;
}
@end
