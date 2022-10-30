//
//  PopViewInfoModel.h
//  AllStars
//
//  Created by Mac on 2021/12/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PopViewInfoModel : NSObject
@property (nonatomic,strong) NSString *postion;
@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *language;
@property (nonatomic,strong) NSString *desc;
@property (nonatomic,strong) NSString *link_url;
@property (nonatomic,strong) NSString *link_type;
@property (nonatomic,strong) NSString *link_img;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *pop_type;
@property (nonatomic,strong) NSString *pop_freq;
@property (nonatomic,strong) NSString *weight;
@end

NS_ASSUME_NONNULL_END
