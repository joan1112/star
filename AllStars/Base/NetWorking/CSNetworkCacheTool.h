//
//  CSNetworkCacheTool.h
//  ComeSpeak
//
//  Created by Beyondream on 2020/9/5.
//  Copyright © 2020 XiaoLaiYingCai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSNetworkCacheTool : NSObject


/**
 加载数据库中的数据_NSDocumentDirectory
 
 @param URLKey 路径
 */
+(NSDictionary *)selectNetworkDictWithURLKey:(NSString*)URLKey;


/**
 *  自动跟新或写入数据库_NSDocumentDirectory目录里
 *
 *  @param networkDict 文件
 *  @param URLKey      文件的url地址
 */
+(BOOL)saveNetworkDict:(NSDictionary *)networkDict withURLKey:(NSString *)URLKey;

@end
