//
//  VerifyPassWordVC.m
//  AllStars
//
//  Created by Mac on 2021/11/2.
//

#import "VerifyPassWordVC.h"
#import "SetPasswordView.h"
#import "PassStatusView.h"

@interface VerifyPassWordVC ()<PassStatusViewDelegate>
@property (nonatomic, strong) SetPasswordView *setView;
@property (nonatomic, strong) PassStatusView *statusView;
@property(nonatomic,assign) BOOL beFisrt;
@end

@implementation VerifyPassWordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"验证PIN码", nil);
    UILabel *lable = [Tool createLabelWithFrame:CGRectMake(20, 40, 200, 30) textColor:kUIColorFromRGB(0xffffff) textFont:MYFONT(15) textAligion:NSTextAlignmentLeft labelText:NSLocalizedString(@"验证PIN码", nil)];
    [self.view addSubview:lable];
    
    [self.view addSubview:self.setView];
    [self.setView.textField becomeFirstResponder];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.beFisrt = !self.beFisrt;
    if (!self.beFisrt) {
        [self.setView.textField becomeFirstResponder];
    }else{
        [self.setView.textField resignFirstResponder];
    }
}
- (SetPasswordView *)setView
{
    if (!_setView)
    {
        _setView = [[SetPasswordView alloc]initWithFrame:CGRectMake(0, 85, KScreenWidth, 50)];
        __weak typeof(self) weakSelf = self;
        _setView.completionBlock = ^(NSString *password) {
            __strong typeof(weakSelf) strongSelf = weakSelf;

            [strongSelf.setView.textField endEditing:YES];
            
            strongSelf.statusView = [[PassStatusView alloc]initWithFrame:CGRectMake(35, (KScreenHeight-300)/2, KScreenWidth-70, 300)];
            strongSelf.statusView.delegate = strongSelf;
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"coinPass"] isEqualToString:password]) {
                strongSelf.statusView.success = YES;
                strongSelf.statusView.titleS = NSLocalizedString(@"验证成功", nil);
    
            }else{
                strongSelf.statusView.success = NO;
                strongSelf.statusView.titleS = NSLocalizedString(@"验证失败", nil);
            }
            [strongSelf.statusView showPopView];
        };
    }
    return _setView;
}
#pragma mark PassStatusViewDelegate
-(void)statusDoneAction:(BOOL)status{
    if (status) {
        if (self.isImport) {
            //开始导入
            ImPortWalletViewController *vc = [ImPortWalletViewController new];
            vc.password = [[NSUserDefaults standardUserDefaults]objectForKey:@"coinPass"];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            //开始创建
            CreateWalletController *vc = [CreateWalletController new];
            vc.passWord = [[NSUserDefaults standardUserDefaults]objectForKey:@"coinPass"];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        [self.setView.textField becomeFirstResponder];
    }
}
@end
