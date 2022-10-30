//
//  MyCollectListCell.h
//  AllStars
//
//  Created by Mac on 2021/10/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyCollectListCell : UITableViewCell
@property(nonatomic,strong)UICollectionView *myCollectionView;
@property(nonatomic,strong)UILabel *titleL;
@end

NS_ASSUME_NONNULL_END
