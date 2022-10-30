//
//  CreatWalletPopView.m
//  AllStars
//
//  Created by Mac on 2021/10/29.
//

#import "CreatWalletPopView.h"
#import "UIButton+SGPagingView.h"
#define AnimationTimeInterval 0.25

@interface CreatWalletPopView ()
@property (nonatomic, strong) UIView *superView;

@end

@implementation CreatWalletPopView

#pragma mark -lifeCycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = kUIColorFromRGB(0x1E2934);
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = CLineColor.CGColor;
        self.layer.borderWidth = 1;
        [self createUI];
    }
    return self;
}

- (void)createUI{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.superView];
    self.superView.frame = window.frame;
    
//    UITapGestureRecognizer *tapView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidePopView)];
//    [self.superView addGestureRecognizer:tapView];
    
    [self.superView addSubview:self];
    
    UIButton *button = [Tool createButtonWithFrame:CGRectMake((KScreenWidth-26)/2, self.bottom+20,26, 26) normalImage:MYIMAGE(@"圆角矩形 2") selectImage:nil target:self action:@selector(closeAction)];
    [self.superview addSubview:button];
    
    
    UIView *bgv = [[UIView alloc]initWithFrame:CGRectMake(20, self.height-160, self.width-40, 130)];
    [self addSubview:bgv];
    bgv.backgroundColor = kUIColorFromRGB(0x182029);
    bgv.layer.cornerRadius = 5;
    bgv.layer.masksToBounds = YES;
    
    UIButton *creatBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, bgv.width/2, bgv.height)];
    [creatBtn setImage:MYIMAGE(@"形状 10") forState:UIControlStateNormal];
    [creatBtn setTitle: NSLocalizedString(@"创建钱包", nil) forState:UIControlStateNormal];
    [creatBtn setTitleColor:CLineColor forState:UIControlStateNormal];
    [creatBtn addTarget:self action:@selector(creatAction) forControlEvents:UIControlEventTouchUpInside];
    [creatBtn SG_imagePositionStyle:SGImagePositionStyleTop spacing:15 imagePositionBlock:^(UIButton *button) {
            ;
    }];
    [bgv addSubview:creatBtn];
    
    UIButton *importBtn = [[UIButton alloc]initWithFrame:CGRectMake(bgv.width/2, 0, bgv.width/2, bgv.height)];
    [importBtn setImage:MYIMAGE(@"形状 11") forState:UIControlStateNormal];
    [importBtn setTitle:NSLocalizedString(@"导入钱包", nil) forState:UIControlStateNormal];
    [importBtn setTitleColor:CLineColor forState:UIControlStateNormal];
    [importBtn addTarget:self action:@selector(importAction) forControlEvents:UIControlEventTouchUpInside];
    [importBtn SG_imagePositionStyle:SGImagePositionStyleTop spacing:15 imagePositionBlock:^(UIButton *button) {
            ;
    }];
    [bgv addSubview:importBtn];
    
    UIButton *button1 = [Tool createButtonWithFrame:CGRectMake(20, self.height-160-27, 86, 27) title:@"BSC" titleColor:CLineColor textFont:MYFONT(12) backgroudColor: kUIColorFromRGB(0x182029)target:self action:nil];
    button1.layer.cornerRadius = 5;
    button1.layer.masksToBounds = YES;
    [button1 setImage:MYIMAGE(@"BNB") forState:UIControlStateNormal];
    [button1 SG_imagePositionStyle:SGImagePositionStyleDefault spacing:10 imagePositionBlock:^(UIButton *button) {
            ;
    }];
    [self addSubview:button1];
    
    UIImageView *iconV = [Tool createImageViewWithFrame:CGRectMake(40, 20, 54, 50) image:MYIMAGE(@"createWallet") placeholderImge:nil];
    iconV.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:iconV];
    
    UILabel *title1= [Tool createLabelWithFrame:CGRectMake(iconV.right+10, 20, 150, 25) textColor:CLineColor textFont:MYFONT(18) textAligion:NSTextAlignmentLeft labelText:NSLocalizedString(@"添加钱包", nil)];
    [self addSubview:title1];
    
    UILabel *title2= [Tool createLabelWithFrame:CGRectMake(iconV.right+10, 45, 100, 25) textColor:kUIColorFromRGB(0xffffff) textFont:MYFONT(12) textAligion:NSTextAlignmentLeft labelText:NSLocalizedString(@"创建或导入", nil)];
    [self addSubview:title2];
    
    
    
}
-(void)closeAction{
    [self hidePopView];
}
-(void)creatAction{
    if ([self.delegate respondsToSelector:@selector(createWalletAction)]) {
        [self.delegate createWalletAction];
    }
}
-(void)importAction{
    if ([self.delegate respondsToSelector:@selector(importWalletAction)]) {
        [self.delegate importWalletAction];
    }
}
#pragma mark -Public

- (void)showPopView
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:AnimationTimeInterval animations:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.superView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    } completion:nil];
}

- (void)hidePopView
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:AnimationTimeInterval animations:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.superView.alpha = 0.0;
    } completion:^(BOOL finished) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.superView removeFromSuperview];
        strongSelf.superView = nil;
    }];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self hidePopView];
}

#pragma mark -Setter/Getter

- (UIView *)superView
{
    if (!_superView)
    {
        _superView = [[UIView alloc] init];
    }
    return _superView;
}

@end
