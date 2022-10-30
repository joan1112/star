//
//  PopUpView.h
//  AllStars
//
//  Created by Mac on 2021/12/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol PopUpViewDelegate <NSObject>
-(void)popUpJumpAction:(NSInteger)index;
@end

@interface PopUpView : UIView
@property (nonatomic, strong) UIImageView *contentV;
@property (nonatomic, weak) id<PopUpViewDelegate>delegate;
-(void)showPopView;
- (void)hidePopView;
@end

NS_ASSUME_NONNULL_END
