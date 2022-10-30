//
//  GameListCell.h
//  AllStars
//
//  Created by Mac on 2021/10/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GameListCell : UITableViewCell
@property(nonatomic,strong)UIImageView *coverV;
@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,strong)UILabel *contentL;
@property(nonatomic,strong)UIButton *getBtn;
@end

NS_ASSUME_NONNULL_END
