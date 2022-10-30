//
//  InviteHeadView.m
//  AllStars
//
//  Created by Mac on 2021/10/13.
//

#import "InviteHeadView.h"

@implementation InviteHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        [self makeUI];
    }
    return self;
}
-(void)makeUI{
    self.headV = [Tool createImageViewWithFrame:CGRectMake(15, 20, 55, 55) image:MYIMAGE(@"headDefault") placeholderImge:nil];
    [self addSubview:self.headV];
    
    self.nameL = [Tool createLabelWithFrame:CGRectMake(self.headV.right+15, 20, 200, 55) textColor:CLineColor textFont:MYBOLDFONT(18) textAligion:NSTextAlignmentLeft labelText:@"合伙人"];
    [self addSubview:self.nameL];
    
    UIView *bgv = [[UIView alloc]initWithFrame:CGRectMake(15, self.headV.bottom+20, KScreenWidth-30, 100)];
    bgv.backgroundColor = CNavBgColor;
    bgv.layer.cornerRadius = 10;
    bgv.layer.masksToBounds = YES;
    [self addSubview:bgv];
    
    UILabel *title1 = [Tool createLabelWithFrame:CGRectMake(0, 10, bgv.width/2, 40) textColor:[UIColor whiteColor]textFont:MYFONT(12) textAligion:NSTextAlignmentCenter labelText:@"邀请好友(人)"];
    [bgv addSubview:title1];
    self.personL =[Tool createLabelWithFrame:CGRectMake(0, title1.bottom, bgv.width/2, 40) textColor:CLineColor textFont:MYBOLDFONT(20) textAligion:NSTextAlignmentCenter labelText:@"20000"];
    [bgv addSubview:self.personL];
    
    UILabel *title2 = [Tool createLabelWithFrame:CGRectMake(title1.right, 10, bgv.width/2, 40) textColor:[UIColor whiteColor]textFont:MYFONT(12) textAligion:NSTextAlignmentCenter labelText:@"邀请返佣(BNB)"];
    [bgv addSubview:title2];
    self.moneyL =[Tool createLabelWithFrame:CGRectMake(title1.right, title1.bottom, bgv.width/2, 40) textColor:CLineColor textFont:MYBOLDFONT(20) textAligion:NSTextAlignmentCenter labelText:@"20000"];
    [bgv addSubview:self.moneyL];
    
    UILabel *title3 = [Tool createLabelWithFrame:CGRectMake(15, bgv.bottom +20, bgv.width/2, 25) textColor:[UIColor whiteColor]textFont:MYFONT(12) textAligion:NSTextAlignmentLeft labelText:@"返佣记录"];
    [self addSubview:title3];
}

@end
