//
//  UserInfoModel.m
//  yike
//
//  Created by Apple on 2019/5/9.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

@end

@implementation LevelModel

@end

@implementation MLevelModel

@end

@implementation SvgaModel
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.svgaName = [aDecoder decodeObjectForKey:@"svgaName"];
        self.videoItem = [aDecoder decodeObjectForKey:@"videoItem"];
    }
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.svgaName forKey:@"svgaName"];
    [aCoder encodeObject:self.videoItem forKey:@"videoItem"];
}


@end

