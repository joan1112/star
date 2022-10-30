//
//  CSNetworkTool.m
//  ComeSpeak
//
//  Created by Beyondream on 2020/9/5.
//  Copyright © 2020 XiaoLaiYingCai. All rights reserved.
//

#import "CSNetworkTool.h"
#import "CSNetworkConfig.h"
#import "CSNetworkCacheTool.h"
@interface CSNetworkTool ()

/// 记录本地和服务器的时间差
@property(nonatomic,assign)NSTimeInterval timeOffset;

@end

@implementation CSNetworkTool

+(instancetype)shareManager{

    static CSNetworkTool *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]  init];
    });
    return manager;
}

-(instancetype)init{
    if (self = [super init]) {
        _manager = [AFHTTPSessionManager manager];
//        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
//        _manager.requestSerializer.timeoutInterval = 40.f;
        AFJSONResponseSerializer *serialize = [AFJSONResponseSerializer serializer];
        serialize.removesKeysWithNullValues = YES;
        serialize.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"image/jpeg",@"text/plain", nil];
        _manager.responseSerializer = serialize;
        self.currentServerURL = mainServerURL;
    }
    return self;
}

#pragma mark -
#pragma mark -获取接口缓存
-(NSDictionary *)getCache:(NSString *)methodName
                parameter:(NSDictionary *)parameter
                   reload:(BOOL)reload{
    
    
    if (reload) {//是否要刷新数据
        [self getMethodName:methodName parameter:parameter success:nil failure:nil];
    }
    
    NSString *URLCacheKey = [self returnURLCacheKeyWithMethodName:methodName parameter:parameter withUUID:YES];
    NSString *URLCacheKey2 = [self returnURLCacheKeyWithMethodName:methodName parameter:parameter withUUID:NO];
    
    NSDictionary *cacheDict = nil;
    
    if ([CSNetworkCacheTool selectNetworkDictWithURLKey:URLCacheKey]) {
        cacheDict = [CSNetworkCacheTool selectNetworkDictWithURLKey:URLCacheKey];
    }else if([CSNetworkCacheTool selectNetworkDictWithURLKey:URLCacheKey2]){
        cacheDict = [CSNetworkCacheTool selectNetworkDictWithURLKey:URLCacheKey2];
    }else{
    }
    
    return cacheDict;
    
}

/**
 *  post 同步获取缓存
 *  本缓存方法的缓存的key由 调用者传入的parameter构成
 */
-(NSDictionary *)postCache:(NSString *)methodName
                parameter:(NSDictionary *)parameter
                    reload:(BOOL)reload {
    if (reload) {//是否要刷新数据
        [self postMethodName:methodName parameter:parameter images:nil success:nil failure:nil];
    }
    
    NSString *URLCacheKey = [self returnURLCacheKeyWithMethodName:methodName parameter:parameter withUUID:YES];
    NSString *URLCacheKey2 = [self returnURLCacheKeyWithMethodName:methodName parameter:parameter withUUID:NO];
    
    NSDictionary *cacheDict = nil;
    
    if ([CSNetworkCacheTool selectNetworkDictWithURLKey:URLCacheKey]) {
        cacheDict = [CSNetworkCacheTool selectNetworkDictWithURLKey:URLCacheKey];
    }else if([CSNetworkCacheTool selectNetworkDictWithURLKey:URLCacheKey2]){
        cacheDict = [CSNetworkCacheTool selectNetworkDictWithURLKey:URLCacheKey2];
    }else{
    }
    
    return cacheDict;
}


#pragma mark -
#pragma mark -GET POST
/** GET对象方法 */
-(void)getMethodName:(NSString *)methodName
                     parameter:(NSDictionary *)parameter
                       success:(void (^)(id responseObject,BOOL loadSuccess))success
                       failure:(void (^)(NSError *error))failure{
    
    NSString *URLCacheKey = [self returnURLCacheKeyWithMethodName:methodName parameter:parameter withUUID:YES];

    //添加基础参数
   // NSMutableDictionary *resultParams = [self addBaseDataForParameter:parameter];
    
    //md5加密并往字典 添加sign签名
   // NSString *signString = [CSMD5Tool MD5Parameter:resultParams];
    //[resultParams setValue:signString forKey:@"sign"];

    NSString *URL = [NSString stringWithFormat:@"%@%@", self.currentServerURL,methodName];
    
    [self logGetParameters:parameter.mutableCopy url:URL];
    
    [self.manager GET:URL parameters:parameter headers:[CSNetworkTool getHTTPRequestHeadersWithURL:methodName] progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        /// token 失效
        if ([responseObject[@"code"] integerValue] == 401) {
//            [[CSRouteManager defaultManager] presentLoginViewController:nil animated:YES completion:nil];
            return;
        }
        
        //if ([self checkLoginOutState:responseObject]) return ;
        BOOL loadSuccess = [responseObject[@"code"] integerValue] == 200;

        ////// JUST FOR LOGIN
//        if (responseObject[@"access_token"] && [methodName isEqualToString:CS_USER_LOGIN_URL]) {
//            loadSuccess = YES;
//        }
        
        if (loadSuccess)
            [CSNetworkCacheTool saveNetworkDict:responseObject withURLKey:URLCacheKey];

        if (success) {
           success(responseObject,loadSuccess);
       }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if ([error.localizedDescription containsString:@"(401)"]) {
            
            if ([[UIApplication sharedApplication].delegate.window.rootViewController isKindOfClass:[UITabBarController class]]) {
//                [[CSUserModelManager sharedManager] loginoutAndNeedLogin:YES];
            }
            return;
        }
        if (failure) {
            failure(error);
        }
    }];

}

-(void)postMethodName:(NSString *)methodName
                      parameter:(NSDictionary *)parameter
                         images:(NSMutableArray *)images
                        success:(void (^)(id responseObject,BOOL loadSuccess))success
                        failure:(void (^)(NSError *error))failure{
    NSString *URLCacheKey = [self returnURLCacheKeyWithMethodName:methodName parameter:parameter withUUID:YES];
    //添加基础参数
    //NSMutableDictionary *resultParams = [self addBaseDataForParameter:parameter];

    //md5加密并往字典 添加sign签名
//    NSString *signString = [CSMD5Tool MD5Parameter:resultParams];
//    [resultParams setValue:signString forKey:@"sign"];
    NSString *URL=@"";
    if ([methodName isEqualToString:@"/app-api/collect/get_published_banner"]||[methodName isEqualToString:URL_getCardCount]) {
        URL =  [NSString stringWithFormat:@"%@%@", @"https://m.allstarplay.games",methodName];
    }else{
        URL =  [NSString stringWithFormat:@"%@%@", self.currentServerURL,methodName];

    }
//    NSString *URL = [NSString stringWithFormat:@"%@%@", self.currentServerURL,methodName];

//    [self logPostParameters:parameter.mutableCopy url:URL];
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"myLanguage"];
    
    if ([str hasPrefix:@"zh"]) {
        str = @"zh_CN";
    }else{
        str = @"en_US";
    }
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:URL parameters:nil error:nil];
    request.timeoutInterval = 40;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"0" forHTTPHeaderField:@"client-Type"];
    [request setValue:str forHTTPHeaderField:@"language"];
    
    if ([URL containsString:@"v2/star/hash/add"]) {
        NSDictionary *dic = @{@"address":parameter[@"address"],
                              @"hash":parameter[@"hash"],
                              @"status":parameter[@"status"]
        };
        if (dic)[request setHTTPBody:[NSJSONSerialization dataWithJSONObject:dic options:NSUTF8StringEncoding error:nil]];
    }else{
        if (parameter) [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:parameter options:NSUTF8StringEncoding error:nil]];
    }
    
    HFLog(@"%@",URL);
    

    [[CSNetworkTool getHTTPRequestHeadersWithURL:methodName] enumerateKeysAndObjectsUsingBlock:^(NSString * key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [request setValue:[[CSNetworkTool getHTTPRequestHeadersWithURL:methodName] valueForKey:key] forHTTPHeaderField:key];
    }];
    
    [[self.manager dataTaskWithRequest:request uploadProgress:^(NSProgress *  uploadProgress) {
            
        } downloadProgress:^(NSProgress *  downloadProgress) {
            
        } completionHandler:^(NSURLResponse *  response, id   responseObject, NSError *  error) {
            if (error) {
                
                if ([error.localizedDescription containsString:@"(401)"]) {
                    
                    if ([[UIApplication sharedApplication].delegate.window.rootViewController isKindOfClass:[UITabBarController class]]) {
//                        [[CSUserModelManager sharedManager] loginoutAndNeedLogin:YES];
                    }
                    return;
                }
                
                if (failure) {
                    failure(error);
                }
            }else {
                /// token 失效
                if ([responseObject[@"code"] integerValue] == 401) {
//                    [[CSRouteManager defaultManager] presentLoginViewController:nil animated:YES completion:nil];
                    return;
                }
                //if ([self checkLoginOutState:responseObject]) return ;
                BOOL loadSuccess = [responseObject[@"code"] integerValue] == 200;
                ////// JUST FOR LOGIN
//                if (responseObject[@"access_token"] && [methodName isEqualToString:CS_USER_LOGIN_URL]) {
//                    loadSuccess = YES;
//                }
                HFLog(@"%@",responseObject);
                
                if (loadSuccess)
                    [CSNetworkCacheTool saveNetworkDict:responseObject withURLKey:URLCacheKey];
                
                if (success) {
                    success(responseObject,loadSuccess);
                }
            }
    }] resume];

}

-(void)deleteMethodName:(NSString *)methodName
            parameter:(NSDictionary *)parameter
              success:(void (^)(id responseObject,BOOL loadSuccess))success
                failure:(void (^)(NSError *error))failure {

    NSString *URL = [NSString stringWithFormat:@"%@%@", self.currentServerURL,methodName];

    [self logPostParameters:parameter.mutableCopy url:URL];
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"DELETE" URLString:URL parameters:nil error:nil];
    request.timeoutInterval = 40;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    if (parameter) [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:parameter options:NSUTF8StringEncoding error:nil]];
    
    [[CSNetworkTool getHTTPRequestHeadersWithURL:methodName] enumerateKeysAndObjectsUsingBlock:^(NSString * key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [request setValue:[[CSNetworkTool getHTTPRequestHeadersWithURL:methodName] valueForKey:key] forHTTPHeaderField:key];
    }];
    
    [[self.manager dataTaskWithRequest:request uploadProgress:^(NSProgress *  uploadProgress) {
            
        } downloadProgress:^(NSProgress *  downloadProgress) {
            
        } completionHandler:^(NSURLResponse *  response, id   responseObject, NSError *  error) {
            if (error) {
                if ([error.localizedDescription containsString:@"(401)"]) {
                    
                    if ([[UIApplication sharedApplication].delegate.window.rootViewController isKindOfClass:[UITabBarController class]]) {
//                        [[CSUserModelManager sharedManager] loginoutAndNeedLogin:YES];
                    }
                    return;
                }
                if (failure) {
                    failure(error);
                }
            }else {
                /// token 失效
                if ([responseObject[@"code"] integerValue] == 401) {
//                    [[CSRouteManager defaultManager] presentLoginViewController:nil animated:YES completion:nil];
                    return;
                }
                //if ([self checkLoginOutState:responseObject]) return ;
                BOOL loadSuccess = [responseObject[@"code"] integerValue] == 200;
                ////// JUST FOR LOGIN
//                if (responseObject[@"access_token"] && [methodName isEqualToString:CS_USER_LOGIN_URL]) {
//                    loadSuccess = YES;
//                }
                
                if (success) {
                    success(responseObject,loadSuccess);
                }
            }
    }] resume];
}

-(void)putMethodName:(NSString *)methodName
            parameter:(NSDictionary *)parameter
              success:(void (^)(id responseObject,BOOL loadSuccess))success
             failure:(void (^)(NSError *error))failure {
    NSString *URLCacheKey = [self returnURLCacheKeyWithMethodName:methodName parameter:parameter withUUID:YES];

    NSString *URL = [NSString stringWithFormat:@"%@%@", self.currentServerURL,methodName];

    [self logPostParameters:parameter.mutableCopy url:URL];
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"PUT" URLString:URL parameters:nil error:nil];
    request.timeoutInterval = 40;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    if (parameter) [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:parameter options:NSUTF8StringEncoding error:nil]];
    
    [[CSNetworkTool getHTTPRequestHeadersWithURL:methodName] enumerateKeysAndObjectsUsingBlock:^(NSString * key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [request setValue:[[CSNetworkTool getHTTPRequestHeadersWithURL:methodName] valueForKey:key] forHTTPHeaderField:key];
    }];
    
    [[self.manager dataTaskWithRequest:request uploadProgress:^(NSProgress *  uploadProgress) {
            
        } downloadProgress:^(NSProgress *  downloadProgress) {
            
        } completionHandler:^(NSURLResponse *  response, id   responseObject, NSError *  error) {
            if (error) {
                if ([error.localizedDescription containsString:@"(401)"]) {
                    
                    if ([[UIApplication sharedApplication].delegate.window.rootViewController isKindOfClass:[UITabBarController class]]) {
//                        [[CSUserModelManager sharedManager] loginoutAndNeedLogin:YES];
                    }
                    return;
                }
                if (failure) {
                    failure(error);
                }
            }else {
                /// token 失效
                if ([responseObject[@"code"] integerValue] == 401) {
//                    [[CSRouteManager defaultManager] presentLoginViewController:nil animated:YES completion:nil];
                    return;
                }
                //if ([self checkLoginOutState:responseObject]) return ;
                BOOL loadSuccess = [responseObject[@"code"] integerValue] == 200;
                ////// JUST FOR LOGIN
//                if (responseObject[@"access_token"] && [methodName isEqualToString:CS_USER_LOGIN_URL]) {
//                    loadSuccess = YES;
//                }
                
                if (loadSuccess)
                    [CSNetworkCacheTool saveNetworkDict:responseObject withURLKey:URLCacheKey];
                
                if (success) {
                    success(responseObject,loadSuccess);
                }
            }
    }] resume];
}

#pragma mark -
#pragma mark -数据处理方法


-(NSString *)returnURLCacheKeyWithMethodName:(NSString *) methodName parameter:(NSDictionary *)parameter withUUID:(BOOL)withUUID{
    
    NSMutableDictionary *newParameter = [parameter mutableCopy];
    if (newParameter == nil) {
        newParameter = [NSMutableDictionary dictionary];
    }
    NSMutableString *urlKey = nil;
    
    urlKey = [NSMutableString stringWithFormat:@"%@%@?", self.currentServerURL,methodName];
    
    if (withUUID) {
//        [newParameter setValue:[CSUserModelManager sharedManager].currentUserId forKey:@"uuid"];
    }else{
        [newParameter setValue:@"" forKey:@"uuid"];
    }
    
    [newParameter enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [urlKey appendFormat:@"%@=%@&",key,obj];
    }];
    [urlKey deleteCharactersInRange:NSMakeRange(urlKey.length - 1, 1)];
    
    return urlKey;
    
}


//-(NSMutableDictionary *)addBaseDataForParameter:(NSDictionary *)parameter{
//
//    NSMutableDictionary *resultParams = [[NSMutableDictionary alloc] init];
//
//    [resultParams addEntriesFromDictionary:parameter];
//
//    NSString *userId = [CSUserModelManager sharedManager].currentUserId;
//    NSString *loginMark = [CSUserModelManager sharedManager].currentUserModel.fLoginMark ? [CSUserModelManager sharedManager].currentUserModel.fLoginMark : @"";
//    [resultParams addEntriesFromDictionary: @{
//        @"fuid" : userId,
//        @"loginMark":loginMark,
//        @"comeFrom" : @"1",
//        @"bundleid" : [[NSBundle mainBundle] bundleIdentifier],
//        @"TDID" : self.deviceToken ? self.deviceToken : @"",
//        @"udid":self.deviceToken ? self.deviceToken : @"",
//        @"ver" : kVersion,
//        @"channelId" : @"AppStore",
//        @"timestamp" : [self getTimestamp] ? [self getTimestamp] : @"",
//        @"UUID":[[[UIDevice currentDevice] identifierForVendor] UUIDString]
//    }];
//    return resultParams;
//
//}


-(NSString *)getTimestamp{
    
    //记录本地和服务器的时间差
    NSDate *localNowDate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSInteger localTimestamp = [localNowDate timeIntervalSince1970];
    NSInteger timestamp = localTimestamp + self.timeOffset;
    
    NSString *timestampString = [NSString stringWithFormat:@"%ld",timestamp];
    
    return timestampString;
    
}



// 这个东西是为了拼接get接口 在工具中查看数据__ 只是为了方便程序员查看数据结构 与工程毫无关系 可自由删除
- (void)logGetParameters:(NSMutableDictionary *)parameters url:(NSString *)strBaseUrl{
    

    NSMutableString *rStr = [NSMutableString stringWithFormat:@"%@?",strBaseUrl];
    [((NSDictionary *)parameters) enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [rStr appendFormat:@"%@=%@&",key,obj];
    }];
    [rStr deleteCharactersInRange:NSMakeRange(rStr.length - 1, 1)];
//    WSDLog(@"👏👏👏👏👏👏👏👏👏👏👏👏👏👏👏URL--GET请求参数拼接%@",rStr);
    
}
- (void)logPostParameters:(NSMutableDictionary *)parameters url:(NSString *)strBaseUrl{
    

    NSMutableString *rStr = [NSMutableString stringWithFormat:@"%@---%@",strBaseUrl,parameters];
//    WSDLog(@"👏👏👏👏👏👏👏👏👏👏👏👏👏👏👏URL--POST请求参数拼接%@",rStr);
    
}

-(BOOL)checkLoginOutState:(NSDictionary *)responseObject{
    
    BOOL loginout = [responseObject[@"code"] integerValue] == 10005;
    if (loginout) {
//            [ZQPopWindow showMessage:@"您的手机号在另一台设备登录" buttonTitleConfirm:@"确定" handleConfirm:^{
//                [[CSUserModelManager sharedManager] loginoutAndNeedLogin:YES];
//            }];
        }
    
    return loginout;
}


+ (NSString *)getJsonData:(NSDictionary *)dict {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (jsonData) {
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
        NSRange range = {0,jsonString.length};
        //去掉字符串中的空格
        [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
        NSRange range2 = {0,mutStr.length};
        //去掉字符串中的换行符
        [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
        return mutStr;
    }else{

        return nil;

    }
}

//+ (NSString *)getUUIDByKeyChain{
//    // 这个key的前缀最好是你的BundleID
//    NSString*strUUID = (NSString*)[CSKeyChainStore load:@"com.mycompany.myapp.usernamepassword"];
//    //首次执行该方法时，uuid为空
//    if([strUUID isEqualToString:@""]|| !strUUID) {
//        // 获取UUID 这个是要引入<AdSupport/AdSupport.h>的
//        strUUID = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
//
//        if(strUUID.length ==0 || [strUUID isEqualToString:@"00000000-0000-0000-0000-000000000000"])
//        {
//            //生成一个uuid的方法
//            CFUUIDRef uuidRef= CFUUIDCreate(kCFAllocatorDefault);
//            strUUID = (NSString*)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault,uuidRef));
//            CFRelease(uuidRef);
//        }
//
//        //将该uuid保存到keychain
//        [CSKeyChainStore save:@"com.mycompany.myapp.usernamepassword" data:strUUID];
//    }
//    return strUUID;
//}

+ (NSDictionary *)getHTTPRequestHeadersWithURL:(NSString *)URLString{
    NSMutableDictionary *dic = [NSMutableDictionary new];

//    if ([CSUserModelManager sharedManager].access_token) {
//        [dic setValue:[NSString stringWithFormat:@"Bearer %@",[CSUserModelManager sharedManager].access_token] forKey:@"authorization"];
//    }
    [dic setValue:@"ios" forKey:@"deviceType"];
    [dic setValue:[CSNetworkTool shareManager].deviceToken forKey:@"deviceToken"];
    [dic setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"appVersion"];
//    WSDLog(@"👍👍👍👍👍👍👍👍👍👍👍%@",dic);
    return [NSDictionary dictionaryWithDictionary:dic];
}
@end
