//
//  InviteDetailView.h
//  AllStars
//
//  Created by junqiang on 2022/3/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InviteDetailView : UIView
@property(nonatomic,copy)void(^inviteAction)(NSInteger type);//0 

@end

NS_ASSUME_NONNULL_END
