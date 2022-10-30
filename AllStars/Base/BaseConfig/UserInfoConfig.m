//
//  UserInfoConfig.m
//  yike
//
//  Created by Apple on 2019/5/9.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "UserInfoConfig.h"

NSString * const Kpass = @"pass";
NSString * const Kaddress = @"address";
NSString * const Kprivate = @"privateKey";
NSString * const Kpublic = @"publickKey";
NSString * const Kmnemonics = @"mnemonics";

static UserInfoConfig *_instance;

@implementation UserInfoConfig

+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[UserInfoConfig alloc]init];
    });
    return _instance;
}
-(void)saveUserInfo:(UserInfoModel*)user{
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc]init ];
    if(user.pass != nil) [userDefaults setObject:user.pass forKey:Kpass];
    if(user.address!= nil) [userDefaults setObject:user.address forKey:Kaddress];
    if(user.publickKey != nil) [userDefaults setObject:user.publickKey forKey:Kpublic];
    if(user.privteKey!= nil) [userDefaults setObject:user.privteKey forKey:Kprivate];
    if(user.mnemonics != nil) [userDefaults setObject:user.mnemonics forKey:Kmnemonics];
    [userDefaults synchronize];
    [self commitUserInfo];

}
// 用户信息
- (void)commitUserInfo
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    @try {
        self.pass = [userDefaults objectForKey:Kpass];
        self.address = [userDefaults objectForKey: Kaddress];
        self.privteKey = [userDefaults objectForKey:Kprivate];
        self.publickKey = [userDefaults objectForKey: Kpublic];
        self.mnemonics = [userDefaults objectForKey:Kmnemonics];
    }
    @catch (NSException *exception) {
    //        [JGProgressHUD showErrorWithMeassage:@"用户信息读取失败,请重新登录" withView:nil];
    }
    @finally {
        
    }
    
}
- (BOOL)isLogin{
    NSString *userId;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"address"]) {
        userId = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"address"]];
        return userId;
    }
    if (userId && ![userId isEqualToString:@""]) {
        return YES;
    }else{
        return NO;
    }
}
- (BOOL)hasPass{
    NSString *userId;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"coinPass"]) {
        userId = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"coinPass"]];
        return userId;
    }
    if (userId && ![userId isEqualToString:@""]) {
        return YES;
    }else{
        return NO;
    }
}

@end
