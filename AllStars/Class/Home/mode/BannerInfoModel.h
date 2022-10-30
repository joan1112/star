//
//  BannerInfoModel.h
//  AllStars
//
//  Created by Mac on 2021/12/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BannerInfoModel : NSObject
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *language;
@property (nonatomic,strong) NSString *desc;
@property (nonatomic,strong) NSString *weight;
@property (nonatomic,strong) NSString *link_url;
@property (nonatomic,strong) NSString *link_type;
@property (nonatomic,strong) NSString *link_img;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *link_direction;
@end

NS_ASSUME_NONNULL_END
