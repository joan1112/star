//
//  WalletSendVC.m
//  AllStars
//
//  Created by Mac on 2021/11/8.
//

#import "WalletSendVC.h"
#import "AllStars-Swift.h"
#import "YBPopupMenu.h"
#import "SenderConfirmView.h"
@interface WalletSendVC ()<YBPopupMenuDelegate,SenderConfrimViewDelegate>
{
    UIView *typeBg;
    UILabel *typeLabel;
}
@property(nonatomic,strong)UIScrollView *scrollBg;

@property(nonatomic,strong)UITextField *addressT;
@property(nonatomic,strong)UITextField *moneyT;
@property(nonatomic,strong)UIButton *hightBtn;
@property(nonatomic,strong)UIButton *normalBtn;
@property(nonatomic,strong)UIButton *lowerBtn;
@property(nonatomic,strong)NSString *gasFee;
@property(nonatomic,strong)UIImageView *normalV;
@property(nonatomic,strong)UIImageView *lowerV;
@property(nonatomic,strong)UIImageView *hignV;
@property(nonatomic,strong)UILabel *balanceL;
@property(nonatomic,strong)NSString *currentMoney;
@property(nonatomic,strong)NSString *currentType;
@property(nonatomic,strong)NSString *inputPrice;

@end

@implementation WalletSendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发送";
    self.currentMoney = @"0";
    self.currentType = @"STAR";
    [self setSubViews];
    [self getBalanceWithType:0];

}
-(void)setSubViews{
    _scrollBg = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    [self.view addSubview:_scrollBg];
    _scrollBg.userInteractionEnabled = YES;
    _scrollBg.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [_scrollBg addGestureRecognizer:tap];
//    660
    _scrollBg.contentSize = CGSizeMake(KScreenWidth, 730);
    UIImageView *iconV = [Tool createImageViewWithFrame:CGRectMake((KScreenWidth-32)/2, 15, 32, 32) image:MYIMAGE(@"send_icon") placeholderImge:nil];
    [_scrollBg addSubview:iconV];
    
    UIView *line1 = [Tool createLinewithFrame:CGRectMake(15, iconV.bottom+30, 3, 11) alpha:1];
    line1.backgroundColor = CLineColor;
    [_scrollBg addSubview:line1];
    UILabel *title1 = [Tool createLabelWithFrame:CGRectMake(line1.right+5, iconV.bottom+25, 100, 21) textColor:[UIColor whiteColor] textFont:MYFONT(15) textAligion:NSTextAlignmentLeft labelText:NSLocalizedString(@"来自",nil)];
    [_scrollBg addSubview:title1];
    UILabel *title2 = [Tool createLabelWithFrame:CGRectMake(line1.right+5, title1.bottom+10, 100, 21) textColor:[UIColor whiteColor] textFont:MYFONT(15) textAligion:NSTextAlignmentLeft labelText:[UserInfoConfig shareManager].address];
    title2.lineBreakMode = NSLineBreakByTruncatingMiddle;
    [_scrollBg addSubview:title2];
    
    UIView *line2 = [Tool createLinewithFrame:CGRectMake(15, title2.bottom+25, 3, 11) alpha:1];
    line2.backgroundColor = CLineColor;
    [_scrollBg addSubview:line2];
    UILabel *title3 = [Tool createLabelWithFrame:CGRectMake(line2.right+5, title2.bottom+20, 100, 21) textColor:[UIColor whiteColor] textFont:MYFONT(15) textAligion:NSTextAlignmentLeft labelText:NSLocalizedString(@"發送到",nil)];
    [_scrollBg addSubview:title3];
    UIView *bgv1 = [Tool createLinewithFrame:CGRectMake(20, title3.bottom+10, KScreenWidth-40, 43) alpha:1];
    bgv1.layer.cornerRadius = 5;
    bgv1.layer.masksToBounds = YES;
    bgv1.backgroundColor = CNavBgColor;
    [_scrollBg addSubview:bgv1];
    self.addressT = [Tool createTextFieldWithFrame:CGRectMake(10, 0, bgv1.width-20, 43) placeholder:@"" target:self textColor:kUIColorFromRGB(0xfffffff)];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"請輸入正確的地址",nil) attributes:
         @{NSForegroundColorAttributeName:[UIColor lightGrayColor],
           NSFontAttributeName:[UIFont boldSystemFontOfSize:13]}
         ];
    self.addressT.attributedPlaceholder = attrString;
    [bgv1 addSubview:self.addressT];
    
    UIView *line3 = [Tool createLinewithFrame:CGRectMake(15, bgv1.bottom+25, 3, 11) alpha:1];
    line3.backgroundColor = CLineColor;
    [_scrollBg addSubview:line3];
    UILabel *title4 = [Tool createLabelWithFrame:CGRectMake(line3.right+5, bgv1.bottom+20, 100, 21) textColor:[UIColor whiteColor] textFont:MYFONT(15) textAligion:NSTextAlignmentLeft labelText:NSLocalizedString(@"幣種",nil)];
    [_scrollBg addSubview:title4];
    typeBg = [Tool createLinewithFrame:CGRectMake(20, title4.bottom+10, KScreenWidth-40, 43) alpha:1];
    typeBg.layer.cornerRadius = 5;
    typeBg.layer.masksToBounds = YES;
    typeBg.backgroundColor = CNavBgColor;
    [_scrollBg addSubview:typeBg];
    typeBg.userInteractionEnabled = YES;
    typeLabel = [Tool createLabelWithFrame:CGRectMake(10, 0, 80, 43) textColor:kUIColorFromRGB(0xfffffff) textFont:[UIFont systemFontOfSize:14] textAligion:NSTextAlignmentLeft labelText:self.currentType];
    [typeBg addSubview:typeLabel];
    
    UIImageView *row = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(typeBg.frame)-60, 8, 27,27)];
    [typeBg addSubview:row];
    row.image = [UIImage imageNamed:@"row_down"];

    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectType)];
    [typeBg addGestureRecognizer:gesture];
    
    UIView *line4 = [Tool createLinewithFrame:CGRectMake(15, typeBg.bottom+25, 3, 11) alpha:1];
    line4.backgroundColor = CLineColor;
    [_scrollBg addSubview:line4];
    UILabel *title5 = [Tool createLabelWithFrame:CGRectMake(line4.right+5, typeBg.bottom+20, 100, 21) textColor:[UIColor whiteColor] textFont:MYFONT(15) textAligion:NSTextAlignmentLeft labelText:NSLocalizedString(@"金額",nil)];
    [_scrollBg addSubview:title5];
    UIView *bgv3 = [Tool createLinewithFrame:CGRectMake(20, title5.bottom+10, KScreenWidth-40, 43) alpha:1];
    bgv3.layer.cornerRadius = 5;
    bgv3.layer.masksToBounds = YES;
    bgv3.backgroundColor = CNavBgColor;
    [_scrollBg addSubview:bgv3];
    self.moneyT = [Tool createTextFieldWithFrame:CGRectMake(10, 0, bgv3.width-20, 43) placeholder:@"" target:self textColor:kUIColorFromRGB(0xfffffff)];
    NSMutableAttributedString *attrString2 = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"請輸入金額",nil) attributes:
         @{NSForegroundColorAttributeName:[UIColor lightGrayColor],
           NSFontAttributeName:[UIFont boldSystemFontOfSize:13]}
         ];
    self.moneyT.attributedPlaceholder = attrString2;
    self.moneyT.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [bgv3 addSubview:self.moneyT];
    self.balanceL = [Tool createLabelWithFrame:CGRectMake(KScreenWidth-220, bgv3.bottom+5, 200, 21) textColor:[UIColor whiteColor] textFont:MYFONT(15) textAligion:NSTextAlignmentRight labelText:[NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"餘額",nil),@"0"]];
    [_scrollBg addSubview:self.balanceL];
    
    UIView *line5 = [Tool createLinewithFrame:CGRectMake(15, bgv3.bottom+40, 3, 11) alpha:1];
    line5.backgroundColor = CLineColor;
    [_scrollBg addSubview:line5];
    UILabel *title6 = [Tool createLabelWithFrame:CGRectMake(line5.right+5, bgv3.bottom+35, 100, 21) textColor:[UIColor whiteColor] textFont:MYFONT(15) textAligion:NSTextAlignmentLeft labelText:NSLocalizedString(@"礦工費",nil)];
    [_scrollBg addSubview:title6];
    UIView *bgv4 = [Tool createLinewithFrame:CGRectMake(20, title6.bottom+10, KScreenWidth-40, 50) alpha:1];
    bgv4.layer.cornerRadius = 5;
    bgv4.layer.masksToBounds = YES;
    bgv4.backgroundColor = kUIColorFromRGB(0x11171C);
    [_scrollBg addSubview:bgv4];
    
    UIView *v1 = [[UIView alloc]initWithFrame:CGRectMake(15, 9, bgv4.width-45, 32)];
    v1.backgroundColor = kUIColorFromRGB(0x1E2934);
    v1.layer.cornerRadius = 5;
    v1.layer.masksToBounds = YES;
    [bgv4 addSubview:v1];
    
    self.lowerV = [Tool createImageViewWithFrame:CGRectMake(v1.right+7.5, v1.top+7.5, 15, 15) image:MYIMAGE(@"choose_icon") placeholderImge:nil];
    self.lowerV.hidden = NO;
    [bgv4 addSubview:self.lowerV];
    
    
    UILabel *name1 = [Tool createLabelWithFrame:CGRectMake(10, 0, 50, 32) textColor:kUIColorFromRGB(0x999999) textFont:MYFONT(15) textAligion:NSTextAlignmentLeft labelText:NSLocalizedString(@"中",nil)];
    [v1 addSubview:name1];

    UILabel *name2 = [Tool createLabelWithFrame:CGRectMake(v1.width-120, 0,110, 32) textColor:kUIColorFromRGB(0x999999) textFont:MYFONT(15) textAligion:NSTextAlignmentRight labelText:@"0.00041BNB"];
    [v1 addSubview:name2];
 
    
    self.lowerBtn = [[UIButton alloc]initWithFrame:v1.bounds];
    self.lowerBtn.layer.cornerRadius = 5;
    self.lowerBtn.layer.masksToBounds = YES;
    [v1 addSubview:self.lowerBtn];
    self.lowerBtn.layer.borderColor = CLineColor.CGColor;
    self.lowerBtn.layer.borderWidth = 1;
    self.lowerV.hidden = NO;
    
    UIButton *sendBtn = [Tool createButtonWithFrame:CGRectMake(35, bgv4.bottom+50, KScreenWidth-70, 50) title:NSLocalizedString(@"發送",nil) titleColor:kUIColorFromRGB(0xfffffff) textFont:MYFONT(18) backgroudColor:CNavBgColor target:self action:@selector(sendAction)];
    sendBtn.layer.cornerRadius = 8;
    sendBtn.layer.masksToBounds = YES;
    [_scrollBg addSubview:sendBtn];
    HFLog(@"00--%f",sendBtn.frame.origin.y);
}

-(void)getBalanceWithType:(NSInteger)type
{
    if (type == 0) {
      
        coinTranstion *ct = [[coinTranstion alloc] init];
        ct.jsonDic = @{@"stlToken":stlToken,
                      @"from":[UserInfoConfig shareManager].address,
                      @"token":starToken
        };
        dispatch_queue_t concurrent_queue = dispatch_queue_create("come.stars", DISPATCH_QUEUE_CONCURRENT);
           dispatch_async(concurrent_queue, ^{
               NSString *star = [ct getTokenBalance];

               dispatch_async(dispatch_get_main_queue(), ^(){
                   self.balanceL.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"餘額",nil),star];
                   self.currentMoney = star;
               });
           });
        
    }else if (type==1){
        coinTranstion *ct = [[coinTranstion alloc] init];
        ct.jsonDic = @{@"stlToken":stlToken,
                      @"from":[UserInfoConfig shareManager].address,
                      @"token":starToken
        };
        dispatch_queue_t concurrent_queue = dispatch_queue_create("come.stars1", DISPATCH_QUEUE_CONCURRENT);
           dispatch_async(concurrent_queue, ^{
               NSString *stl = [ct getStlTokenBalance];
               dispatch_async(dispatch_get_main_queue(), ^(){
                   self.balanceL.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"餘額",nil),stl];
                   self.currentMoney = stl;

               });
           });
    }else{
        coinTranstion *ct = [[coinTranstion alloc] init];
        ct.jsonDic = @{@"stlToken":stlToken,
                      @"from":[UserInfoConfig shareManager].address,
                      @"token":starToken
        };
        dispatch_queue_t concurrent_queue = dispatch_queue_create("come.stars2", DISPATCH_QUEUE_CONCURRENT);
           dispatch_async(concurrent_queue, ^{
               NSString *balance = [ct getBalance];
               dispatch_async(dispatch_get_main_queue(), ^(){
                   self.balanceL.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"餘額",nil),balance];
                   self.currentMoney = balance;

               });
           });
    }
}
-(void)sendAction{
   
    if (![self deptAddressString:self.addressT.text]) {
        [self.view showToastWithText:NSLocalizedString(@"請輸入正確的地址", nil)];
        return;
    }
    NSString *price = [self.moneyT.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (price.length==0) {
        [self.view showToastWithText:NSLocalizedString(@"請輸入金額",nil)];
        return;
    }
    if(![self deptNumInputShouldNumber:price]){
        [self.view showToastWithText:NSLocalizedString(@"金額格式錯誤",nil)];
        return;
    }
    if ([price floatValue]<=0) {
        [self.view showToastWithText:NSLocalizedString(@"無效的金額",nil)];
        return;
    }
    if ([_currentMoney floatValue]<[price floatValue]) {
        [self.view showToastWithText:NSLocalizedString(@"餘額不足",nil)];
        return;
    }
  
  
    _inputPrice = price;
//    [self confirmAction];
    
    NSString *token = @"";
    if ([_currentType isEqualToString:@"STAR"]) {
        token = starToken;
    }else if([_currentType isEqualToString:@"STL"]){
        token = stlToken;
    }else{
        token = @"";
    }
    coinTranstion *ct = [[coinTranstion alloc] init];
    ct.jsonDic = @{@"to":self.addressT.text,
                   @"from":[UserInfoConfig shareManager].address,
                  @"value":price,
                  @"token":token
    };
    [self.view showHUD];
    dispatch_queue_t concurrent_queue = dispatch_queue_create("come.fee", DISPATCH_QUEUE_CONCURRENT);
       dispatch_async(concurrent_queue, ^{
           NSString *result = @"";
           if ([token isEqualToString:@""]) {
               result = [ct getMinerFee];

           }else{
               result = [ct getTokenMinerFee];

           }
           dispatch_async(dispatch_get_main_queue(), ^(){
               [self.view hideHUD];
               NSLog(@"-------------%@",result);
               if ([result containsString:@"err"]) {
                   [self.view showToastWithText:result];
                   return;
               }
                   SenderConfirmView *pop = [[SenderConfirmView alloc]initWithFrame:CGRectMake(35, (KScreenHeight-300)/2, KScreenWidth-70, 300)];
                   pop.delegate = self;
                   [pop setPrice:[NSString stringWithFormat:@"%@%@",self.inputPrice,self.currentType] toAdreee:self.addressT.text withMinerFee:result];
                   [pop showPopView];

           });
       });
    

    
    
}
-(void)confirmAction
{
    if ([_currentType isEqualToString:@"STAR"]) {
        [self transtionActionWithTo:self.addressT.text money:self.inputPrice token:starToken];
    }else if ([_currentType isEqualToString:@"STL"]){
        [self transtionActionWithTo:self.addressT.text money:self.inputPrice token:stlToken];
    }else{
        [self transtionActionWithTo:self.addressT.text money:self.inputPrice token:@""];
    }
}
-(void)selectType{
    [YBPopupMenu showRelyOnView:typeLabel titles:@[@"STAR",@"STL",@"BNB"] icons:@[] menuWidth:120 delegate:self];
}
#pragma mark YBPopupMenuDelegate
- (void)ybPopupMenu:(YBPopupMenu *)ybPopupMenu didSelectedAtIndex:(NSInteger)index
{
    [self getBalanceWithType:index];
    typeLabel.text = @[@"STAR",@"STL",@"BNB"][index];
    _currentType = @[@"STAR",@"STL",@"BNB"][index];
}
-(void)transtionActionWithTo:(NSString*)to money:(NSString*)price token:(NSString*)token{
    
    
    coinTranstion *ct = [[coinTranstion alloc] init];
    ct.jsonDic = @{@"to":to,
                   @"from":[UserInfoConfig shareManager].address,
                  @"value":price,
                  @"token":token
    };
    
    dispatch_queue_t concurrent_queue = dispatch_queue_create("come.stars2", DISPATCH_QUEUE_CONCURRENT);
    [self.view showHUD];
       dispatch_async(concurrent_queue, ^{
           NSString *result = @"";
           if ([token isEqualToString:@""]) {
               result = [ct transferBnb];

           }else{
               result = [ct transfer];
           }
           dispatch_async(dispatch_get_main_queue(), ^(){
               NSLog(@"-------------%@",result);
               [self.view hideHUD];
               [self.view  showToastWithText:result];
               self.moneyT.text = @"";

           });
       });
   
    
}
-(BOOL)deptAddressString:(NSString*)str{
    if (str.length == 0) {
         return NO;
     }
//    ^0x[a-fA-F0-9]{40}$
    NSString *reg = @"^0x[a-fA-F0-9]{40}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",reg];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;

}
- (BOOL)deptNumInputShouldNumber:(NSString *)str
{
   if (str.length == 0) {
        return NO;
    }
    NSString *regex = @"^(([0]|(0[.]\\d{0,}))|([1-9]\\d{0,9}(([.]\\d{0,})?)))?";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        HFLog(@"go");
        return YES;
    }
    return NO;
}
-(void)popCopyAction:(NSString*)str
{
    
}
-(void)dismiss
{
    [self.view endEditing:YES];
}
-(NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
     
    {
    NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
     
    if([newHexStr length]==1)
     
    hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
     
    else
     
    hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
}
@end
