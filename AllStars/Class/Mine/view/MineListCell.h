//
//  MineListCell.h
//  AllStars
//
//  Created by junqiang on 2022/3/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subTitles;
@property (weak, nonatomic) IBOutlet UILabel *titleLabs;

@end

NS_ASSUME_NONNULL_END
