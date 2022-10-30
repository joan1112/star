//
//  HomeCardListVewCell.h
//  AllStars
//
//  Created by Mac on 2021/10/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeCardListVewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UIImageView *frameV;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UITextView *contentL;

@end

NS_ASSUME_NONNULL_END
