//
//  HFNetWorkTool.m
//  MCC-AMS
//
//  Created by BOC002 on 2018/4/16.
//  Copyright © 2018年 BOC002. All rights reserved.
//

#import "HFNetWorkTool.h"
//#import "AFNetworkActivityIndicatorManager.h"
//#import "AFNetworkReachabilityManager.h"
//#import "AFHTTPSessionManager.h"
#import "UserInfoConfig.h"
#import "Reachability.h"

@implementation HFNetWorkTool

static BOOL _isOpenLog;   // 是否已开启日志打印
static NSMutableArray *_allSessionTask;
static AFHTTPSessionManager *_sessionManager;

#pragma mark - 开始监听网络
+ (void)networkStatusWithBlock:(MLNetworkStatus)networkStatus {
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                networkStatus ? networkStatus(MLNetworkStatusUnknown) : nil;
                if (_isOpenLog) HFLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                networkStatus ? networkStatus(MLNetworkStatusNotReachable) : nil;
                if (_isOpenLog) HFLog(@"无网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                networkStatus ? networkStatus(MLNetworkStatusReachableViaWWAN) : nil;
                if (_isOpenLog) HFLog(@"手机自带网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                networkStatus ? networkStatus(MLNetworkStatusReachableViaWiFi) : nil;
                if (_isOpenLog) HFLog(@"WIFI");
                break;
        }
    }];
    
}

+ (BOOL)isNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

+ (BOOL)isWWANNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWWAN;
}

+ (BOOL)isWiFiNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
}

+ (void)openLog {
    _isOpenLog = YES;
}

+ (void)closeLog {
    _isOpenLog = NO;
}

+ (void)cancelAllRequest {
    // 锁操作
    @synchronized(self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            [task cancel];
        }];
        [[self allSessionTask] removeAllObjects];
    }
}

+ (void)cancelRequestWithURL:(NSString *)URL {
    if (!URL) { return; }
    @synchronized (self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task.currentRequest.URL.absoluteString hasPrefix:URL]) {
                [task cancel];
                [[self allSessionTask] removeObject:task];
                *stop = YES;
            }
        }];
    }
}

#pragma mark - GET请求无缓存
+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(id)parameters
                  success:(MLHttpRequestSuccess)success
                  failure:(MLHttpRequestFailed)failure {
    
//    NSMutableDictionary *newDic = [[NSMutableDictionary alloc]initWithDictionary:parameters];
//    NSInteger time = [[NSDate date] timeIntervalSince1970]-[UserInfoConfig shareManager].originTime.integerValue;
//    NSString *timeS = [NSString stringWithFormat:@"%ld",time];
//    NSString *sign = [Tool setASCIISign:parameters time:timeS];
//    [newDic setObject:sign forKey:@"sign"];
//    [newDic setObject:timeS forKey:@"time"];
    return [self GET:URL parameters:parameters responseCache:nil success:success failure:failure];
}

#pragma mark - POST请求无缓存
+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(id)parameters
                currentViewController:(RootViewController*)vc
                   success:(MLHttpRequestSuccess)success
                   failure:(MLHttpRequestFailed)failure {
    //初始化
    [self initialize];
//    NSMutableDictionary *newDic = [[NSMutableDictionary alloc]initWithDictionary:parameters];
//    NSInteger time = [[NSDate date] timeIntervalSince1970]-[UserInfoConfig shareManager].originTime.integerValue;
//    NSString *timeS = [NSString stringWithFormat:@"%ld",time];
//    NSString *sign = [Tool setASCIISign:parameters time:timeS];
//    [newDic setObject:sign forKey:@"sign"];
//    [newDic setObject:timeS forKey:@"time"];
    
    return [self POST:URL parameters:parameters responseCache:nil currentViewController:vc success:success failure:failure];
}

#pragma mark - GET请求自动缓存
+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(id)parameters
            responseCache:(MLHttpRequestCache)responseCache
                  success:(MLHttpRequestSuccess)success
                  failure:(MLHttpRequestFailed)failure {
    
    [self initialize];
    //读取缓存
    responseCache!=nil ? responseCache([HFNetWorkCache httpCacheForURL:URL parameters:parameters]) : nil;
    
    
    
    NSURLSessionTask *sessionTask = [_sessionManager GET:URL parameters:parameters headers:@{} progress:^(NSProgress * _Nonnull downloadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (_isOpenLog) {HFLog(@"responseObject = %@",responseObject);}
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        //对数据进行异步缓存
        responseCache!=nil ? [HFNetWorkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (_isOpenLog) {HFLog(@"error = %@",error);}
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
    }];
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;}

#pragma mark - POST请求自动缓存
+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(id)parameters
             responseCache:(MLHttpRequestCache)responseCache
             currentViewController:(RootViewController*)vc
                   success:(MLHttpRequestSuccess)success
                   failure:(MLHttpRequestFailed)failure {
    //判读网络
    if (vc) {
        //1. 检测网络
        BOOL intenet = [Reachability isMayUseInternet];
        if (intenet) { //有网
            [vc hiddenNoInternetView];
        }else
        {
            [vc.view hideHUD];
            [vc.view showToastWithText:@"网络不给力，请稍后重试"];
            [vc showNoInternetView];
        }
    }
    [self initialize];
       //读取缓存
    responseCache!=nil ? responseCache([HFNetWorkCache httpCacheForURL:URL parameters:parameters]) : nil;
    
    NSURLSessionTask *sessionTask =[_sessionManager POST:URL parameters:parameters headers:@{} progress:^(NSProgress * _Nonnull uploadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HFLog(@"------responseSUCCESS------%@",responseObject);
        if (_isOpenLog) {HFLog(@"responseObject = %@",responseObject);}
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        //对数据进行异步缓存
        responseCache!=nil ? [HFNetWorkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        HFLog(@"上传错误至emm ------responseERROR------%@",error);
                
        //        [[EMMThirdPartyTools sharedThirdPartyTools] uploadTunnelErrorLog];
                
                if (_isOpenLog) {HFLog(@"error = %@",error);}
                [[self allSessionTask] removeObject:task];
                failure ? failure(error) : nil;
    }];
    // 添加最新的sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    return sessionTask;

}

#pragma mark - 上传文件
+ (NSURLSessionTask *)uploadFileWithURL:(NSString *)URL
                             parameters:(id)parameters
                                   name:(NSString *)name
                               filePath:(NSString *)filePath
                               progress:(MLHttpProgress)progress
                                success:(MLHttpRequestSuccess)success
                                failure:(MLHttpRequestFailed)failure {
    
    NSURLSessionTask *sessionTask =[_sessionManager POST:URL parameters:parameters headers:@{} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSError *error = nil;
        [formData appendPartWithFileURL:[NSURL URLWithString:filePath] name:name error:&error];
        (failure && error) ? failure(error) : nil;

    } progress:^(NSProgress * _Nonnull uploadProgress) {
         //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
                   progress ? progress(uploadProgress) : nil;
               });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (_isOpenLog) {HFLog(@"responseObject = %@",responseObject);}
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (_isOpenLog) {HFLog(@"error = %@",error);}
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
    }];
    // 添加sessionTask到数组
       sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
       
       return sessionTask;
}

#pragma mark - 上传多张图片
+ (NSURLSessionTask *)uploadImagesWithURL:(NSString *)URL
                               parameters:(id)parameters
                                     name:(NSString *)name
                                   images:(NSArray<UIImage *> *)images
                                fileNames:(NSArray<NSString *> *)fileNames
                               imageScale:(CGFloat)imageScale
                                imageType:(NSString *)imageType
                                 progress:(MLHttpProgress)progress
                                  success:(MLHttpRequestSuccess)success
                                  failure:(MLHttpRequestFailed)failure {
    NSURLSessionTask *sessionTask = [_sessionManager POST:URL parameters:parameters headers:@{} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSUInteger i = 0; i < images.count; i++) {
            // 图片经过等比压缩后得到的二进制文件
            NSData *imageData = UIImageJPEGRepresentation(images[i], imageScale ?: 1.f);
            // 默认图片的文件名, 若fileNames为nil就使用
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *imageFileName = NSStringFormat(@"%@%lu.%@",str,(unsigned long)i,imageType?:@"jpg");
            
            [formData appendPartWithFileData:imageData
                                        name:name
                                    fileName:fileNames ? NSStringFormat(@"%@.%@",fileNames[i],imageType?:@"jpg") : imageFileName
                                    mimeType:NSStringFormat(@"image/%@",imageType ?: @"jpg")];
        }

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         if (_isOpenLog) {HFLog(@"responseObject = %@",responseObject);}
               [[self allSessionTask] removeObject:task];
               success ? success(responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (_isOpenLog) {HFLog(@"error = %@",error);}
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
    }];
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}

#pragma mark - 下载文件
+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL
                              fileDir:(NSString *)fileDir
                             progress:(MLHttpProgress)progress
                              success:(void(^)(NSString *))success
                              failure:(MLHttpRequestFailed)failure {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    __block NSURLSessionDownloadTask *downloadTask = [_sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(downloadProgress) : nil;
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        [[self allSessionTask] removeObject:downloadTask];
        if(failure && error) {failure(error) ; return ;};
        success ? success(filePath.absoluteString /** NSURL->NSString*/) : nil;
        
    }];
    //开始下载
    [downloadTask resume];
    // 添加sessionTask到数组
    downloadTask ? [[self allSessionTask] addObject:downloadTask] : nil ;
    
    return downloadTask;
}

/**
 存储着所有的请求task数组
 */
+ (NSMutableArray *)allSessionTask {
    if (!_allSessionTask) {
        _allSessionTask = [[NSMutableArray alloc] init];
    }
    return _allSessionTask;
}

#pragma mark - 初始化AFHTTPSessionManager相关属性
/**
 开始监测网络状态
 */
+ (void)load {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

/**
 *  所有的HTTP请求共享一个AFHTTPSessionManager
 *  原理参考地址:http://www.jianshu.com/p/5969bbb4af9f
 */
+ (void)initialize {
    _sessionManager = [AFHTTPSessionManager manager];
    _sessionManager.requestSerializer.timeoutInterval = 15.f;
    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
    //公共请
    
    NSString *path =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *filePath = [path stringByAppendingPathComponent:@"saveToken.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSString *tokenS = [dic objectForKey:@"token"];
    if (tokenS.length>0){
        [_sessionManager.requestSerializer setValue:tokenS forHTTPHeaderField:@"Authorization"];
    }
    [_sessionManager.requestSerializer setValue:NULL forHTTPHeaderField:@"transTime"];
    [_sessionManager.requestSerializer setValue:NULL forHTTPHeaderField:@"versionId"];

    // 打开状态栏的等待菊花
//    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
}

#pragma mark - 重置AFHTTPSessionManager相关属性

+ (void)setAFHTTPSessionManagerProperty:(void (^)(AFHTTPSessionManager *))sessionManager {
    sessionManager ? sessionManager(_sessionManager) : nil;
}

+ (void)setRequestSerializer:(MLRequestSerializer)requestSerializer {
    _sessionManager.requestSerializer = requestSerializer==MLRequestSerializerHTTP ? [AFHTTPRequestSerializer serializer] : [AFJSONRequestSerializer serializer];
}

+ (void)setResponseSerializer:(MLResponseSerializer)responseSerializer {
    _sessionManager.responseSerializer = responseSerializer==MLResponseSerializerHTTP ? [AFHTTPResponseSerializer serializer] : [AFJSONResponseSerializer serializer];
}

+ (void)setRequestTimeoutInterval:(NSTimeInterval)time {
    _sessionManager.requestSerializer.timeoutInterval = time;
}

+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    [_sessionManager.requestSerializer setValue:value forHTTPHeaderField:field];
}

+ (void)openNetworkActivityIndicator:(BOOL)open {
//    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:open];
}

+ (void)setSecurityPolicyWithCerPath:(NSString *)cerPath validatesDomainName:(BOOL)validatesDomainName {
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    // 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // 如果需要验证自建证书(无效证书)，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    // 是否需要验证域名，默认为YES;
    securityPolicy.validatesDomainName = validatesDomainName;
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:cerData, nil];
    
    [_sessionManager setSecurityPolicy:securityPolicy];
}

@end


#pragma mark - NSDictionary,NSArray的分类
/*
 ************************************************************************************
 *新建NSDictionary与NSArray的分类, 控制台打印json数据中的中文
 ************************************************************************************
 */

#ifdef DEBUG
@implementation NSArray (ML)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    [strM appendString:@")"];
    
    return strM;
}

@end

@implementation NSDictionary (ML)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    
    [strM appendString:@"}\n"];
    
    return strM;
}
@end
#endif
