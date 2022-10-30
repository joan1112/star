//
//  InviteDetailView.m
//  AllStars
//
//  Created by junqiang on 2022/3/4.
//

#import "InviteDetailView.h"
#import "UIButton+SGPagingView.h"
@interface InviteDetailView()
@property(nonatomic,strong)UIScrollView *scollV;
@property(nonatomic,strong)UIView *content;

@end
@implementation InviteDetailView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubview];
        
    }
    return self;
}
-(void)initSubview{
//    _scollV=[[UIScrollView alloc]init];
//    _scollV.showsVerticalScrollIndicator=NO;
//    _scollV.userInteractionEnabled=YES;
//    _scollV.backgroundColor=kUIColorFromRGB(0x040827);
//    _scollV.contentSize = CGSizeMake(KScreenWidth, KScreenHeight);
////    _scollV.delegate=self;
//    [self addSubview:_scollV];
//
//    [_scollV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top);
//        make.left.equalTo(self.mas_left);
//        make.bottom.equalTo(self.mas_bottom);
//        make.width.mas_equalTo(KScreenWidth);
//
//    }];
    
    _content=UIView.new;
    _content.userInteractionEnabled=YES;
    _content.backgroundColor=kUIColorFromRGB(0x040827);
    [self addSubview:_content];
    
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.width.equalTo(self);
    }];
    
    UIImageView *wallect = [[UIImageView alloc]init];
    wallect.image = [UIImage imageNamed:@"createWallet"];
    [_content addSubview:wallect];
    
    UILabel *nameLab = [Tool createLabelWithFrame:CGRectZero textColor:kUIColorFromRGB(0x007AFF) textFont:MYFONT(18) textAligion:NSTextAlignmentLeft labelText:[[NSUserDefaults standardUserDefaults] objectForKey:@"address"]];
    nameLab.lineBreakMode = NSLineBreakByTruncatingMiddle;
    [_content addSubview:nameLab];
    
    UIImageView *all_star = [[UIImageView alloc]init];
    all_star.image = [UIImage imageNamed:@"reward_star"];
    [_content addSubview:all_star];
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
    [all_star mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_content.mas_top).offset(20);
        make.width.mas_offset(40*1.4);
        make.height.mas_offset(40);
        make.right.equalTo(_content.mas_right).mas_offset(-15);

    }];
    
    
    UIButton *bindBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bindBtn.backgroundColor = kUIColorFromRGB(0x1D3882);
    [_content addSubview:bindBtn];
    [bindBtn setTitle:@"已绑定" forState:UIControlStateNormal];
    bindBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    bindBtn.layer.cornerRadius = 5;
    bindBtn.layer.masksToBounds = YES;
    [bindBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bindBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    bindBtn.tag = 10;
    
    UIButton *inviteRule = [UIButton buttonWithType:UIButtonTypeCustom];
    inviteRule.backgroundColor = kUIColorFromRGB(0x040827);
    [_content addSubview:inviteRule];
    [inviteRule setTitle:@"邀请规则" forState:UIControlStateNormal];
    inviteRule.titleLabel.font = [UIFont systemFontOfSize:13];
    [inviteRule setTitleColor:kUIColorFromRGB(0x007AFF) forState:UIControlStateNormal];
    inviteRule.layer.cornerRadius = 5;
    inviteRule.layer.masksToBounds = YES;
    inviteRule.layer.borderColor = kUIColorFromRGB(0x007AFF).CGColor;
    inviteRule.layer.borderWidth = 1;
    [inviteRule addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    inviteRule.tag = 11;
    
    [bindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wallect.mas_bottom).offset(18);
        make.left.equalTo(_content.mas_left).equalTo(@15);
        make.width.equalTo(@70);
        make.height.equalTo(@28);

    }];
    
    
    [inviteRule mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wallect.mas_bottom).offset(18);
        make.left.equalTo(bindBtn.mas_right).equalTo(@15);
        make.width.equalTo(@70);
        make.height.equalTo(@28);

    }];
    
    UIView *earings = [[UIView alloc]init];
    [_content addSubview:earings];
    earings.layer.masksToBounds = YES;
    earings.layer.borderColor = kUIColorFromRGB(0x007AFF).CGColor;
    earings.layer.cornerRadius = 10;
    earings.layer.borderWidth = 1;
    
    
    [earings mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(inviteRule.mas_bottom).offset(18);
        make.left.equalTo(_content.mas_left).equalTo(@15);
        make.right.equalTo(_content.mas_right).equalTo(@-15);
        make.height.equalTo(@120);

    }];

    CGFloat wd = KScreenWidth-30;

    CGFloat perH = 40;

    for (int i=0; i<2; i++) {
        UIView *vv = [[UIView alloc]initWithFrame:CGRectMake(0,80*i, wd, 80-i*40)];
        [earings addSubview:vv];
        
        UILabel *leftLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 80-i*40)];
        
        [vv addSubview:leftLab];
        leftLab.text = @[@"好友人数",@"可提现收益"][i];
        leftLab.textColor = kUIColorFromRGB(0x007AFF);
        leftLab.font = [UIFont systemFontOfSize:12];
        
        
        UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftLab.frame),0, .6, 80-i*40)];
        line1.backgroundColor = kUIColorFromRGB(0x02459A);
        [vv addSubview:line1];
        
        if (i==0) {
            UIImageView *icon = [[UIImageView alloc]init];
            icon.frame = CGRectMake(CGRectGetMaxX(leftLab.frame)+10, 10, 20, 20);
            icon.image = [UIImage imageNamed:@"level1"];
            [vv addSubview:icon];
            UILabel *level = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(icon.frame)+5, 0, 50, 40)];
            level.font = [UIFont systemFontOfSize:12];
            level.text = @"level";
            level.textColor = UIColor.whiteColor;
            [vv addSubview:level];
            
            UILabel *detail = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth-30-150, 0, 130, perH)];
            detail.font = [UIFont systemFontOfSize:12];
            detail.text = @"0 人";
            detail.textColor = kUIColorFromRGB(0xFFB031);
            [vv addSubview:detail];
            detail.textAlignment = NSTextAlignmentRight;

            
            UIImageView *icon1 = [[UIImageView alloc]init];
            icon1.frame = CGRectMake(CGRectGetMaxX(leftLab.frame)+10, perH+10, 20, 20);
            icon1.image = [UIImage imageNamed:@"level2"];
            [vv addSubview:icon1];
            
            UILabel *level1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(icon1.frame)+5, perH, 50, 40)];
            level1.font = [UIFont systemFontOfSize:12];
            level1.text = @"level";
            level1.textColor = UIColor.whiteColor;
            [vv addSubview:level1];
            
            UILabel *detail1 = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth-30-150, perH,130, perH)];
            detail1.font = [UIFont systemFontOfSize:12];
            detail1.text = @"0 人";
            detail1.textColor = kUIColorFromRGB(0x31FFF8);
            [vv addSubview:detail1];
            detail1.textAlignment = NSTextAlignmentRight;

            UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(0,80-i*perH, vv.mj_w, .8)];
            line1.backgroundColor = kUIColorFromRGB(0x02459A);
            [vv addSubview:line1];
        }else{
            UIImageView *icon = [[UIImageView alloc]init];
            icon.frame = CGRectMake(CGRectGetMaxX(leftLab.frame)+10, 10, 20, 20);
            icon.image = [UIImage imageNamed:@"star-coin"];
            [vv addSubview:icon];
            
            UILabel *detail1 = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth-30-150, 0, 130, perH)];
            detail1.font = [UIFont systemFontOfSize:12];
            detail1.text = @"011111 STAR";
            detail1.textAlignment = NSTextAlignmentRight;
            detail1.textColor = [UIColor whiteColor];
            [vv addSubview:detail1];
            
        }
        
        
    }
    
    UILabel *totalPrice = [[UILabel alloc]init];
    [_content addSubview:totalPrice];
    totalPrice.text = @"累计收益：999,999,999,000";
    totalPrice.textColor = kUIColorFromRGB(0x007AFF);
    totalPrice.font = [UIFont systemFontOfSize:12];
    totalPrice.textAlignment = NSTextAlignmentRight;
    
    [totalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(earings.mas_bottom).offset(10);
        make.right.equalTo(_content.mas_right).equalTo(@-15);
        make.height.equalTo(@30);
        make.left.equalTo(_content.mas_left).offset(15);

    }];
    
    UIButton *friendDetail = [UIButton buttonWithType:UIButtonTypeCustom];
    friendDetail.backgroundColor = kUIColorFromRGB(0x1D3882);
    [_content addSubview:friendDetail];
    [friendDetail setTitle:@"好友详情" forState:UIControlStateNormal];
    friendDetail.titleLabel.font = [UIFont systemFontOfSize:13];
    friendDetail.layer.cornerRadius = 23;
    friendDetail.layer.masksToBounds = YES;
    [friendDetail setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [friendDetail addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    friendDetail.tag = 12;
    
//    UIButton *withDraw = [UIButton buttonWithType:UIButtonTypeCustom];
//    withDraw.backgroundColor = kUIColorFromRGB(0x040827);
//    [_content addSubview:withDraw];
//    [withDraw setTitle:@"邀请规则" forState:UIControlStateNormal];
//    withDraw.titleLabel.font = [UIFont systemFontOfSize:13];
//    [withDraw setTitleColor:kUIColorFromRGB(0x007AFF) forState:UIControlStateNormal];
//
    
    UIButton *addFiend = [UIButton buttonWithType:UIButtonTypeCustom];
    addFiend.backgroundColor = kUIColorFromRGB(0x3E37CB);
    [_content addSubview:addFiend];
    [addFiend setTitle:@"添加好友" forState:UIControlStateNormal];
    [addFiend setImage:[UIImage imageNamed:@"addFriend"] forState:UIControlStateNormal];
    addFiend.titleLabel.font = [UIFont systemFontOfSize:13];
    addFiend.layer.cornerRadius = 23;
    addFiend.layer.masksToBounds = YES;
    [addFiend setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addFiend addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    addFiend.tag = 13;
    
    UIButton *inviteFriend = [UIButton buttonWithType:UIButtonTypeCustom];
    inviteFriend.backgroundColor = kUIColorFromRGB(0x34AE1C);
    [_content addSubview:inviteFriend];
    [inviteFriend setTitle:@"邀请好友" forState:UIControlStateNormal];
    [inviteFriend setImage:[UIImage imageNamed:@"inviteFriend"] forState:UIControlStateNormal];
    inviteFriend.titleLabel.font = [UIFont systemFontOfSize:13];
    inviteFriend.layer.cornerRadius =23;
    inviteFriend.layer.masksToBounds = YES;
    [inviteFriend setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [inviteFriend addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    inviteFriend.tag = 14;
    
    [friendDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(earings.mas_bottom).offset(50);
        make.right.equalTo(_content.mas_right).offset(-((KScreenWidth-50)/2 + 20));
        make.height.equalTo(@46);
        make.left.equalTo(_content.mas_left).offset(15);

    }];
    
    [addFiend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(friendDetail.mas_bottom).offset(90);
        make.right.equalTo(_content.mas_right).equalTo(@-30);
        make.height.equalTo(@46);
        make.left.equalTo(_content.mas_left).offset(30);

    }];
    
    [inviteFriend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addFiend.mas_bottom).offset(25);
        make.right.equalTo(_content.mas_right).equalTo(@-30);
        make.height.equalTo(@46);
        make.left.equalTo(_content.mas_left).offset(30);

    }];
    
    
    UIButton *record = [UIButton buttonWithType:UIButtonTypeCustom];
    [_content addSubview:record];
    record.frame = CGRectMake(15, KScreenHeight-120, 68, 80);
    [record setTitle:@"收益记录" forState:UIControlStateNormal];
    [record setImage:[UIImage imageNamed:@"record"] forState:UIControlStateNormal];
    record.titleLabel.font = [UIFont systemFontOfSize:13];
    [record setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [record addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    record.tag = 15;
    [record SG_imagePositionStyle:SGImagePositionStyleTop spacing:5 imagePositionBlock:^(UIButton *button) {
        
    }];

    
    UIButton *study = [UIButton buttonWithType:UIButtonTypeCustom];
    [_content addSubview:study];
    [study setTitle:@"邀请教程" forState:UIControlStateNormal];
    study.frame = CGRectMake(KScreenWidth-100, KScreenHeight-120, 68, 80);

    [study setImage:[UIImage imageNamed:@"study"] forState:UIControlStateNormal];
    study.titleLabel.font = [UIFont systemFontOfSize:13];
    [study setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [study addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    study.tag = 16;
    [study SG_imagePositionStyle:SGImagePositionStyleTop spacing:5 imagePositionBlock:^(UIButton *button) {

    }];
    [record mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_content.mas_bottom).offset(-80);
        make.left.equalTo(_content.mas_left).equalTo(@15);
        make.height.equalTo(@80);
        make.width.equalTo(@68);

    }];
    
    
    [study mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_content.mas_bottom).offset(-80);
        make.right.equalTo(_content.mas_right).equalTo(@-15);
        make.height.equalTo(@80);
        make.width.equalTo(@68);

    }];
    
//    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(inviteFriend.mas_bottom).offset(200);
//    }];
    
}
-(void)btnClick:(UIButton*)sender
{
    if (self.inviteAction) {
        self.inviteAction(sender.tag-10);
    }
}
@end
