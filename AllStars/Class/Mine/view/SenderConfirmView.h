//
//  SenderConfirmView.h
//  AllStars
//
//  Created by junqiang on 2022/2/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol SenderConfrimViewDelegate <NSObject>

-(void)confirmAction;

@end
@interface SenderConfirmView : UIView
@property(nonatomic,strong)UILabel *priceLab;
@property (nonatomic, strong) UILabel *toAddressLab;
@property (nonatomic, strong) UILabel *minerFee;

@property(nonatomic,weak)id<SenderConfrimViewDelegate>delegate;
-(void)showPopView;
- (void)hidePopView;
-(void)setPrice:(NSString*)price toAdreee:(NSString*)address withMinerFee:(NSString*)fee;

@end

NS_ASSUME_NONNULL_END
