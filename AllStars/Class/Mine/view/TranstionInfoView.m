//
//  TranstionInfoView.m
//  AllStars
//
//  Created by Mac on 2021/12/10.
//

#import "TranstionInfoView.h"
#define AnimationTimeInterval 0.25

@interface TranstionInfoView ()
@property (nonatomic, strong) UIView *superView;
@property (nonatomic, strong) UILabel *showL;
@end

@implementation TranstionInfoView

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
    
    self.showL = [Tool createLabelWithFrame:CGRectMake(20, 20, self.width-40, 200) textColor:[UIColor whiteColor] textFont:MYFONT(17) textAligion:NSTextAlignmentLeft labelText:@"asdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfasdfasdfadsfasdfd"];
    self.showL.numberOfLines = 0;
    [self addSubview:self.showL];
    
    UIButton *copyBtn = [Tool createButtonWithFrame:CGRectMake(35, 240,self.width-70, 40) title:@"复制" titleColor:CNavBgColor textFont:MYFONT(18) backgroudColor:nil target:self action:@selector(copyAction)];
    UIImage *bg = [UIColor gradientImageWithView:copyBtn fromColor:@"#C8AC7C" toColor:@"#F9EFBC" startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) cornerRadius:5];
    copyBtn.backgroundColor = [UIColor colorWithPatternImage:bg];
    [self addSubview:copyBtn];
}

-(void)copyAction{
    [self hidePopView];
//    if ([self.delegate respondsToSelector:@selector(popCopyAction:)]) {
//        [self.delegate popCopyAction:self.showL.text];
//    }
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
