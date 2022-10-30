//
//  PassStatusView.m
//  AllStars
//
//  Created by Mac on 2021/10/30.
//

#import "PassStatusView.h"
#define AnimationTimeInterval 0.25

@interface PassStatusView ()
@property (nonatomic, strong) UIView *superView;
@property (nonatomic,strong)UILabel *titleL;
@property (nonatomic,strong)UIImageView *imagV;

@end

@implementation PassStatusView

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
    
    self.titleL = [Tool createLabelWithFrame:CGRectMake(0, 15, self.width, 40) textColor:CLineColor textFont:MYFONT(20) textAligion:NSTextAlignmentCenter labelText:NSLocalizedString(@"密码输入", nil)];
    [self addSubview:self.titleL];
    
    self.imagV = [Tool createImageViewWithFrame:CGRectMake((self.width-90)/2, (self.height-90)/2, 90, 90) image:nil placeholderImge:nil];
    self.imagV.image = MYIMAGE(@"圆角矩形 1(5)");
    [self addSubview:self.imagV];
    
    UIButton *button = [Tool createButtonWithFrame:CGRectMake((self.width-125)/2, self.height-20-37,125, 37) normalImage:MYIMAGE(@"") selectImage:nil target:self action:@selector(closeAction)];
    UIImage *bg = [UIColor gradientImageWithView:button fromColor:@"#C8AC7C" toColor:@"#F9EFBC" startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) cornerRadius:5];
    [button setBackgroundImage:bg forState:UIControlStateNormal];
    [button setTitle:@"OK" forState:UIControlStateNormal];
    [button setTitleColor:CNavBgColor forState:UIControlStateNormal];
    [self addSubview:button];
    
    
}
-(void)closeAction{
    [self hidePopView];
    if ([self.delegate respondsToSelector:@selector(statusDoneAction:)]) {
        [self.delegate statusDoneAction:self.success];
    }
}
#pragma mark -Public

- (void)showPopView
{
    self.titleL.text = self.titleS;
    if (self.success) {
        self.imagV.image = MYIMAGE(@"组 2");
    }else{
        self.imagV.image = MYIMAGE(@"组 3");
    }
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:AnimationTimeInterval animations:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.superView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.9];
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
