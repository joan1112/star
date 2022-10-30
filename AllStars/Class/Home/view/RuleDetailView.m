//
//  RuleDetailView.m
//  AllStars
//
//  Created by Mac on 2021/10/12.
//

#import "RuleDetailView.h"

@implementation RuleDetailView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.borderWidth = 1;
    self.bgView.layer.borderColor = kUIColorFromRGB(0xE1CF9D).CGColor;
    self.bgView.layer.cornerRadius = 15;
    self.bgView.layer.masksToBounds = YES;
    [self.closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
}
-(void)closeAction{
    [self removeFromSuperview];
}
@end
