//
//  InviteListCell.m
//  AllStars
//
//  Created by Mac on 2021/10/14.
//

#import "InviteListCell.h"

@implementation InviteListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.timeL = [Tool createLabelWithFrame:CGRectMake(0, 0, 90, 30) textColor:[UIColor whiteColor] textFont:MYFONT(10) textAligion:NSTextAlignmentLeft labelText:@"   2020-12-12"];
        [self.contentView addSubview:self.timeL];
        self.moneyL = [Tool createLabelWithFrame:CGRectMake(90, 0, 110, 30) textColor:[UIColor whiteColor] textFont:MYFONT(10) textAligion:NSTextAlignmentLeft labelText:@"   290000000NBN"];
        [self.contentView addSubview:self.moneyL];
        self.contentL = [Tool createLabelWithFrame:CGRectMake(200, 0, KScreenWidth-30-200, 30) textColor:[UIColor whiteColor] textFont:MYFONT(10) textAligion:NSTextAlignmentLeft labelText:@"   ++++++++++++++++++"];
        [self.contentView addSubview:self.contentL];
        
        self.line1 = [Tool createLinewithFrame:CGRectMake(90, 0, 1, 30) alpha:1];
        [self.contentView addSubview:self.line1];
        self.line2 = [Tool createLinewithFrame:CGRectMake(200, 0, 1, 30) alpha:1];
        [self.contentView addSubview:self.line2];
        self.line3 = [Tool createLinewithFrame:CGRectMake(0, 29, KScreenWidth-30, 1) alpha:1];
        [self.contentView addSubview:self.line3];
        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
