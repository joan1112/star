//
//  HomeCardScrollView.h
//  AllStars
//
//  Created by Mac on 2021/10/14.
//

#import <UIKit/UIKit.h>
#import "HeroCardInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeCardScrollView : UIView
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSArray *dataArr;
@end

NS_ASSUME_NONNULL_END
