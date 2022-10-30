//
//  HeroCardInfoModel.m
//  AllStars
//
//  Created by Mac on 2021/10/25.
//

#import "HeroCardInfoModel.h"

@implementation HeroCardInfoModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"ID" : @"id",
             @"desc":@"description",
             @"properInfo":@"property"
             };
}
@end
