//
//  WeakProxy.h
//  AllStars
//
//  Created by junqiang on 2022/2/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeakProxy : NSObject
@property (weak,nonatomic,readonly)id target;
+ (instancetype)proxyWithTarget:(id)target;
- (instancetype)initWithTarget:(id)target;
@end

NS_ASSUME_NONNULL_END
