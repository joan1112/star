//
//  InvitePopSuccessView.m
//  AllStars
//
//  Created by junqiang on 2022/3/7.
//

#import "InvitePopSuccessView.h"
@interface InvitePopSuccessView()
@property (nonatomic, strong) UIView *superView;
@property (nonatomic, copy) NSString *msg;

@end
@implementation InvitePopSuccessView

-(instancetype)initWithFrame:(CGRect)frame withMsg:(nonnull NSString *)msg
{
    self = [super initWithFrame:frame];
    if (self) {
        self.msg = msg;
        [self createUI];
    }
    
    return self;
}
-(void)createUI
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.superView];
    self.superView.frame = window.frame;
    [self.superView addSubview:self];
    
    UIImageView *bgImg = [[UIImageView alloc]init];
    bgImg.image = [UIImage imageNamed:@"invite_success"];
    [self addSubview:bgImg];
    bgImg.userInteractionEnabled = YES;
    [bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(18);
        make.right.equalTo(self.mas_right).offset(-18);
        make.height.mas_equalTo(KScreenWidth-36);
    }];
    
    UILabel *desLab = [[UILabel alloc]init];
    [bgImg addSubview:desLab];
    desLab.textColor = [UIColor whiteColor];
    desLab.font = [UIFont systemFontOfSize:16];
    desLab.text = self.msg;
    desLab.textAlignment = NSTextAlignmentCenter;
    desLab.numberOfLines = 0;
    [desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgImg.mas_centerY);
        make.left.equalTo(bgImg.mas_left).offset(15);
        make.right.equalTo(bgImg.mas_right).offset(-15);
        make.height.mas_equalTo(80);
    }];
    
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(15, 160,280, 40);
    UIImage *img =  [UIColor gradientImageWithView:confirmBtn fromColor:@"#006BFF " toColor:@"#00F2FF" startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) cornerRadius:20];
    [confirmBtn setBackgroundImage:img forState:UIControlStateNormal];
    [bgImg addSubview:confirmBtn];
    [confirmBtn setTitle:@"Start to make money" forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bgImg.mas_bottom).offset(-15);
        make.centerX.equalTo(bgImg.mas_centerX);
        make.width.mas_lessThanOrEqualTo(280);
        make.height.mas_equalTo(40);
    }];
}

-(void)btnClick:(UIButton*)sender
{
    [self hidePopView];
}
-(void)showPopView
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:.25 animations:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.superView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    } completion:nil];
}
- (void)hidePopView
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:.25 animations:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.superView.alpha = 0.0;
    } completion:^(BOOL finished) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.superView removeFromSuperview];
        strongSelf.superView = nil;
    }];
}
- (UIView *)superView
{
    if (!_superView)
    {
        _superView = [[UIView alloc] init];
    }
    return _superView;
}
@end
