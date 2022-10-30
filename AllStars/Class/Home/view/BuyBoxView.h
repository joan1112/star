//
//  BuyBoxView.h
//  AllStars
//
//  Created by Mac on 2021/10/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BuyBoxView : UIView

@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIButton *ruleBtn;
@property(nonatomic,strong)UILabel *nameL;
@property(nonatomic,strong)UILabel *priceL;
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)UIButton *minusBtn;
@property(nonatomic,strong)UILabel *countL;
@property(nonatomic,strong)UIButton *buyBtn;

@end

NS_ASSUME_NONNULL_END
