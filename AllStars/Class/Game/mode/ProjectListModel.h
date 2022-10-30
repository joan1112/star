//
//  ProjectListModel.h
//  AllStars
//
//  Created by Mac on 2021/10/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProjectListModel : NSObject
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *tab;
@property (nonatomic,strong) NSString *desc;
@property (nonatomic,strong) NSString *linkUrl;
@property (nonatomic,strong) NSString *sort;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *imageUrl;
@property (nonatomic,strong) NSString *name;
@end

NS_ASSUME_NONNULL_END
