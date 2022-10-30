//
//  PopPrivateView.h
//  AllStars
//
//  Created by Mac on 2021/12/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PopPrivateViewDelegate <NSObject>

-(void)popCopyAction:(NSString*)str;

@end

@interface PopPrivateView : UIView
@property(nonatomic,strong)NSString *valueS;
@property (nonatomic, strong) UILabel *showL;
@property(nonatomic,weak)id<PopPrivateViewDelegate>delegate;
-(void)showPopView;
- (void)hidePopView;
@end

NS_ASSUME_NONNULL_END
