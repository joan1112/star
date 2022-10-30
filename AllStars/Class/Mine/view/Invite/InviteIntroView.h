//
//  InviteIntroView.h
//  AllStars
//
//  Created by junqiang on 2022/3/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InviteIntroView : UIView<UIScrollViewDelegate>
@property(nonatomic,copy)void(^goToNext)(NSInteger type);//0 back 1 next
@end

NS_ASSUME_NONNULL_END
