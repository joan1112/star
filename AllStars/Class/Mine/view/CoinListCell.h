//
//  CoinListCell.h
//  AllStars
//
//  Created by Mac on 2021/12/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoinListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconV;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *valueL;

@end

NS_ASSUME_NONNULL_END
