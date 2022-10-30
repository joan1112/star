//
//  CoinPayView.m
//  AllStars
//
//  Created by Mac on 2021/11/9.
//

#import "CoinPayView.h"

@interface CoinPayView ()
@property (nonatomic, strong) UIView *superView;
@property (nonatomic,strong)UILabel *valueL;
@property (nonatomic,strong)UILabel *toL;
@property (nonatomic,strong)UILabel *fromL;
@property (nonatomic,strong)UIImageView *imagV;
@property (nonatomic,strong)UILabel *titleL;
@property (nonatomic,strong)UILabel *flabel;
@property (nonatomic,strong)UILabel *tlabel;
@property (nonatomic,strong)UIButton *button;
@end

@implementation CoinPayView

#pragma mark -lifeCycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
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
    
    self.titleL = [Tool createLabelWithFrame:CGRectMake(0, 15, self.width, 40) textColor:CNavBgColor textFont:MYFONT(20) textAligion:NSTextAlignmentCenter labelText:NSLocalizedString(@"交易详情", nil)];
    [self addSubview:self.titleL];
    
    UILabel *gasFee = [[UILabel alloc]initWithFrame:CGRectMake(20, self.titleL.bottom+15, 130, 25)];
    gasFee.text = NSLocalizedString(@"手續費用", nil);
    [self addSubview:gasFee];
    gasFee.font = MYFONT(15);
    gasFee.textColor = [UIColor grayColor];
    
    self.valueL = [Tool createLabelWithFrame:CGRectMake(gasFee.right+10, self.titleL.bottom+15, KScreenWidth-150-30, 25) textColor:[UIColor grayColor] textFont:MYFONT(15) textAligion:NSTextAlignmentLeft labelText:@"0 BNB"];
//    self.valueL.hidden = YES;
    [self addSubview:self.valueL];
    
    self.flabel = [Tool createLabelWithFrame:CGRectMake(20, self.valueL.bottom+10, 130, 25) textColor:[UIColor grayColor] textFont:MYFONT(15) textAligion:NSTextAlignmentLeft labelText:NSLocalizedString(@"付款地址", nil)];
    [self addSubview:self.flabel];
    
    self.fromL = [Tool createLabelWithFrame:CGRectMake(self.flabel.right+10, self.valueL.bottom+10, KScreenWidth-150-30, 40) textColor:[UIColor grayColor] textFont:MYFONT(15) textAligion:NSTextAlignmentLeft labelText:@"0x12312312313123123123131123123123323232323"];
    self.fromL.numberOfLines = 2;
    [self addSubview:self.fromL];
    
    
    self.tlabel = [Tool createLabelWithFrame:CGRectMake(20, self.fromL.bottom+10, 130, 25) textColor:[UIColor grayColor] textFont:MYFONT(15) textAligion:NSTextAlignmentLeft labelText:NSLocalizedString(@"收款地址", nil)];
    [self addSubview:self.tlabel];
    
    self.toL = [Tool createLabelWithFrame:CGRectMake(self.tlabel.right+10, self.fromL.bottom+10, KScreenWidth-150-30, 40) textColor:[UIColor grayColor] textFont:MYFONT(15) textAligion:NSTextAlignmentLeft labelText:@"0x12312312313123123123131123123123323232323"];
    self.toL.numberOfLines = 2;
    [self addSubview:self.toL];
    
    
    self.button = [Tool createButtonWithFrame:CGRectMake((self.width-125)/2, self.height-20-37-10,125, 37) normalImage:MYIMAGE(@"") selectImage:nil target:self action:@selector(closeAction)];
    UIImage *bg = [UIColor gradientImageWithView:self.button fromColor:@"#C8AC7C" toColor:@"#F9EFBC" startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) cornerRadius:5];
    [self.button setBackgroundImage:bg forState:UIControlStateNormal];
    [self.button setTitle:NSLocalizedString(@"支付", nil) forState:UIControlStateNormal];
    [self.button setTitleColor:CNavBgColor forState:UIControlStateNormal];
    [self addSubview:self.button];
    
    UIButton *close = [Tool createButtonWithFrame:CGRectMake(self.width-50, 20,35, 35) normalImage:MYIMAGE(@"close") selectImage:nil target:self action:@selector(cancelClick)];
    [self addSubview:close];
    

}
-(void)closeAction{
    [self hidePopView];
    
    if ([self.delegate respondsToSelector:@selector(payAction)]) {
        [self.delegate payAction];
    }
}

#pragma mark -Public

- (void)showPopView
{
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.superView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.9];
    } completion:nil];
    
    
}
-(void)cancelClick{
    [self hidePopView];
    
    if ([self.delegate respondsToSelector:@selector(cancelAction)]) {
        [self.delegate cancelAction];
    }
}

- (void)hidePopView
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
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
-(void)setDataDic:(NSDictionary *)dataDic{
    
   
   
    NSString *data = dataDic[@"data"];
    NSString *pref = [data substringToIndex:10];
    if ([pref isEqualToString:@"0x095ea7b3"]) {
        self.titleL.text = NSLocalizedString(@"授權訪問您的權限", nil);
        self.flabel.text = NSLocalizedString(@"授權地址", nil);
        self.fromL.text = dataDic[@"to"];
        self.valueL.text =[NSString stringWithFormat:@"%@ BNB",self.valueS];
        self.valueL.hidden = NO;
        [self.button setTitle:NSLocalizedString(@"授權", nil) forState:UIControlStateNormal];
        self.toL.hidden = YES;
        self.tlabel.hidden = YES;
    }else{
        self.valueL.text =[NSString stringWithFormat:@"%@ BNB",self.valueS];
        self.fromL.text = dataDic[@"from"];
        self.toL.text = dataDic[@"to"];
        self.valueL.text =[NSString stringWithFormat:@"%@ BNB",self.valueS];
        self.valueL.hidden = NO;
    }
    
}
@end
