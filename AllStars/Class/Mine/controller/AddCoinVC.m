//
//  AddCoinVC.m
//  AllStars
//
//  Created by Mac on 2021/12/9.
//

#import "AddCoinVC.h"

@interface AddCoinVC ()<UITextFieldDelegate>

@end

@implementation AddCoinVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加代币";
    [self setSubView];
}
-(void)setSubView{
    UIView *bgv = [[UIView alloc]initWithFrame:CGRectMake(18, 12, KScreenWidth-36, 38)];
    bgv.backgroundColor = kUIColorFromRGB(0x334052);
    bgv.layer.cornerRadius = 8;
    bgv.layer.borderColor = CLineColor.CGColor;
    bgv.layer.borderWidth = 1;
    bgv.layer.masksToBounds = YES;
    [self.view addSubview:bgv];
    UIImageView *iconV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 38)];
    iconV.layer.cornerRadius = 8;
    iconV.layer.masksToBounds = YES;
    UIImage *bg = [UIColor gradientImageWithView:iconV fromColor:@"#C8AC7C" toColor:@"#F9EFBC" startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) cornerRadius:5];
    iconV.backgroundColor = [UIColor colorWithPatternImage:bg];
    [bgv addSubview:iconV];
    
    UITextField *textF = [Tool createTextFieldWithFrame:CGRectMake(80, 0, bgv.width-80, 38) placeholder:@"请输入代币" target:self textColor:[UIColor whiteColor]];
    textF.delegate = self;
    [bgv addSubview:textF];
    
}

@end
