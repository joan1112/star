//
//  GameListCell.m
//  AllStars
//
//  Created by Mac on 2021/10/11.
//

#import "GameListCell.h"

@implementation GameListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
// 重写初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

// 添加子控件
- (void)setupView {
    self.backgroundColor = CViewBgColor;
    UIView *contentV = [[UIView alloc]initWithFrame:CGRectMake(15, 15, KScreenWidth-30, 230)];
    contentV.backgroundColor = CNavBgColor;
    contentV.layer.cornerRadius = 7;
    contentV.layer.masksToBounds = YES;
    [self.contentView addSubview:contentV];
    
    UIImageView *pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth-30, 150)];
//    pictureView.contentMode = UIViewContentModeScaleAspectFill;
    pictureView.layer.borderColor = CLineColor.CGColor;
    pictureView.layer.borderWidth = 1;
    pictureView.layer.cornerRadius = 7;
    pictureView.layer.masksToBounds = YES;
    [contentV addSubview:pictureView];
    self.coverV = pictureView;
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 160, 200, 15)];
    [contentV addSubview:nameLabel];
    nameLabel.textColor = kUIColorFromRGB(0xFFE29E);
    nameLabel.font = [UIFont fontWithName:@"PingFang-SC-Heavy" size:15];
    [contentV addSubview:nameLabel];
    self.titleL = nameLabel;
    
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.titleL.bottom+0, contentV.width-30, 50)];
    textLabel.numberOfLines = 0;
    textLabel.textColor = kUIColorFromRGB(0xB3B3B3);
    textLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    [contentV addSubview:textLabel];
    self.contentL = textLabel;
    
 
   
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
