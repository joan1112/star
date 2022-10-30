//
//  CSNetworkCacheTool.m
//  ComeSpeak
//
//  Created by Beyondream on 2020/9/5.
//  Copyright © 2020 XiaoLaiYingCai. All rights reserved.
//

#import "CSNetworkCacheTool.h"
#import "FMDB.h"
//#import "MJExtension.h"


@implementation CSNetworkCacheTool

static FMDatabase *networkDB;
//存列表
+(void)initialize{
    
    // 用户信息 创表
    NSString *afilePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingString:@"/CSNetworkManager.db"];
    networkDB = [FMDatabase databaseWithPath:afilePath]; // 创建数据库
    if ([networkDB open]) {
        
        BOOL isSuccess = [networkDB executeUpdate:@"CREATE TABLE IF NOT EXISTS networkTable (id integer PRIMARY KEY AUTOINCREMENT,url text NOT NULL,networkData blob NOT NULL);"]; // 创建表
        if (isSuccess) {
            
        }else{
            
        }
    }
    
}


// 插入操作
+(BOOL)insertNetworkDict:(NSDictionary *)networkDict withURLKey:(NSString*)URLKey{
    
    NSData *networkData = [NSKeyedArchiver archivedDataWithRootObject:networkDict]; // 临时归档 networkDict 数据

    
    BOOL isSuccess = [networkDB executeUpdate:@"insert into networkTable (url,networkData) values(?,?);",URLKey,networkData];
    
    if (isSuccess) {
        //        NSLog(@"插入用户信息-成功");
        return YES;
    }else{
        //        NSLog(@"插入用户信息-失败");
        return NO;
    }
    
}

// 跟新 修改数据
+(BOOL)updateNetworkDict:(NSDictionary *)networkDict withURLKey:(NSString*)URLKey{
    
    NSData *networkData = [NSKeyedArchiver archivedDataWithRootObject:networkDict]; // 临时归档 networkDict 数据
    
    BOOL isSuccess = [networkDB executeUpdate:@"update networkTable set networkData=?  where url=?;",networkData,URLKey];
    
    
    if (isSuccess) {
        //        NSLog(@"更新用户信息-成功");
        return YES;
    }else{
        //        NSLog(@"更新用户信息-失败");
        return NO;
    }
    
}

// 简单查询 表中是否有该数据
+(BOOL)ishavingNetworkDictWithURLKey:(NSString*)URLKey{
    FMResultSet *set=[networkDB executeQuery:@"select * from networkTable where url =?;",URLKey];
    return [set next];
}


// 查询表中具体数据 __ 提供给外界使用
+(NSDictionary *)selectNetworkDictWithURLKey:(NSString*)URLKey{
    if (URLKey == nil || [URLKey isEqualToString:@""]){
        return nil;
    }
    
    FMResultSet *set = [networkDB executeQuery:@"select * from networkTable where url =?;",URLKey];
    
    //[set next] 让set向下偏移一位，指向下一个元素，当到到最后一个元素的时候，执行next方法，得到的是nil
    if ([set next]) {
        NSData *networkData = [set dataForColumn:@"networkData"]; // 取出 "networkData" 字段下的数据
        NSDictionary *networkDict = [NSKeyedUnarchiver unarchiveObjectWithData:networkData]; // 解档
        return networkDict;
    }else{
        return nil;
    }
    
}

// 存储数据 __ 提供给外界使用
+(BOOL)saveNetworkDict:(NSDictionary *)networkDict withURLKey:(NSString *)URLKey{
    if (URLKey == nil || [URLKey isEqualToString:@""]){
        return NO;
    }
    
    if ([self ishavingNetworkDictWithURLKey:URLKey]) {
        //更新
        [self updateNetworkDict:networkDict withURLKey:URLKey];
    }else{
        //插入
        [self insertNetworkDict:networkDict withURLKey:URLKey];
        
    }
    
    return YES;
}
@end
