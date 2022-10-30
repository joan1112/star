//
//  ConfirmPassWordVC.m
//  AllStars
//
//  Created by Mac on 2021/10/30.
//

#import "ConfirmPassWordVC.h"
#import "SetPasswordView.h"
#import "PassStatusView.h"

@interface ConfirmPassWordVC ()<PassStatusViewDelegate>
@property (nonatomic, strong) SetPasswordView *setView;
@property (nonatomic, strong) PassStatusView *statusView;
@property(nonatomic,assign) BOOL beFisrt;
@end

@implementation ConfirmPassWordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =NSLocalizedString(@"设置PIN码", nil);
    UILabel *lable = [Tool createLabelWithFrame:CGRectMake(20, 40, 200, 30) textColor:kUIColorFromRGB(0xffffff) textFont:MYFONT(15) textAligion:NSTextAlignmentLeft labelText:NSLocalizedString(@"重复PIN码", nil)];
    [self.view addSubview:lable];
    
    [self.view addSubview:self.setView];
    
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
            if ([strongSelf.passWord isEqualToString:password]) { //验证正确
                [[NSUserDefaults standardUserDefaults]setObject:password forKey:@"coinPass"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                strongSelf.statusView.success = YES;
                strongSelf.statusView.titleS =NSLocalizedString(@"设置成功", nil);
            }else{
                strongSelf.statusView.success = NO;
                strongSelf.statusView.titleS =NSLocalizedString(@"密码设置不一致", nil);
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
            ImPortWalletViewController *vc = [ImPortWalletViewController new];
            vc.password = [[NSUserDefaults standardUserDefaults]objectForKey:@"coinPass"];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            CreateWalletController *vc = [CreateWalletController new];
            vc.passWord = [[NSUserDefaults standardUserDefaults]objectForKey:@"coinPass"] ;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        [self.setView.textField becomeFirstResponder];
    }
}
@end
