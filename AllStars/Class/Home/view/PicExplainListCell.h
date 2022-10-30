//
//  PicExplainListCell.h
//  AllStars
//
//  Created by Mac on 2021/10/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol PicExplainListCellDelegate <NSObject>
/**
 * 点击UICollectionViewCell的代理方法
 */
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
@end
@interface PicExplainListCell : UITableViewCell
@property(nonatomic,weak)id<PicExplainListCellDelegate>delegate;
@property(nonatomic,strong)UICollectionView *myCollectionView;
@end

NS_ASSUME_NONNULL_END
