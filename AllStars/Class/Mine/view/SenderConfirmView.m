//
//  SenderConfirmView.m
//  AllStars
//
//  Created by junqiang on 2022/2/25.
//

#import "SenderConfirmView.h"
#define AnimationTimeInterval 0.25
@interface SenderConfirmView()
@property (nonatomic, strong) UIView *superView;

@end
@implementation SenderConfirmView
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
    
    self.priceLab = [Tool createLabelWithFrame:CGRectMake(20, 20, self.width-40, 50) textColor:[UIColor whiteColor] textFont:MYFONT(17) textAligion:NSTextAlignmentLeft labelText:@"金额：9Star"];
    [self addSubview:self.priceLab];
    
    self.minerFee = [Tool createLabelWithFrame:CGRectMake(20, 50, self.width-40, 50) textColor:[UIColor whiteColor] textFont:MYFONT(17) textAligion:NSTextAlignmentLeft labelText:@"金额：9Star"];
    [self addSubview:self.minerFee];
    
    self.toAddressLab = [Tool createLabelWithFrame:CGRectMake(20, 80, self.width-40, 100) textColor:[UIColor whiteColor] textFont:MYFONT(17) textAligion:NSTextAlignmentLeft labelText:@"地址：0x7006A5cBB278aBF0d93Ac101eA4637848753B0c8"];
    [self addSubview:self.toAddressLab];
    self.toAddressLab.numberOfLines = 0;
    
    UIButton *cancelBtn = [Tool createButtonWithFrame:CGRectMake(20, 240,(self.width-60)/2 , 40) title:NSLocalizedString(@"取消", nil) titleColor:kUIColorFromRGB(0xfffffff) textFont:MYFONT(18) backgroudColor:CNavBgColor target:self action:@selector(hidePopView)];
    [self addSubview:cancelBtn];

    UIButton *confirmBtn = [Tool createButtonWithFrame:CGRectMake(CGRectGetMaxX(cancelBtn.frame)+20, 240,(self.width-60)/2, 40) title:NSLocalizedString(@"确定", nil) titleColor:CNavBgColor textFont:MYFONT(18) backgroudColor:nil target:self action:@selector(copyAction)];
    UIImage *bg = [UIColor gradientImageWithView:confirmBtn fromColor:@"#C8AC7C" toColor:@"#F9EFBC" startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) cornerRadius:5];
    confirmBtn.backgroundColor = [UIColor colorWithPatternImage:bg];
    [self addSubview:confirmBtn];
}
-(void)setPrice:(NSString*)price toAdreee:(NSString*)address withMinerFee:(nonnull NSString *)fee
{
    self.priceLab.text = [NSString stringWithFormat:@"%@：%@",NSLocalizedString(@"金額", nil),price];
    self.minerFee.text = [NSString stringWithFormat:@"%@：%@",NSLocalizedString(@"礦工費", nil),fee];
    self.toAddressLab.text = [NSString stringWithFormat:@"%@：%@",NSLocalizedString(@"發送到", nil),address];
}
-(void)copyAction{
    [self hidePopView];
    if ([self.delegate respondsToSelector:@selector(confirmAction)]) {
        [self.delegate confirmAction];
    }
}
#pragma mark -Public

- (void)showPopView
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:AnimationTimeInterval animations:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.superView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
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

//
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [self hidePopView];
//}

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
