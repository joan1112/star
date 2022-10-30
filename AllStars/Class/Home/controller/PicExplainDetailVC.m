//
//  PicExplainDetailVC.m
//  AllStars
//
//  Created by Mac on 2021/10/13.
//

#import "PicExplainDetailVC.h"
#import "PicDetailView.h"

@interface PicExplainDetailVC ()
@property(nonatomic,strong)UIView *customNav;
@property(nonatomic,strong)PicDetailView *contentV;
@end

@implementation PicExplainDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view addSubview:self.customNav];
    
    [self.view addSubview:self.contentV];
    
}
-(PicDetailView*)contentV{
    if (!_contentV) {
        _contentV = [[[NSBundle mainBundle]loadNibNamed:@"PicDetailView" owner:self options:nil]firstObject];
        _contentV.frame = CGRectMake(0, kNavBarAndStatusBarHeight, KScreenWidth, KScreenHeight-kNavBarAndStatusBarHeight);
    }
    return _contentV;
}
-(UIView*)customNav{
    if (!_customNav) {
        _customNav = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth,kNavBarAndStatusBarHeight)];
        _customNav.backgroundColor = CNavBgColor;
        UILabel *titleL = [Tool createLabelWithFrame:CGRectMake(100, BottomSafeH+20, KScreenWidth-200, 40) textColor:[UIColor whiteColor] textFont:MYFONT(17) textAligion:NSTextAlignmentCenter labelText:@"成吉思汗"];
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

@end
