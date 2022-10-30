//
//  InviteDetailVC.m
//  AllStars
//
//  Created by junqiang on 2022/3/4.
//

#import "InviteDetailVC.h"
#import "InviteDetailView.h"
#import "InvitePopSuccessView.h"
#import "AddFriendAlertView.h"
@interface InviteDetailVC ()

@end

@implementation InviteDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubView];
    
   
}


-(void)backBtnClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)loadSubView{
    InviteDetailView *detail = [[InviteDetailView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:detail];
    detail.inviteAction = ^(NSInteger type) {
        if (type==0) {
            InvitePopSuccessView *pop = [[InvitePopSuccessView alloc]initWithFrame:self.view.frame withMsg:@"Congrats on completing the tutorial!"];
            [pop showPopView];
        }else  if (type==3) {
            AddFriendAlertView *pop = [[AddFriendAlertView alloc]initWithFrame:self.view.frame withType:0];
            [pop showPopView];
        }else  if (type==4) {
            AddFriendAlertView *pop = [[AddFriendAlertView alloc]initWithFrame:self.view.frame withType:1];
            [pop showPopView];
        }else  if (type==2) {
            AddFriendAlertView *pop = [[AddFriendAlertView alloc]initWithFrame:self.view.frame withType:1];
            [pop showPopView];
        }
        else  if (type==5) {
            AddFriendAlertView *pop = [[AddFriendAlertView alloc]initWithFrame:self.view.frame withType:0];
            [pop showPopView];
        }
       
       
        
        
    };
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
