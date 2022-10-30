//
//  MineHeadView.m
//  AllStars
//
//  Created by Mac on 2021/10/11.
//

#import "MineHeadView.h"

@implementation MineHeadView{
    
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setSubViews];
    }
    return self;
}
-(void)setSubViews{
    UIImageView *iconV = [Tool createImageViewWithFrame:CGRectMake(18, 20, 100, 57) image:MYIMAGE(@"all-star") placeholderImge:nil];
    iconV.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:iconV];
    
    self.nameL = [Tool createLabelWithFrame:CGRectMake(iconV.right+10, 30, 160, 37) textColor:CLineColor textFont:MYFONT(18) textAligion:NSTextAlignmentLeft labelText:[[NSUserDefaults standardUserDefaults] objectForKey:@"address"]];
    self.nameL.lineBreakMode = NSLineBreakByTruncatingMiddle;
    [self addSubview:self.nameL];
    
    UIButton *setBtn = [Tool createButtonWithFrame:CGRectMake(KScreenWidth-18-25, 35, 25, 25) normalImage:MYIMAGE(@"set_icon") selectImage:nil target:self action:@selector(setAction)];
    [self addSubview:setBtn];
    
    UIView *bgV = [[UIView alloc]initWithFrame:CGRectMake(18, 97, KScreenWidth-36, 149)];
    bgV.backgroundColor = CNavBgColor;
    bgV.layer.cornerRadius = 5;
    bgV.layer.masksToBounds = YES;
    [self addSubview:bgV];
    
    self.foundBtn = [Tool createButtonWithFrame:CGRectMake(15, 10, 105, 25) title: NSLocalizedString(@"我的资产", nil) titleColor:CLineColor textFont:MYFONT(19) backgroudColor:CNavBgColor target:self action:@selector(foundAction:)];
    [ self.foundBtn setImage:MYIMAGE(@"data_open") forState:UIControlStateNormal];
    self.foundBtn.selected = NO;
    [ self.foundBtn SG_imagePositionStyle:SGImagePositionStyleRight spacing:15 imagePositionBlock:^(UIButton *button) {
            ;
    }];
    [bgV addSubview: self.foundBtn];
    
    UILabel *foundL = [Tool createLabelWithFrame:CGRectMake(15,  self.foundBtn.bottom+10, KScreenWidth-80, 25) textColor:[UIColor whiteColor] textFont:MYFONT(19) textAligion:NSTextAlignmentLeft labelText:@"$99999999999999999"];
    foundL.hidden = YES;
    [bgV addSubview:foundL];
    
    UIImageView *dotV = [Tool createImageViewWithFrame:CGRectMake(bgV.width-16, 10, 6, 25) image:MYIMAGE(@"dot_icon") placeholderImge:nil];
    [bgV addSubview:dotV];
    
    UIButton *moreBtn = [Tool createButtonWithFrame:CGRectMake(bgV.width-110, 5, 100, 25) normalImage:nil selectImage:nil target:self action:@selector(moreClick)];
    [bgV addSubview:moreBtn];
    
    UIButton *recvBtn = [Tool createButtonWithFrame:CGRectMake(0, 105, bgV.width/2-0.5, 45) title:NSLocalizedString(@"接收", nil) titleColor:[UIColor whiteColor] textFont:MYFONT(19) backgroudColor:kUIColorFromRGB(0x4F5C6F) target:self action:@selector(recvAction)];
    [recvBtn setImage:MYIMAGE(@"recv_icon") forState:UIControlStateNormal];
    [recvBtn SG_imagePositionStyle:SGImagePositionStyleDefault spacing:15 imagePositionBlock:^(UIButton *button) {
            ;
    }];
    [bgV addSubview:recvBtn];
    
    UIButton *sendBtn = [Tool createButtonWithFrame:CGRectMake(recvBtn.right+0.5,105,bgV.width/2-0.5, 45) title: NSLocalizedString(@"发送", nil) titleColor:[UIColor whiteColor] textFont:MYFONT(19) backgroudColor:kUIColorFromRGB(0x4F5C6F) target:self action:@selector(sendAction)];
    [sendBtn setImage:MYIMAGE(@"send_icon") forState:UIControlStateNormal];
    [sendBtn SG_imagePositionStyle:SGImagePositionStyleDefault spacing:15 imagePositionBlock:^(UIButton *button) {
            ;
    }];
    [bgV addSubview:sendBtn];
    
}

-(void)setAction{
    if ([self.delegate respondsToSelector:@selector(headSetAction)]) {
        [self.delegate headSetAction];
    }
}
-(void)foundAction:(UIButton*)btn{
    btn.selected = !btn.selected;
    NSString *filePath = [NSString stringWithFormat:@"%@/Documents/config.txt", NSHomeDirectory()];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    if (btn.selected) {
        [dic setValue:@"0" forKey:@"foundStatus"];
        [dic writeToFile:filePath atomically:YES];
        [ self.foundBtn setImage:MYIMAGE(@"data_close") forState:UIControlStateNormal];
    }else{
        [dic setValue:@"1" forKey:@"foundStatus"];
        [dic writeToFile:filePath atomically:YES];
        [ self.foundBtn setImage:MYIMAGE(@"data_open") forState:UIControlStateNormal];
    }
    
    if ([self.delegate respondsToSelector:@selector(hidenDataAction:)]) {
        [self.delegate hidenDataAction:btn.selected];
    }
}
-(void)recvAction{
    if ([self.delegate respondsToSelector:@selector(headRecvAction)]) {
        [self.delegate headRecvAction];
    }
}
-(void)sendAction{
    if ([self.delegate respondsToSelector:@selector(headSendAction)]) {
        [self.delegate headSendAction];
    }
}
-(void)moreClick{
    if ([self.delegate respondsToSelector:@selector(headMoreAction)]) {
        [self.delegate headMoreAction];
    }
}
@end
