//
//  LanguageTool.m
//  AllStars
//
//  Created by junqiang on 2022/2/21.
//

#import "LanguageTool.h"

@implementation LanguageTool

+(NSString*)getImageNameWith:(NSString*)name{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"myLanguage"]hasPrefix:@"en"]) {
        return [NSString stringWithFormat:@"%@_%@",name,@"en"];
        
    }else{
        return [NSString stringWithFormat:@"%@_%@",name,@"zh"];

    }
}
@end
