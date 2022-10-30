//
//  AddFriendAlertView.h
//  AllStars
//
//  Created by junqiang on 2022/3/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddFriendAlertView : UIView
-(instancetype)initWithFrame:(CGRect)frame withType:(NSInteger)type;

-(void)showPopView;
- (void)hidePopView;
@end

NS_ASSUME_NONNULL_END
