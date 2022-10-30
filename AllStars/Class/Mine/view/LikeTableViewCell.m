//
//  LikeTableViewCell.m
//  AllStars
//
//  Created by junqiang on 2022/3/3.
//

#import "LikeTableViewCell.h"

@implementation LikeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubView];
    }
    return self;
}
-(void)initSubView{
    UIView *bgV = [[UIView alloc]initWithFrame:CGRectMake(25, 0, KScreenWidth-50, 115)];
    bgV.backgroundColor = CNavBgColor;
    bgV.layer.cornerRadius = 5;
    bgV.layer.masksToBounds = YES;
    [self.contentView addSubview:bgV];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 40, KScreenWidth-36, 75)];
    view.backgroundColor = kUIColorFromRGB(0x11171C);
    [bgV addSubview:view];
    UIImageView *view1 = [Tool createImageViewWithFrame:CGRectMake((view.width/3-30)/2, 15, 30, 30) image:MYIMAGE(@"hero_icon") placeholderImge:nil];
    view1.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:view1];
    UIImageView *view2 = [Tool createImageViewWithFrame:CGRectMake(view.width/3+(view.width/3-30)/2, 15, 30, 30) image:MYIMAGE(@"house_icon") placeholderImge:nil];
    view2.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:view2];
    UIImageView *view3 = [Tool createImageViewWithFrame:CGRectMake(view.width/3*2+(view.width/3-30)/2, 15, 30, 30) image:MYIMAGE(@"pet_icon") placeholderImge:nil];
    view3.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:view3];
    self.heroL = [Tool createLabelWithFrame:CGRectMake(0, view1.bottom, view.width/3, 30) textColor:[UIColor whiteColor] textFont:MYFONT(12) textAligion:NSTextAlignmentCenter labelText:@"(---)"];
    
    [view addSubview:self.heroL];
    self.houseL = [Tool createLabelWithFrame:CGRectMake(view.width/3, view1.bottom, view.width/3, 30) textColor:[UIColor whiteColor] textFont:MYFONT(12) textAligion:NSTextAlignmentCenter labelText:@"(---)"];
    [view addSubview:self.houseL];
    self.petL = [Tool createLabelWithFrame:CGRectMake(view.width/3*2, view1.bottom, view.width/3, 30) textColor:[UIColor whiteColor] textFont:MYFONT(12) textAligion:NSTextAlignmentCenter labelText:@"(---)"];
    [view addSubview:self.petL];
    
    _foundBtn = [Tool createButtonWithFrame:CGRectMake(16, 0, 105, 40) title:NSLocalizedString(@"我的收藏", nil) titleColor:CLineColor textFont:MYFONT(19) backgroudColor:CNavBgColor target:self action:@selector(foundAction:)];
    [_foundBtn setImage:MYIMAGE(@"data_close") forState:UIControlStateSelected];
    [_foundBtn setImage:MYIMAGE(@"data_open") forState:UIControlStateNormal];

    [_foundBtn SG_imagePositionStyle:SGImagePositionStyleRight spacing:15 imagePositionBlock:^(UIButton *button) {
            ;
    }];
    [bgV addSubview:_foundBtn];
    NSString *filePath = [NSString stringWithFormat:@"%@/Documents/collectConfig.txt", NSHomeDirectory()];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    if (result) {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
        NSString *str = [dic objectForKey:@"collectStatus"];
        if (str.intValue == 1) {
//            [_foundBtn setImage:MYIMAGE(@"data_open") forState:UIControlStateNormal];
            
            _foundBtn.selected = NO;

            NSDictionary *dic1 = self.dataArr[1];
            NSDictionary *dic2 = self.dataArr[0];
            NSDictionary *dic3 = self.dataArr[2];
            self.heroL.text =[NSString stringWithFormat:@"(%@)",[dic1 objectForKey:@"num"]];
            self.houseL.text = [NSString stringWithFormat:@"(%@)",[dic2 objectForKey:@"num"]];
            self.petL.text = [NSString stringWithFormat:@"(%@)",[dic3 objectForKey:@"num"]];
        }else{
//            [_foundBtn setImage:MYIMAGE(@"data_close") forState:UIControlStateNormal];
            _foundBtn.selected = YES;

            self.heroL.text = @"(***)";
            self.houseL.text = @"(***)";
            self.petL.text = @"(***)";
        }
    }else{
        NSDictionary *dic = @{@"collectStatus":@"1"};
        [dic writeToFile:filePath atomically:YES];
    }
}
-(void)foundAction:(UIButton*)btn{
    btn.selected = !btn.selected;
    NSString *filePath = [NSString stringWithFormat:@"%@/Documents/collectConfig.txt", NSHomeDirectory()];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    if (btn.selected) {
        [dic setValue:@"0" forKey:@"collectStatus"];
        [dic writeToFile:filePath atomically:YES];
    }else{
        [dic setValue:@"1" forKey:@"collectStatus"];
        [dic writeToFile:filePath atomically:YES];
    }
    
    if (btn.selected) { //close
        self.heroL.text = @"(***)";
        self.houseL.text = @"(***)";
        self.petL.text = @"(***)";
    }else{
        NSDictionary *dic1 = self.dataArr[1];
        NSDictionary *dic2 = self.dataArr[0];
        NSDictionary *dic3 = self.dataArr[2];
        self.heroL.text =[NSString stringWithFormat:@"(%@)",[dic1 objectForKey:@"num"]];
        self.houseL.text = [NSString stringWithFormat:@"(%@)",[dic2 objectForKey:@"num"]];
        self.petL.text = [NSString stringWithFormat:@"(%@)",[dic3 objectForKey:@"num"]];
    }
  
}
-(void)setViewWithData:(NSArray*)data;
{
    self.dataArr = data;
    
    NSString *filePath = [NSString stringWithFormat:@"%@/Documents/collectConfig.txt", NSHomeDirectory()];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    if (result) {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
        NSString *str = [dic objectForKey:@"collectStatus"];
        if (str.intValue == 1) {
            NSDictionary *dic1 = data[1];
            NSDictionary *dic2 = data[0];
            NSDictionary *dic3 = data[2];
            self.heroL.text =[NSString stringWithFormat:@"(%@)",[dic1 objectForKey:@"num"]];
            self.houseL.text = [NSString stringWithFormat:@"(%@)",[dic2 objectForKey:@"num"]];
            self.petL.text = [NSString stringWithFormat:@"(%@)",[dic3 objectForKey:@"num"]];
        }else{

            self.heroL.text = @"(***)";
            self.houseL.text = @"(***)";
            self.petL.text = @"(***)";
        }
        
        
    }
           
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
