//
//  MineHeadView.h
//  AllStars
//
//  Created by Mac on 2021/10/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol MineHeadViewDelegate <NSObject>

-(void)headSetAction;
-(void)headRecvAction;
-(void)headSendAction;
-(void)headMoreAction;
-(void)hidenDataAction:(BOOL)value;
@end

@interface MineHeadView : UIView
@property(nonatomic,strong)id<MineHeadViewDelegate>delegate;
@property(nonatomic,strong)UILabel *nameL;
@property(nonatomic,strong)UIButton *foundBtn;
@end

NS_ASSUME_NONNULL_END
