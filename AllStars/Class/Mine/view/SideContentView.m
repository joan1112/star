//
//  SideContentView.m
//  AllStars
//
//  Created by Mac on 2021/10/13.
//

#import "SideContentView.h"

@implementation SideContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        [self makeUI];
    }
    return self;
}
-(void)makeUI{
    self.userInteractionEnabled = YES;
    
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, KScreenWidth-30, 120)];
    [self addSubview:self.bgView];
    self.backgroundColor = [UIColor clearColor];
    self.bgView.backgroundColor = CNavBgColor;
    self.bgView.layer.cornerRadius = 10;
    self.bgView.layer.borderColor = CNavBgColor.CGColor;
    self.bgView.layer.borderWidth = 1;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.userInteractionEnabled = YES;
    
   
    self.iconV = [Tool createImageViewWithFrame:CGRectZero image:MYIMAGE(@"暗潮") placeholderImge:nil];
    self.iconV.contentMode = UIViewContentModeScaleAspectFill;
    [self.bgView addSubview:self.iconV];
    
    self.chooseV = [Tool createImageViewWithFrame:CGRectZero image:MYIMAGE(@"side_choose") placeholderImge:nil];
    self.chooseV.contentMode = UIViewContentModeScaleAspectFill;
    self.chooseV.hidden = YES;
    [self.bgView addSubview:self.chooseV];
    
    self.nameL = [Tool createLabelWithFrame:CGRectZero textColor:kUIColorFromRGB(0xFFE29E) textFont:MYFONT(18) textAligion:NSTextAlignmentLeft labelText:@"暗潮"];
    [self.bgView addSubview:self.nameL];
    
    self.contentL = [Tool createLabelWithFrame:CGRectZero textColor:[UIColor whiteColor] textFont:MYFONT(13) textAligion:NSTextAlignmentLeft labelText:@"提升水系、暗影系的\n 攻击力、掉落率"];
    self.contentL.numberOfLines = 0;
    [self.bgView addSubview:self.contentL];
    
    
   
    [self.iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(50);
        make.top.equalTo(self.mas_top).offset(20);
        make.height.mas_equalTo(@(80));
        make.width.mas_equalTo(@(42));
    }];
    [self.nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconV.mas_right).offset(40);
        make.top.equalTo(self.iconV.mas_top).offset(0);
        make.width.mas_equalTo(@(100));
        make.height.mas_equalTo(@(40));
    }];
    
    [self.contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconV.mas_right).offset(40);
        make.top.equalTo(self.nameL.mas_bottom).offset(0);
        make.width.mas_equalTo(@(200));
        make.height.mas_equalTo(@(40));
    }];
    [self.chooseV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView.mas_right).offset(0);
        make.bottom.equalTo(self.bgView.mas_bottom).offset(0);
        make.width.mas_equalTo(@(45));
        make.height.mas_equalTo(@(45));
    }];
    
}


@end
