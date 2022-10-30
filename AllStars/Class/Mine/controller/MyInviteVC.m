//
//  MyInviteVC.m
//  AllStars
//
//  Created by Mac on 2021/10/13.
//

#import "MyInviteVC.h"
#import "InviteRewardView.h"
#import "InviteIntroVC.h"
@interface MyInviteVC ()

@end

@implementation MyInviteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"邀請獎勵", nil);
    InviteRewardView *rewardView = [[InviteRewardView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    [self.view addSubview:rewardView];
    
    rewardView.btnClick = ^(NSInteger type) {
        InviteIntroVC *vc = [[InviteIntroVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    

}



@end
