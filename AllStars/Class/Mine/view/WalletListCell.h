//
//  WalletListCell.h
//  AllStars
//
//  Created by Mac on 2021/11/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WalletListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgv;
@property (weak, nonatomic) IBOutlet UIView *titleV;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIButton *coBtn;
@property (weak, nonatomic) IBOutlet UIImageView *chooseV;

@end

NS_ASSUME_NONNULL_END
