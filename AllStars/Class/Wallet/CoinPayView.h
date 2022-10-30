//
//  CoinPayView.h
//  AllStars
//
//  Created by Mac on 2021/11/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol CoinPayViewDelegate <NSObject>

-(void)payAction;
-(void)cancelAction;
@end

@interface CoinPayView : UIView
@property(nonatomic,weak)id<CoinPayViewDelegate>delegate;
@property(nonatomic,strong)NSDictionary *dataDic;
@property(nonatomic,strong)NSString *valueS;
- (void)showPopView;
@end

NS_ASSUME_NONNULL_END
