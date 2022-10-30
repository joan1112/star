//
//  LikeTableViewCell.h
//  AllStars
//
//  Created by junqiang on 2022/3/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol LikeCellDeleagte <NSObject>
-(void)collectHideData:(BOOL)value;
@end
@interface LikeTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *heroL;
@property(nonatomic,strong)UILabel *houseL;
@property(nonatomic,strong)UILabel *petL;
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)UIButton *foundBtn;
@property(nonatomic,weak)id<LikeCellDeleagte>delegate;
-(void)setViewWithData:(NSArray*)data;
@end

NS_ASSUME_NONNULL_END
