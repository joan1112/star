//
//  CSNetworkTool.h
//  ComeSpeak
//
//  Created by Beyondream on 2020/9/5.
//  Copyright © 2020 XiaoLaiYingCai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFHTTPSessionManager.h>
@interface CSNetworkTool : NSObject

@property (nonatomic,strong,readonly) AFHTTPSessionManager *manager;
/// 服务器地址
@property(nonatomic,copy)NSString *currentServerURL;

//appdelegate settingInfo
@property(nonatomic,strong)NSDictionary *settingInfo;

@property(nonatomic,copy)NSString *deviceToken;


+(instancetype)shareManager;

//-(void)configurationServer;

-(void)loadAppInitialData;

/// 获取UUID
+ (NSString *)getUUIDByKeyChain;

/// 获取缓存key
-(NSString *)returnURLCacheKeyWithMethodName:(NSString *) methodName parameter:(NSDictionary *)parameter withUUID:(BOOL)withUUID;

#pragma mark - 获取缓存方法

/**
 *  get 同步获取缓存
 *  本缓存方法的缓存的key由 调用者传入的parameter构成
 */
-(NSDictionary *)getCache:(NSString *)methodName
                parameter:(NSDictionary *)parameter
                   reload:(BOOL)reload;

/**
 *  post 同步获取缓存
 *  本缓存方法的缓存的key由 调用者传入的parameter构成
 */
-(NSDictionary *)postCache:(NSString *)methodName
                parameter:(NSDictionary *)parameter
                   reload:(BOOL)reload;

#pragma mark - 主流程服务器
/**
 *  get 主流程服务器
 */
-(void)getMethodName:(NSString *)methodName
            parameter:(NSDictionary *)parameter
              success:(void (^)(id responseObject,BOOL loadSuccess))success
              failure:(void (^)(NSError *error))failure;

/**
 *  post 主流程服务器
 */
-(void)postMethodName:(NSString *)methodName
            parameter:(NSDictionary *)parameter
               images:(NSMutableArray *)images
              success:(void (^)(id responseObject,BOOL loadSuccess))success
              failure:(void (^)(NSError *error))failure;
/**
 *  delete 主流程服务器
 */
-(void)deleteMethodName:(NSString *)methodName
            parameter:(NSDictionary *)parameter
              success:(void (^)(id responseObject,BOOL loadSuccess))success
              failure:(void (^)(NSError *error))failure;

/**
 *  Put 主流程服务器
 */
-(void)putMethodName:(NSString *)methodName
            parameter:(NSDictionary *)parameter
              success:(void (^)(id responseObject,BOOL loadSuccess))success
              failure:(void (^)(NSError *error))failure;

@end


