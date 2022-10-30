//
//  UserInfoConfig.h
//  yike
//
//  Created by Apple on 2019/5/9.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import"UserInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoConfig : NSObject

@property (nonatomic, strong)NSString *pass;
@property (nonatomic, strong)NSString *address;
@property (nonatomic, strong)NSString *privteKey;
@property (nonatomic, strong)NSString *publickKey;
@property (nonatomic, strong)NSString *mnemonics;
@property (nonatomic, strong)NSArray  *balaceArr;
@property (nonatomic, strong)NSString *STARSTR;
@property (nonatomic, strong)NSString *STLSTR;
@property (nonatomic, strong)NSString *BNBSTR;

+ (UserInfoConfig*)shareManager;

-(void)saveUserInfo:(UserInfoModel*)user;
// 提交用户信息
- (void)commitUserInfo;
- (BOOL)isLogin;
- (BOOL)hasPass;
@end

NS_ASSUME_NONNULL_END
