//
//  ProjectListModel.m
//  AllStars
//
//  Created by Mac on 2021/10/25.
//

#import "ProjectListModel.h"

@implementation ProjectListModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"desc":@"description",
             @"properInfo":@"property"
             };
}
@end
