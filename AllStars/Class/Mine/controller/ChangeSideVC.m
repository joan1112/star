//
//  ChangeSideVC.m
//  AllStars
//
//  Created by Mac on 2021/10/13.
//

#import "ChangeSideVC.h"
#import "SideContentView.h"

@interface ChangeSideVC ()

@end

@implementation ChangeSideVC{
    SideContentView *firstV;
    SideContentView *secondV;
    SideContentView *thirdV;
    UIButton *changeBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"更换阵营";
    
    UILabel *titleL = [Tool createLabelWithFrame:CGRectMake(15, 0, 200, 60) textColor:[UIColor whiteColor] textFont:MYFONT(15) textAligion:NSTextAlignmentLeft labelText:@"当前阵营：暗潮"];
    [self.view addSubview:titleL];
    firstV = [[SideContentView alloc]initWithFrame:CGRectMake(0, 60, KScreenWidth, 120)];
    [self.view addSubview:firstV];
    secondV = [[SideContentView alloc]initWithFrame:CGRectMake(0, firstV.bottom+10, KScreenWidth, 120)];
    secondV.nameL.text = @"守护者";
    secondV.iconV.image = MYIMAGE(@"守护者");
    [self.view addSubview:secondV];
    thirdV = [[SideContentView alloc]initWithFrame:CGRectMake(0, secondV.bottom+10, KScreenWidth, 120)];
    thirdV.nameL.text = @"保护伞";
    thirdV.iconV.image = MYIMAGE(@"保护伞");
    [self.view addSubview:thirdV];

    changeBtn = [Tool createButtonWithFrame:CGRectMake((KScreenWidth-180)/2, thirdV.bottom+40, 180, 44) title:@"更换阵营" titleColor:CNavBgColor textFont:MYBOLDFONT(18) backgroudColor:[UIColor clearColor] target:self action:@selector(changeAction:)];
    UIImage *bg = [UIColor gradientImageWithView:changeBtn fromColor:@"#C8AC7C" toColor:@"#F9EFBC" startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) cornerRadius:5];
    [changeBtn setBackgroundImage:bg forState:UIControlStateNormal];
    [self.view addSubview:changeBtn];
    
    UIButton *but1 = [[UIButton alloc]initWithFrame:firstV.bounds];
    [but1 addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    but1.tag  = 1001;
    [firstV addSubview:but1];
    
    UIButton *but2 = [[UIButton alloc]initWithFrame:firstV.bounds];
    [but2 addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    but2.tag  = 1002;
    [secondV addSubview:but2];
    
    UIButton *but3 = [[UIButton alloc]initWithFrame:firstV.bounds];
    [but3 addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    but3.tag  = 1003;
    [thirdV addSubview:but3];
    
//    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseAction:)];
//    tap1.numberOfTapsRequired = 1;
//    UIView *view1 = [tap1 view];
//    view1.tag = 1001;
//    [firstV addGestureRecognizer:tap1];
//
//    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseAction:)];
//    tap2.numberOfTapsRequired = 1;
//    UIView *view2 = [tap2 view];
//    view2.tag = 1002;
//    [secondV addGestureRecognizer:tap2];
//
//    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseAction:)];
//    tap3.numberOfTapsRequired = 1;
//    UIView *view3 = [tap3 view];
//    view3.tag = 1003;
//    [thirdV addGestureRecognizer:tap3];
}

-(void)changeAction:(UIButton*)btn{
        
}
-(void)chooseAction:(UIButton*)tap{
//    UITapGestureRecognizer *sigleTap = (UITapGestureRecognizer*)tap;
    NSInteger value = tap.tag;
    
    if (value == 1001) {
        firstV.bgView.layer.borderColor = CLineColor.CGColor;
        secondV.bgView.layer.borderColor = CNavBgColor.CGColor;
        thirdV.bgView.layer.borderColor = CNavBgColor.CGColor;
        firstV.chooseV.hidden = NO;
        secondV.chooseV.hidden = YES;
        thirdV.chooseV.hidden = YES;
    }
    if (value == 1002) {
        firstV.bgView.layer.borderColor = CNavBgColor.CGColor;
        secondV.bgView.layer.borderColor = CLineColor.CGColor;
        thirdV.bgView.layer.borderColor = CNavBgColor.CGColor;
        firstV.chooseV.hidden = YES;
        secondV.chooseV.hidden = NO;
        thirdV.chooseV.hidden = YES;
    }
    if (value == 1003) {
        secondV.bgView.layer.borderColor = CNavBgColor.CGColor;
        firstV.bgView.layer.borderColor = CNavBgColor.CGColor;
        thirdV.bgView.layer.borderColor = CLineColor.CGColor;
        secondV.chooseV.hidden = YES;
        firstV.chooseV.hidden = YES;
        thirdV.chooseV.hidden = NO;
    }
}
@end
