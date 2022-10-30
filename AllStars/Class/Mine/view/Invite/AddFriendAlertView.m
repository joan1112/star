//
//  AddFriendAlertView.m
//  AllStars
//
//  Created by junqiang on 2022/3/7.
//

#import "AddFriendAlertView.h"
@interface AddFriendAlertView()
@property (nonatomic, strong) UIView *superView;
@property (nonatomic,assign)NSInteger type;//0 添加好友 1 绑定好友 2 邀请好友

@end
@implementation AddFriendAlertView


-(instancetype)initWithFrame:(CGRect)frame withType:(NSInteger)type
{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
        if (type==0) {
            [self createUI];

        }else{
            [self creatShare];

        }
    }
    
    return self;
}
-(void)createUI
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.superView];
    self.superView.frame = window.frame;
    [self.superView addSubview:self];
    
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = kUIColorFromRGB(0x272E49);
    bgView.layer.borderWidth = 1;
    bgView.layer.borderColor = kUIColorFromRGB(0x4A59FF).CGColor;
    bgView.layer.cornerRadius = 8;
    bgView.layer.masksToBounds = YES;
    bgView.userInteractionEnabled = YES;
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.mas_equalTo(KScreenWidth-35);
    }];
    
    UILabel *titLab = [[UILabel alloc]init];
    [bgView addSubview:titLab];
    titLab.textColor = [UIColor whiteColor];
    titLab.font = [UIFont systemFontOfSize:16];
    titLab.textAlignment = NSTextAlignmentCenter;
    titLab.text = @"添加好友";
    
    [titLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(15);
        make.right.equalTo(bgView.mas_right).offset(-15);
        make.height.mas_equalTo(45);
    }];
    
    UILabel *tipLab = [[UILabel alloc]init];
    [bgView addSubview:tipLab];
    tipLab.textColor = kUIColorFromRGB(0x007AFF);
    tipLab.font = [UIFont systemFontOfSize:13];
    tipLab.textAlignment = NSTextAlignmentCenter;
    tipLab.text = @"输入好友地址";
//    gameClose
    
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titLab.mas_bottom).offset(30);
        make.left.equalTo(bgView.mas_left).offset(15);
        make.height.mas_equalTo(25);
    }];
    
    UIView *inputBg = [[UIView alloc]init];
    [bgView addSubview:inputBg];
    inputBg.layer.borderColor = kUIColorFromRGB(0x007AFF).CGColor;
    inputBg.backgroundColor = kUIColorFromRGB(0x040827);
    inputBg.layer.borderWidth = .8;
    [inputBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipLab.mas_bottom).offset(0);
        make.left.equalTo(bgView.mas_left).offset(15);
        make.height.mas_equalTo(45);
        make.right.equalTo(bgView.mas_right).offset(-15);
    }];
    
    UITextField *addressTf = [[UITextField alloc]init];
    [inputBg addSubview:addressTf];
    addressTf.placeholder = @"请输入地址";
    addressTf.textColor = UIColor.whiteColor;
    [addressTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(inputBg.mas_top).offset(0);
        make.left.equalTo(inputBg.mas_left).offset(15);
        make.height.mas_equalTo(45);
        make.right.equalTo(inputBg.mas_right).offset(-50);
    }];
    
    UIImageView *addressTipImg = [[UIImageView alloc]init];
    addressTipImg.image = [UIImage imageNamed:@"true"];
    [inputBg addSubview:addressTipImg];
    
    [addressTipImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(inputBg.mas_top).offset(10);
        make.right.equalTo(inputBg.mas_right).offset(-10);
        make.height.width.mas_equalTo(25);
    }];
    

    
    UILabel *wrongTip = [[UILabel alloc]init];
    [bgView addSubview:wrongTip];
    wrongTip.textColor = CBlueColor;
    wrongTip.font = [UIFont systemFontOfSize:10];
    wrongTip.textAlignment = NSTextAlignmentLeft;
    wrongTip.text = @"地址无效，请输入正确地址";
    
    [wrongTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(inputBg.mas_bottom).offset(5);
        make.left.equalTo(bgView.mas_left).offset(15);
       
    }];
    UILabel *desLab = [[UILabel alloc]init];
    [bgView addSubview:desLab];
    desLab.textColor = kUIColorFromRGB(0x464D85);
    desLab.font = [UIFont systemFontOfSize:12];
    desLab.textAlignment = NSTextAlignmentLeft;
    desLab.text = @"輸入對方錢包地址，並稱爲妳的好友";
    
    [desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wrongTip.mas_bottom).offset(5);
        make.left.equalTo(bgView.mas_left).offset(15);
      
    }];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.backgroundColor = kUIColorFromRGB(0x13194A);
    [bgView addSubview:cancelBtn];
    [cancelBtn setTitleColor:kUIColorFromRGB(0x007AFF) forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.layer.cornerRadius = 20;
    cancelBtn.layer.masksToBounds = YES;
    cancelBtn.layer.borderWidth = 1;
    cancelBtn.layer.borderColor = kUIColorFromRGB(0x007AFF).CGColor;
    
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bgView.mas_bottom).offset(-25);
        make.left.equalTo(bgView.mas_left).offset(15);
        make.width.mas_equalTo((KScreenWidth-90)/2);
        make.height.mas_equalTo(40);
    }];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(15, 160,280, 40);
    confirmBtn.backgroundColor = kUIColorFromRGB(0x007AFF);
    [bgView addSubview:confirmBtn];
    [confirmBtn setTitle:@"添加" forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    confirmBtn.layer.cornerRadius = 20;
    confirmBtn.layer.masksToBounds = YES;
    

    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bgView.mas_bottom).offset(-25);
        make.right.equalTo(bgView.mas_right).offset(-15);
        make.width.mas_equalTo((KScreenWidth-90)/2);
        make.height.mas_equalTo(40);
    }];
}
-(void)creatShare
{
//    code_icon
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.superView];
    self.superView.frame = window.frame;
    [self.superView addSubview:self];
    
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = kUIColorFromRGB(0x272E49);
    bgView.layer.borderWidth = 1;
    bgView.layer.borderColor = kUIColorFromRGB(0x4A59FF).CGColor;
    bgView.layer.cornerRadius = 8;
    bgView.layer.masksToBounds = YES;
    bgView.userInteractionEnabled = YES;
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.mas_equalTo(KScreenWidth-35);
    }];
    
    UILabel *titLab = [[UILabel alloc]init];
    [bgView addSubview:titLab];
    titLab.textColor = [UIColor whiteColor];
    titLab.font = [UIFont systemFontOfSize:16];
    titLab.textAlignment = NSTextAlignmentCenter;
    titLab.text = @"邀请好友";
    
    [titLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(15);
        make.right.equalTo(bgView.mas_right).offset(-15);
        make.height.mas_equalTo(45);
    }];
    
    UILabel *tipLab = [[UILabel alloc]init];
    [bgView addSubview:tipLab];
    tipLab.textColor = kUIColorFromRGB(0x007AFF);
    tipLab.font = [UIFont systemFontOfSize:13];
    tipLab.textAlignment = NSTextAlignmentCenter;
    tipLab.text = @"邀请链接:";
//    gameClose
    
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titLab.mas_bottom).offset(30);
        make.left.equalTo(bgView.mas_left).offset(15);
        make.height.mas_equalTo(25);
    }];
    
    UIView *inputBg = [[UIView alloc]init];
    [bgView addSubview:inputBg];
    inputBg.userInteractionEnabled = YES;
    inputBg.layer.borderColor = kUIColorFromRGB(0x007AFF).CGColor;
    inputBg.backgroundColor = kUIColorFromRGB(0x040827);
    inputBg.layer.borderWidth = .8;
    [inputBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipLab.mas_bottom).offset(0);
        make.left.equalTo(bgView.mas_left).offset(15);
        make.height.mas_equalTo(45);
        make.right.equalTo(bgView.mas_right).offset(-15);
    }];
    
    UITextField *addressTf = [[UITextField alloc]init];
    [inputBg addSubview:addressTf];
    addressTf.text = @"http://192.168.2.4/address";
    addressTf.userInteractionEnabled = NO;
    addressTf.textColor = UIColor.whiteColor;
    [addressTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(inputBg.mas_top).offset(0);
        make.left.equalTo(inputBg.mas_left).offset(15);
        make.height.mas_equalTo(45);
        make.right.equalTo(inputBg.mas_right).offset(-50);
    }];
    
    UIButton *addressTipImg = [UIButton buttonWithType:UIButtonTypeCustom];
    [addressTipImg setImage:[UIImage imageNamed:@"copy_icon"] forState:UIControlStateNormal];
    [inputBg addSubview:addressTipImg];

    [addressTipImg addTarget:self action:@selector(copyAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [addressTipImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(inputBg.mas_top).offset(10);
        make.right.equalTo(inputBg.mas_right).offset(-10);
        make.height.width.mas_equalTo(25);
    }];
    
    UILabel *desLab = [[UILabel alloc]init];
    [bgView addSubview:desLab];
    desLab.textColor = kUIColorFromRGB(0x464D85);
    desLab.font = [UIFont systemFontOfSize:12];
    desLab.textAlignment = NSTextAlignmentLeft;
    desLab.text = @"發送該鏈接到妳將邀請的人，對方填入信息後即可稱爲妳的會好友";
    desLab.numberOfLines = 0;
    [desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(inputBg.mas_bottom).offset(5);
        make.left.equalTo(bgView.mas_left).offset(15);
        make.right.equalTo(bgView.mas_right).offset(15);
      
    }];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(15, 160,280, 40);
    shareBtn.backgroundColor = kUIColorFromRGB(0x13194A);
    [bgView addSubview:shareBtn];
    [shareBtn setTitle:@" 分享海报" forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"code_icon"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.layer.cornerRadius = 20;
    shareBtn.layer.masksToBounds = YES;
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bgView.mas_bottom).offset(-90);
        make.centerX.equalTo(bgView.mas_centerX);
        make.width.mas_equalTo((KScreenWidth-90)/2);
        make.height.mas_equalTo(40);
    }];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.backgroundColor = kUIColorFromRGB(0x13194A);
    [bgView addSubview:cancelBtn];
    [cancelBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.layer.cornerRadius = 20;
    cancelBtn.layer.masksToBounds = YES;
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13];


    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bgView.mas_bottom).offset(-25);
        make.centerX.equalTo(bgView.mas_centerX);
        make.width.mas_equalTo((KScreenWidth-90)/2);
        make.height.mas_equalTo(40);
    }];
    
    
}

-(void)copyAction
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = @"http://192.168.2.4/address";
    [self showToastWithText:NSLocalizedString(@"复制成功", nil)];
   
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
