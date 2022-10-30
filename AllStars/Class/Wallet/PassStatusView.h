//
//  PassStatusView.h
//  AllStars
//
//  Created by Mac on 2021/10/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol PassStatusViewDelegate <NSObject>
-(void)statusDoneAction:(BOOL)status;

@end

@interface PassStatusView : UIView
@property(nonatomic,assign)BOOL success;
@property(nonatomic,strong)NSString *titleS;
@property(nonatomic,weak)id<PassStatusViewDelegate>delegate;
-(void)showPopView;
- (void)hidePopView;
@end

NS_ASSUME_NONNULL_END
