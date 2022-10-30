//
//  WalletListCell.m
//  AllStars
//
//  Created by Mac on 2021/11/8.
//

#import "WalletListCell.h"

@implementation WalletListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleV.layer.cornerRadius = 5;
    self.titleV.layer.masksToBounds = YES;
    self.bgv.layer.cornerRadius = 8;
    self.bgv.layer.masksToBounds  = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
