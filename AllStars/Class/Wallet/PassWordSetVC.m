//
//  PassWordSetVC.m
//  AllStars
//
//  Created by Mac on 2021/10/30.
//

#import "PassWordSetVC.h"
#import "SetPasswordView.h"
#import "ConfirmPassWordVC.h"

@interface PassWordSetVC ()
@property (nonatomic, strong) SetPasswordView *setView;
@property(nonatomic,assign) BOOL beFisrt;
@end

@implementation PassWordSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =NSLocalizedString(@"设置PIN码", nil);
    
    UILabel *lable = [Tool createLabelWithFrame:CGRectMake(20, 40, 200, 30) textColor:kUIColorFromRGB(0xffffff) textFont:MYFONT(15) textAligion:NSTextAlignmentLeft labelText:NSLocalizedString(@"创建一个PIN码", nil)];
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
            ConfirmPassWordVC *vc = [ConfirmPassWordVC new];
            vc.passWord = password;
            vc.isImport = strongSelf.isImport;
            [strongSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    return _setView;
}


@end
