//
//  CreatWalletPopView.h
//  AllStars
//
//  Created by Mac on 2021/10/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol CreateWalletPopViewDelegate <NSObject>

-(void)createWalletAction;
-(void)importWalletAction;

@end

@interface CreatWalletPopView : UIView
@property(nonatomic,weak)id<CreateWalletPopViewDelegate>delegate;
-(void)showPopView;
- (void)hidePopView;
@end

NS_ASSUME_NONNULL_END
