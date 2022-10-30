//
//  UserInfoModel.h
//  yike
//
//  Created by Apple on 2019/5/9.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LevelModel,MLevelModel,SVGAVideoEntity,SvgaModel;

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoModel : NSObject

@property (nonatomic, strong)NSString *pass;
@property (nonatomic, strong)NSString *address;
@property (nonatomic, strong)NSString *privteKey;
@property (nonatomic, strong)NSString *publickKey;
@property (nonatomic, strong)NSString *mnemonics;


@property (nonatomic, strong)LevelModel *level;
@property (nonatomic, strong)MLevelModel *m_level;

@end


@interface LevelModel : NSObject    //用户等级
@property (nonatomic, strong)NSString *l;
@property (nonatomic, strong)NSString *n;
@property (nonatomic, strong)NSString *t;
@end

@interface MLevelModel : NSObject   //主播等级
@property (nonatomic, strong)NSString *l;
@property (nonatomic, strong)NSString *n;
@property (nonatomic, strong)NSString *t;
@end

@interface SvgaModel : NSObject<NSCoding>
@property (nonatomic, strong)NSString *svgaName;
@property (nonatomic, strong)SVGAVideoEntity *videoItem;
@end

NS_ASSUME_NONNULL_END
