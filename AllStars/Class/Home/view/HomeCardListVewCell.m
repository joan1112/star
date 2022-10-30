//
//  HomeCardListVewCell.m
//  AllStars
//
//  Created by Mac on 2021/10/14.
//

#import "HomeCardListVewCell.h"

@implementation HomeCardListVewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = CNavBgColor;
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
}

@end
