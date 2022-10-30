//
//  HFTimeOutView.m
//  MCC-AMS
//
//  Created by BOC002 on 2018/5/23.
//  Copyright © 2018年 BOC002. All rights reserved.
//

#import "HFTimeOutView.h"
#import "Masonry.h"
#define AdaptH(H) KScreenWidth * H/375.0
@interface HFTimeOutView(){
    UIImageView * _alertIMg;// 
    UILabel * _alertLab;
    UIButton * _alertBtn;
}
@end

@implementation HFTimeOutView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _alertIMg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"empty_time_out"]];
        [self addSubview:_alertIMg];
        [_alertIMg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(@(AdaptH(200)-self.y));
            make.width.equalTo(@220);
            make.height.equalTo(@170);
        }];
        
        _alertLab = [[UILabel alloc] init];
        _alertLab.font = [UIFont systemFontOfSize:15];
        _alertLab.userInteractionEnabled = YES;
        [_alertLab addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reloadNetworkDataSourcer)]];
        _alertLab.textAlignment = NSTextAlignmentCenter;
        _alertLab.textColor = rgb_color(153, 153, 153, 1);
        _alertLab.text = @"网络请求超时";
        [self addSubview:_alertLab];
        [_alertLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.top.equalTo(self->_alertIMg.mas_bottom).with.offset(0);
            make.height.equalTo(@20);
            
        }];
        
        
        _alertBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_alertBtn setBackgroundImage:[UIImage imageNamed:@"try_again"] forState:UIControlStateNormal];
//        [_alertBtn setBackgroundImage:[UIImage imageNamed:@"try_again"] forState:UIControlStateHighlighted];
        [_alertBtn setTitle:@"重试" forState:UIControlStateNormal];
        _alertBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_alertBtn setTitleColor:kUIColorFromRGB(0xb50029) forState:UIControlStateNormal];
        _alertBtn.layer.borderColor = kUIColorFromRGB(0xb50029).CGColor;
        _alertBtn.layer.borderWidth = 0.5;
        _alertBtn.layer.cornerRadius = 4;
        [_alertBtn addTarget:self action:@selector(reloadNetworkDataSourcer) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_alertBtn];
        [_alertBtn setExclusiveTouch:YES];
        [_alertBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self->_alertLab.mas_bottom).with.offset(25);
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(@120);
            make.height.equalTo(@32);
        }];
    }
    return self;
}

- (void)reloadNetworkDataSourcer {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(refreshNetworkDataSource:)]) {
        [self.delegate performSelector:@selector(refreshNetworkDataSource:) withObject:nil];
    }
}
@end
