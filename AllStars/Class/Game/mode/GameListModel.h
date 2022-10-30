//
//  GameListModel.h
//  AllStars
//
//  Created by junqiang on 2022/2/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GameListModel : NSObject
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *des;
@property (nonatomic,strong) NSString *url;

@end

NS_ASSUME_NONNULL_END
