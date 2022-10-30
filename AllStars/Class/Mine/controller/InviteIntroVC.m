//
//  InviteIntroVC.m
//  AllStars
//
//  Created by junqiang on 2022/3/4.
//

#import "InviteIntroVC.h"
#import "InviteIntroView.h"
#import "InviteDetailVC.h"
@interface InviteIntroVC ()

@end

@implementation InviteIntroVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kUIColorFromRGB(0x040827);

    InviteIntroView *intro = [[InviteIntroView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:intro];
    kWeakSelf(self);
    intro.goToNext = ^(NSInteger type) {
        if (type==0) {//
            [weakself.navigationController popViewControllerAnimated:YES];
        }else{
            InviteDetailVC *detail = [[InviteDetailVC alloc]init];
            [weakself.navigationController pushViewController:detail animated:YES];
        }
    };


}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];

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
