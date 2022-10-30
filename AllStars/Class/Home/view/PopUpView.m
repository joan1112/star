//
//  PopUpView.m
//  AllStars
//
//  Created by Mac on 2021/12/23.
//

#import "PopUpView.h"
#define AnimationTimeInterval 0.25

@interface PopUpView ()
@property (nonatomic, strong) UIView *superView;

@end

@implementation PopUpView

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
    
    [self.superView addSubview:self];
    
    self.contentV = [[UIImageView alloc]initWithFrame:self.bounds];
    self.contentV.contentMode = UIViewContentModeScaleAspectFill;
    self.contentV.userInteractionEnabled = YES;
    [self addSubview:self.contentV];
   

    UITapGestureRecognizer *tapView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpAction)];
    [self.contentV addGestureRecognizer:tapView];
    
    UIButton *button = [Tool createButtonWithFrame:CGRectMake(self.width-36,10,26,26) normalImage:MYIMAGE(@"圆角矩形 2") selectImage:nil target:self action:@selector(closeAction)];
    [self addSubview:button];
    
    
}
-(void)jumpAction{
    [self hidePopView];
    if ([self.delegate respondsToSelector:@selector(popUpJumpAction:)]) {
        [self.delegate popUpJumpAction:self.tag-100];
    }
}
-(void)closeAction{
    [self hidePopView];
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
