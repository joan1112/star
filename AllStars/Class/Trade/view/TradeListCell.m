//
//  TradeListCell.m
//  AllStars
//
//  Created by Mac on 2021/10/11.
//

#import "TradeListCell.h"

@implementation TradeListCell

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
    
    
    UIImageView *pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 21, 63, 63)];
    pictureView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:pictureView];
    self.coverV = pictureView;
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.coverV.right+10, self.coverV.top+2, 100, 20)];
    [self.contentView addSubview:nameLabel];
    nameLabel.textColor = kUIColorFromRGB(0xFFE29E);
    nameLabel.font = [UIFont fontWithName:@"PingFang-SC-Heavy" size:18];
    self.titleL = nameLabel;
    
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.coverV.right+10, self.titleL.bottom+0, 200, 40)];
    textLabel.numberOfLines = 0;
    textLabel.textColor = kUIColorFromRGB(0xB3B3B3);
    textLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    [self.contentView addSubview:textLabel];
    self.contentL = textLabel;
    
    UIButton *getbtn = [Tool createButtonWithFrame:CGRectMake(KScreenWidth-90, 38, 75, 30) title:NSLocalizedString(@"立刻交易", nil) titleColor:CNavBgColor textFont:MYBOLDFONT(12) backgroudColor:[UIColor clearColor] target:self action:@selector(getAction)];
    UIImage *bg = [UIColor gradientImageWithView:getbtn fromColor:@"#C8AC7C" toColor:@"#F9EFBC" startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) cornerRadius:5];
    [getbtn setBackgroundImage:bg forState:UIControlStateNormal];
    [self.contentView addSubview:getbtn];
    self.getBtn = getbtn;
    
    UIView *line = [Tool createLinewithFrame:CGRectMake(15, 104, KScreenWidth-30, 1) alpha:1];
    line.backgroundColor = kUIColorFromRGB(0xE1CF9D);
    [self.contentView addSubview:line];
   
}
-(void)getAction{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
