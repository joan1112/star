//
//  InviteRewardView.h
//  AllStars
//
//  Created by junqiang on 2022/3/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InviteRewardView : UIView
@property(nonatomic,copy)void(^btnClick)(NSInteger type);//0apply 1 reward

@end

NS_ASSUME_NONNULL_END
