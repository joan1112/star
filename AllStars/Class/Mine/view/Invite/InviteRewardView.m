//
//  InviteRewardView.m
//  AllStars
//
//  Created by junqiang on 2022/3/4.
//

#import "InviteRewardView.h"
@interface InviteRewardView()
@property(nonatomic,strong)UIScrollView *scollV;
@property(nonatomic,strong)UIView *content;

@end
@implementation InviteRewardView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
    }
    return self;
}
-(void)loadView{
    _scollV=[[UIScrollView alloc]init];
    _scollV.showsVerticalScrollIndicator=NO;
    _scollV.userInteractionEnabled=YES;
    _scollV.backgroundColor=kUIColorFromRGB(0x040827);

//    _scollV.delegate=self;
    [self addSubview:_scollV];
    
    [_scollV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(KScreenWidth);
        
    }];
    
    _content=UIView.new;
    _content.userInteractionEnabled=YES;
    _content.backgroundColor=kUIColorFromRGB(0x040827);
    [_scollV addSubview:_content];
    
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scollV);
        make.width.equalTo(_scollV);
    }];
    
    UIImageView *wallect = [[UIImageView alloc]init];
    wallect.image = [UIImage imageNamed:@"createWallet"];
    [_content addSubview:wallect];
    
    UILabel *nameLab = [Tool createLabelWithFrame:CGRectZero textColor:kUIColorFromRGB(0x007AFF) textFont:MYFONT(18) textAligion:NSTextAlignmentLeft labelText:[[NSUserDefaults standardUserDefaults] objectForKey:@"address"]];
    nameLab.lineBreakMode = NSLineBreakByTruncatingMiddle;
    [_content addSubview:nameLab];
    
    UIButton *bindBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bindBtn.backgroundColor = kUIColorFromRGB(0x007AFF);
    [bindBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bindBtn setTitle:@"Apply for binding" forState:UIControlStateNormal];
    [_content addSubview:bindBtn];
    bindBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    bindBtn.layer.cornerRadius = 12;
    bindBtn.layer.masksToBounds = YES;
   
    [wallect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_content.mas_top).offset(18);
        make.left.equalTo(_content.mas_left).equalTo(@15);
        make.width.equalTo(@40);
        make.height.equalTo(@35);

    }];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wallect.mas_right).equalTo(@10);
        make.top.equalTo(_content.mas_top).offset(25);
        make.width.equalTo(@100);
        make.height.equalTo(@25);

    }];
    [bindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_content.mas_top).offset(25);
        make.width.equalTo(@100);
        make.height.equalTo(@24);
        make.right.equalTo(_content.mas_right).mas_offset(-15);

    }];
    
    UIButton *inviteReward = [UIButton buttonWithType:UIButtonTypeCustom];
    inviteReward.frame = CGRectMake(15, 160, KScreenWidth-30, 44);
    UIImage *img =  [UIColor gradientImageWithView:inviteReward fromColor:@"#006BFF " toColor:@"#00F2FF" startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) cornerRadius:22];
    [inviteReward setBackgroundImage:img forState:UIControlStateNormal];
    [_content addSubview:inviteReward];
    [inviteReward setTitle:@"Invitation Reward" forState:UIControlStateNormal];
    [inviteReward addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView  *introBg = [[UIView alloc]init];
    [_content addSubview:introBg];
    introBg.layer.borderWidth = .8;
    introBg.layer.borderColor = kUIColorFromRGB(0x004EC3).CGColor;
    introBg.layer.cornerRadius = 10;
    
    UILabel *introDetail = [[UILabel alloc]init];
    [introBg addSubview:introDetail];
    introDetail.textColor = [UIColor whiteColor];
    introDetail.font = [UIFont systemFontOfSize:12];
    introDetail.numberOfLines = 0;
    introDetail.text = @"You can invite other users to be your friends. When the invitation is successful, a part of the STAR consumed by your friend in Shop will be used as a commission, and the rebate will be given to you.\n Level 1 Friend: Provide the users you invite directly.\n Level 2 Friend: Among your friends, the user he invites will become your level 2 friend.\n Rebate Rules:\n Level 1 Friend: You will receive a 6% rebate for STAR consumption in the Shop.\n Level 2 Friend: You will receive a 1% rebate for STAR consumption in the Shop.\n Withdrawal: Rebate will arrive to your account at the actual time and it can be withdrawn to your wallet at any time.";
    // 行间距设置为8
    NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];

        [paragraphStyle  setLineSpacing:8];

        NSString  *testString = introDetail.text;
        NSMutableAttributedString  *setString = [[NSMutableAttributedString alloc] initWithString:testString];
        [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [testString length])];
        
        // 设置Label要显示的text
        [introDetail setAttributedText:setString];
    
    UIView *earings = [[UIView alloc]init];
    [introBg addSubview:earings];
    earings.backgroundColor = kUIColorFromRGB(0xFFBA00);
    earings.layer.cornerRadius = 6;
    earings.layer.masksToBounds = YES;
    CGFloat wd = KScreenWidth-50;

    UILabel *earnTitle = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, wd-10, 29)];
    earnTitle.font = [UIFont systemFontOfSize:14];
    earnTitle.textAlignment = NSTextAlignmentCenter;
    earnTitle.text = @"我的收益";
    earnTitle.textColor = [UIColor whiteColor];
    [earings addSubview:earnTitle];
    for (int i=0; i<2; i++) {
        UIView *vv = [[UIView alloc]initWithFrame:CGRectMake(0,30+40*i, wd, 40)];
        vv.backgroundColor = kUIColorFromRGB(0x8C8E9C);
        [earings addSubview:vv];
        
        UIImageView *icon = [[UIImageView alloc]init];
        icon.frame = CGRectMake(5, 10, 20, 20);
        icon.image = [UIImage imageNamed:[NSString stringWithFormat:@"level%d",i+1]];
        [vv addSubview:icon];
        
        UILabel *level = [[UILabel alloc]initWithFrame:CGRectMake(26, 0, 50, 39)];
        level.font = [UIFont systemFontOfSize:12];
        level.text = @"level1";
        level.textColor = kUIColorFromRGB(0x272E49);
        [vv addSubview:level];
        
        UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(level.frame),0, .6, 39)];
        line1.backgroundColor = kUIColorFromRGB(0x9C9EAA);
        [vv addSubview:line1];
        
        UILabel *level1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(line1.frame)+5, 0, wd-210, 39)];
        level1.font = [UIFont systemFontOfSize:12];
        level1.text = @"Buy STARBOX  Consume STAR";
        level1.textColor = kUIColorFromRGB(0x272E49);
        [vv addSubview:level1];
        level1.numberOfLines = 2;

        UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(level1.frame), 0, .6, 39)];
        line2.backgroundColor = kUIColorFromRGB(0x9C9EAA);
        [vv addSubview:line2];
        UILabel *level3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(line2.frame)+5, 0, 138, 39)];
        level3.font = [UIFont systemFontOfSize:12];
        level3.text = @[@"Rebate ratio 6%",@"Rebate ratio 1%"][i];
        level3.textColor = kUIColorFromRGB(0x272E49);
        [vv addSubview:level3];
        if (i==0) {
            UILabel *centre = [[UILabel alloc]initWithFrame:CGRectMake(0, 39, wd, .6)];
            [vv addSubview:centre];
            centre.backgroundColor = kUIColorFromRGB(0x9C9EAA);
        }
        
    }
    [introBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(inviteReward.mas_bottom).offset(15);
        make.left.equalTo(_content.mas_left).offset(15);
        make.right.equalTo(_content.mas_right).offset(-15);
        
    }];
    
    [introDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(introBg.mas_left).offset(10);
        make.top.equalTo(introBg.mas_top).offset(10);
        make.right.equalTo(introBg.mas_right).offset(-15);

    }];
    
    [earings mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(introBg.mas_left).offset(10);
        make.top.equalTo(introDetail.mas_bottom).offset(10);
        make.right.equalTo(introBg.mas_right).offset(-10);
        make.height.mas_offset(110);

    }];
    [introBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(earings.mas_bottom).offset(40);
    }];
        
    
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(introBg.mas_bottom).offset(80);
    }];
    
}
-(void)btnClick:(UIButton*)sender
{
    if (self.btnClick) {
        self.btnClick(1);
    }
}
@end
