//
//  BuyBoxView.m
//  AllStars
//
//  Created by Mac on 2021/10/12.
//

#import "BuyBoxView.h"

@implementation BuyBoxView{
    NSInteger countValue;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        countValue = 1;
        [self makeUI];
    }
    return self;
}
-(void)makeUI{
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(30, 0, KScreenWidth-60, 184)];
    [self addSubview:self.bgView];
    self.backgroundColor = [UIColor clearColor];
    self.bgView.backgroundColor = kUIColorFromRGB(0x331B08);
    self.bgView.layer.cornerRadius = 15;
    self.bgView.layer.borderColor = kUIColorFromRGB(0xFFE29E).CGColor;
    self.bgView.layer.borderWidth = 1;
    self.bgView.layer.masksToBounds = YES;
    
    self.ruleBtn = [Tool createButtonWithFrame:CGRectMake(self.bgView.width-75, 0, 75, 22) title:@"" titleColor:kUIColorFromRGB(0xffffff) textFont:MYFONT(11) backgroudColor:kUIColorFromRGB(0x331B08) target:self action:@selector(ruleAction)];
    [self.ruleBtn setBackgroundColor:[UIColor colorWithPatternImage:MYIMAGE(@"ruleIcon")]];
    [self.bgView addSubview:self.ruleBtn];
    
    UILabel *label1 = [Tool createLabelWithFrame:CGRectMake(15, 40, 50, 20) textColor:[UIColor whiteColor] textFont:MYFONT(13) textAligion:NSTextAlignmentLeft labelText:@"商品"];
    [self.bgView addSubview:label1];
    
    UILabel *label2 = [Tool createLabelWithFrame:CGRectMake(15, label1.bottom+20, 50, 20) textColor:[UIColor whiteColor] textFont:MYFONT(13) textAligion:NSTextAlignmentLeft labelText:@"价格"];
    [self.bgView addSubview:label2];
    
    UILabel *label3 = [Tool createLabelWithFrame:CGRectMake(15, label2.bottom+20, 50, 20) textColor:[UIColor whiteColor] textFont:MYFONT(13) textAligion:NSTextAlignmentLeft labelText:@"数量"];
    [self.bgView addSubview:label3];
    
    self.nameL = [Tool createLabelWithFrame:CGRectZero textColor:kUIColorFromRGB(0xFFE29E) textFont:MYFONT(15) textAligion:NSTextAlignmentRight labelText:@"星辰魔盒"];
    [self.bgView addSubview:self.nameL];
    
    self.priceL = [Tool createLabelWithFrame:CGRectZero textColor:kUIColorFromRGB(0xFFE29E) textFont:MYFONT(15) textAligion:NSTextAlignmentRight labelText:@"2222222 BNB"];;
    [self.bgView addSubview:self.priceL];
    
    self.addBtn = [Tool createButtonWithFrame:CGRectZero normalImage:MYIMAGE(@"addBtn") selectImage:nil target:self action:@selector(addAction)];
    [self.bgView addSubview:self.addBtn];
    
    self.minusBtn = [Tool createButtonWithFrame:CGRectZero normalImage:MYIMAGE(@"jianBtn") selectImage:nil target:self action:@selector(minusAction)];
    [self.bgView addSubview:self.minusBtn];
    
    self.countL = [Tool createLabelWithFrame:CGRectZero textColor:kUIColorFromRGB(0xFFE29E) textFont:MYFONT(13) textAligion:NSTextAlignmentCenter labelText:[NSString stringWithFormat:@"%ld",countValue]];
    [self.bgView addSubview:self.countL];
    
    self.buyBtn = [Tool createButtonWithFrame:CGRectZero title:@"" titleColor:kUIColorFromRGB(0xFFE29E) textFont:MYFONT(20) backgroudColor:[UIColor grayColor] target:self action:@selector(buyAction)];
    [self.buyBtn setBackgroundColor:[UIColor colorWithPatternImage:MYIMAGE(@"buyBox")]];
    [self addSubview:self.buyBtn];
    
    [self.nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_right).offset(10);
        make.top.equalTo(label1.mas_top).offset(0);
        make.right.equalTo(self.mas_right).offset(-45);
        make.height.mas_equalTo(@(20));
    }];
    [self.priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label2.mas_right).offset(10);
        make.top.equalTo(label2.mas_top).offset(0);
        make.right.equalTo(self.mas_right).offset(-45);
        make.height.mas_equalTo(@(20));
    }];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label3.mas_top).offset(0);
        make.right.equalTo(self.mas_right).offset(-45);
        make.height.mas_equalTo(@(20));
        make.width.mas_equalTo(@(20));
    }];
    [self.countL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label3.mas_top).offset(0);
        make.right.equalTo(self.addBtn.mas_left).offset(0);
        make.height.mas_equalTo(@(20));
        make.width.mas_equalTo(@(37));
    }];
    [self.minusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label3.mas_top).offset(0);
        make.right.equalTo(self.countL.mas_left).offset(0);
        make.height.mas_equalTo(@(20));
        make.width.mas_equalTo(@(20));
    }];
    
    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(15);
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(@(65));
        make.width.mas_equalTo(@(226));
    }];

}

-(void)ruleAction{
    
}
-(void)addAction{
    countValue ++ ;
    self.countL.text = [NSString stringWithFormat:@"%ld",countValue];
}
-(void)minusAction{
    countValue -- ;
    if (countValue>0) {
        self.countL.text = [NSString stringWithFormat:@"%ld",countValue];
    }else{
        countValue  = 1;
        return;
    }
}
-(void)buyAction{
    
}
@end
