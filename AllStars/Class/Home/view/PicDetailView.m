//
//  PicDetailView.m
//  AllStars
//
//  Created by Mac on 2021/10/13.
//

#import "PicDetailView.h"

@implementation PicDetailView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = CViewBgColor;
    
    self.bgV.backgroundColor = kUIColorFromRGB(0x341D11);
    self.bgV.layer.cornerRadius = 10;
    self.bgV.layer.masksToBounds = YES;
    self.bgV.layer.borderColor = CLineColor.CGColor;
    self.bgV.layer.borderWidth = 1;
}
@end
