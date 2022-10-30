//
//  WalletInfoVC.m
//  AllStars
//
//  Created by Mac on 2021/11/25.
//

#import "WalletInfoVC.h"
#import "PopPrivateView.h"

@interface WalletInfoVC ()<PopPrivateViewDelegate>
@property(nonatomic,strong)PopPrivateView *popView;
@property(nonatomic,strong)UILabel *nameL;
@property(nonatomic,strong)UILabel *contentL;
@end

@implementation WalletInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =NSLocalizedString(@"钱包", nil);
    [self setSubView];
}
-(void)setSubView{
    self.nameL = [Tool createLabelWithFrame:CGRectMake(18, 10, 200, 25) textColor:CLineColor textFont:MYFONT(18) textAligion:NSTextAlignmentLeft labelText:[UserInfoConfig shareManager].address];
    self.nameL.lineBreakMode = NSLineBreakByTruncatingMiddle;
    [self.view addSubview:self.nameL];
    
    UIButton *copyAddress = [Tool createButtonWithFrame:CGRectMake(KScreenWidth-18-20, 12, 20, 20) normalImage:MYIMAGE(@"copy_yellow") selectImage:nil target:self action:@selector(copyAddressAction)];
    [self.view addSubview:copyAddress];
    
    UIView *publicView = [Tool createLinewithFrame:CGRectMake(18, self.nameL.bottom+10, KScreenWidth-36, 50) alpha:1];
    publicView.backgroundColor = CNavBgColor;
    publicView.layer.cornerRadius = 5;
    publicView.layer.masksToBounds = YES;
    [self.view addSubview:publicView];
    UIImageView *keyV = [Tool createImageViewWithFrame:CGRectMake(20, 10, 16, 30) image:MYIMAGE(@"key_yellow") placeholderImge:nil];
    keyV.contentMode = UIViewContentModeScaleAspectFill;
    [publicView addSubview:keyV];
    UILabel *titleL = [Tool createLabelWithFrame:CGRectMake(keyV.right+10, 15, 80, 20) textColor:[UIColor whiteColor] textFont:MYFONT(15) textAligion:NSTextAlignmentCenter labelText:NSLocalizedString(@"公钥", nil)];
    [publicView addSubview:titleL];
    self.contentL = [Tool createLabelWithFrame:CGRectMake(titleL.right+10, 0, KScreenWidth-220, 50) textColor:[UIColor whiteColor] textFont:MYFONT(12) textAligion:NSTextAlignmentLeft labelText:[UserInfoConfig shareManager].publickKey];
    self.contentL.numberOfLines = 2;
    [publicView addSubview:self.contentL];
    UIButton *copyPublic = [Tool createButtonWithFrame:CGRectMake(publicView.width-25-20, 15, 20, 20) normalImage:MYIMAGE(@"copy_icon") selectImage:nil target:self action:@selector(copyPublicAction)];
    [publicView addSubview:copyPublic];
    
    UIView *privateView = [Tool createLinewithFrame:CGRectMake(18, publicView.bottom+10, KScreenWidth-36, 50) alpha:1];
    privateView.backgroundColor = CNavBgColor;
    privateView.layer.cornerRadius = 5;
    privateView.layer.masksToBounds = YES;
    [self.view addSubview:privateView];
    UIImageView *lockV = [Tool createImageViewWithFrame:CGRectMake(20, 10, 16, 30) image:MYIMAGE(@"lock_yellow") placeholderImge:nil];
    lockV.contentMode = UIViewContentModeScaleAspectFill;
    [privateView addSubview:lockV];
    UILabel *titleL1 = [Tool createLabelWithFrame:CGRectMake(keyV.right+15, 15, 200, 20) textColor:[UIColor whiteColor] textFont:MYFONT(15) textAligion:NSTextAlignmentLeft labelText:NSLocalizedString(@"导出私钥", nil)];
    [privateView addSubview:titleL1];

    UIButton *jumpClick = [Tool createButtonWithFrame:CGRectMake(privateView.width-25-20, 15, 20, 20) normalImage:MYIMAGE(@"gloableRightIcon") selectImage:nil target:self action:@selector(jumpAction)];
    [privateView addSubview:jumpClick];
    
    
    UIButton *deleteBtn = [Tool createButtonWithFrame:CGRectMake(35, KScreenHeight-280, KScreenWidth-70, 50) normalImage:MYIMAGE(@"delete_white") selectImage:nil target:self action:@selector(deleteAction)];
    deleteBtn.layer.cornerRadius = 5;
    deleteBtn.layer.masksToBounds = YES;
    deleteBtn.backgroundColor = kUIColorFromRGB(0xFF1A1A);
    [self.view addSubview:deleteBtn];
    
    UIButton *popBtn = [[UIButton alloc]initWithFrame:CGRectMake(18, publicView.bottom+10, KScreenWidth-36, 50)];
    [popBtn addTarget:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:popBtn];
}

-(void)copyAddressAction{
    [self.view showToastWithText:NSLocalizedString(@"复制成功", nil)];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.nameL.text;
}
-(void)copyPublicAction{
    [self.view showToastWithText:NSLocalizedString(@"复制成功", nil)];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.contentL.text;
}
-(void)jumpAction{

}
-(void)deleteAction{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistpath = [paths objectAtIndex:0];
    NSLog(@"path = %@",plistpath);
    NSString *filename=[plistpath stringByAppendingPathComponent:@"/account.txt"];
    NSMutableArray *oldArr = @[].mutableCopy;
    NSMutableArray *newArr = @[].mutableCopy;
    oldArr = [NSArray arrayWithContentsOfFile:filename].mutableCopy;
    [oldArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = obj;
        if ([[dic objectForKey:@"address"] isEqualToString:[UserInfoConfig shareManager].address]) {
            [oldArr removeObject:obj];
        }
    }];
    newArr = oldArr;
    [newArr writeToFile:filename atomically:YES];
    if ([self.deletate respondsToSelector:@selector(backToUpdateUser)]) {
        [self.deletate backToUpdateUser];
    }
    [self.view showToastWithText:@"删除成功"];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
//    });
    
}
-(void)popAction{
    self.popView = [[PopPrivateView alloc]initWithFrame:CGRectMake(35, (KScreenHeight-300)/2, KScreenWidth-70, 300)];
    self.popView.delegate = self;
    self.popView.showL.text = [UserInfoConfig shareManager].privteKey;
    [self.popView showPopView];
}
-(void)popCopyAction:(NSString*)str{
    [self.view showToastWithText:NSLocalizedString(@"复制成功", nil)];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = str;
}
@end
