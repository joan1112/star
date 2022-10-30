//
//  Tool.m
//  ChambersApp
//
//  Created by 洪飞 on 2017/11/18.
//  Copyright © 2017年 Cheng. All rights reserved.
//

#import "Tool.h"
#import <sys/utsname.h>
#import <CommonCrypto/CommonDigest.h>

@implementation Tool

+(NSString*)setASCIISign:(NSDictionary*)dic time:(NSString*)time{
    
    NSMutableDictionary *newDic = [[NSMutableDictionary alloc]initWithDictionary:dic];
    [newDic setObject:time forKey:@"time"];
    
    NSArray *keyArr = newDic.allKeys;
    NSStringCompareOptions comparisonOptions =NSCaseInsensitiveSearch|NSNumericSearch|
    NSWidthInsensitiveSearch|NSForcedOrderingSearch;
    NSComparator sort = ^(NSString *obj1,NSString *obj2){
        NSRange range =NSMakeRange(0,obj1.length);
        return [obj1 compare:obj2 options:comparisonOptions range:range];
    };
    NSArray *sortArray = [keyArr sortedArrayUsingComparator:sort];
    
    NSString *sortStr;
    NSMutableArray *lastArr = [NSMutableArray new];
    for (NSString *keyStr in sortArray) {
        NSString *urlStr = [newDic objectForKey:keyStr];
        NSString *encodedString = (NSString *)
  CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)urlStr,(CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",NULL,kCFStringEncodingUTF8));
        NSString * str1 = [keyStr stringByAppendingString:encodedString];
        [lastArr addObject:str1];
    }
    sortStr = [lastArr componentsJoinedByString:@""];
    NSString *newS = [@"#__#" stringByAppendingString:sortStr];
    NSString *lastStr = [Tool MD5String:newS];
//    [newDic removeObjectForKey:@"time"];
    //MD5加密
    return lastStr;
}
//MD5加密
+(NSString*)MD5String:(NSString*)str{
//    const char *myPasswd = [str UTF8String];
//    unsigned char mdc[16];
//
//    CC_MD5(myPasswd, (CC_LONG)strlen(myPasswd), mdc);
//
//    NSMutableString *md5String = [NSMutableString string];
//
//    [md5String appendFormat:@"%02x",mdc[0]];
//
//    for (int i = 1; i< 16; i++) {
//
//        [md5String appendFormat:@"%02x",mdc[i]^mdc[0]];
//
//    }
//
//    return md5String;
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
    
}
//设置不同字体颜色
+(void)setTextColor:(UILabel *)label FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
    //设置字号
    [str addAttribute:NSFontAttributeName value:font range:range];
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
    
    label.attributedText = str;
}
//随机生成uuid
+(NSString *)uuidString{
    CFUUIDRef uuid_ref=CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref=CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid =[NSString stringWithString:(__bridge NSString * _Nonnull)(uuid_string_ref)];
    uuid =[uuid  stringByReplacingOccurrencesOfString:@"-" withString:@""];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    
    return [uuid lowercaseString];
    
}

//隐藏键盘
+ (void)hideKeyBoard{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    if (!keyWindow) {
        NSArray *array=[UIApplication sharedApplication].windows;
        keyWindow=[array objectAtIndex:0];
    }
    [keyWindow endEditing:YES];
}
+ (BOOL)isMyAppEnterpriseEdition
{
//    if ([[[NSBundle mainBundle]bundleIdentifier] isEqualToString:D_MyAppEnterpriseEditionBundleId]) {
//        return YES;
//    }
    return NO;
}

//判断是否为手机号
+(BOOL)isMobileNumber:(NSString *)mobileNum
{
    NSString *mobile = @"^1[34758][0-9]\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",mobile];
    return [phoneTest evaluateWithObject:mobileNum];
}
// 判读是否为邮箱
+(BOOL)isEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
// 判读输入的qq号
+(BOOL)isQQMobile:(NSString *)mobile
{
    NSString *phoneRegex = @"^[1-9]*[1-9][0-9]*$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
+(BOOL)isZipCode:(NSString *)zipCode
{
    NSString *phoneRegex = @"^[1-9]\\d{5}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:zipCode];
}


//定宽度 求高度  content 计算的内容  width 计算的宽度 font字体大小
+ (CGFloat)getHeightWithContent:(NSString *)content width:(CGFloat)width font:(CGFloat)font
{
    CGRect rect = [content boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                        context:nil];
    return rect.size.height;
}

//定高度 求宽度  content 计算的内容  Height 计算的高度 font字体大小
+ (CGFloat)getWidthWithContent:(NSString *)content height:(CGFloat)height font:(CGFloat)font
{
    CGRect rect = [content boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return rect.size.width;
}

// 手机号加星号
+(NSString*)backPhoneWithStar:(NSString*)string{
    NSString *phoneStr = [string stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    return phoneStr;
}

// 银行卡号加星号
+(NSString*)backBankCardWithStar:(NSString*)string{
    NSUInteger lenth = string.length;
    NSString *str1 = [string substringToIndex:4];
    NSString *str2 = [string substringFromIndex:lenth - 4];
    NSMutableString *str3 = [[NSMutableString alloc]init];
    for (int i = 0; i < lenth - 8; i++) {
        [str3 appendString:@"*"];
    }
    NSString *str = [NSString stringWithFormat:@"%@%@%@",str1,str3,str2];
    return str;
}

/**
 获取验证码倒计时
 @param downTitle 倒计时中显示标题
 @param endTitle 倒计时结束显示标题
 */
+ (void)getCodeOfButtonCountDown:(UIButton *)btn andCountDownTitle:(NSString *)downTitle andEndTitle:(NSString *)endTitle
{
    __block int timeOut = 60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeOut<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [btn setTitle:endTitle forState:UIControlStateNormal];
                btn.userInteractionEnabled = YES;
            });
        }
        else
        {
            int seconds = timeOut % 61;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //HFLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [btn setTitle:[NSString stringWithFormat:@"%@%@",strTime,downTitle] forState:UIControlStateNormal];
                [UIView commitAnimations];
                btn.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
    
}
+ (BOOL)isNull:(NSString *)content
{
    if ([content isKindOfClass:[NSNull class]] || !content) {
        return YES;
    }else{
        return NO;
    }
}


//根据颜色返回图片
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (void)layerCornerRadius:(UIView*)view radius:(CGFloat)value
{
    view.layer.cornerRadius = value;
    view.layer.masksToBounds = YES;
}
+ (UILabel *)createLabelWithFrame:(CGRect)frame textColor:(UIColor*)textColor textFont:(UIFont*)font textAligion:(NSTextAlignment)align labelText:(NSString *)text{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.textColor = textColor;
    label.textAlignment = align;
    label.font = font;
    label.text = text;
    return label;
    
}

//华丽丽的分割线
+ (UIView*)createLinewithFrame:(CGRect)frame alpha:(CGFloat)alpha{
    UIView *line = [[UIView alloc]initWithFrame:frame];
    line.alpha = alpha;
    line.backgroundColor = [UIColor lightGrayColor];
    return line;
}
//带占位图的imageView
+ (UIImageView*)createImageViewWithFrame:(CGRect)frame image:(UIImage*)image placeholderImge:(UIImage*)placeholderImage
{
    UIImageView * imageV= [[UIImageView alloc]initWithFrame:frame];
    
    if (image != nil) {
        imageV.image = image;
    }
    else
    {
        imageV.image = placeholderImage;
    }
    return imageV;
}
//文字button
+ (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)color textFont:(UIFont *)textFont backgroudColor:(UIColor *)bgColor target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = textFont;
    btn.backgroundColor = bgColor;
    btn.frame = frame;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
//图片button
+ (UIButton *)createButtonWithFrame:(CGRect)frame normalImage:(UIImage*)normalImage selectImage:(UIImage*)selectImage target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn setImage:selectImage forState:UIControlStateSelected];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+ (UITextField*)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder target:(id)target textColor:(UIColor *)textColor{
    UITextField *inputField = [[UITextField alloc]initWithFrame:frame];
    inputField.placeholder = placeholder;
    inputField.delegate = target;
    inputField.textColor = textColor;
    inputField.font = [UIFont systemFontOfSize:14];
    //不自动大写98363
    inputField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    return inputField;
}

//富文本设置
+ (NSMutableAttributedString*)convertStringToAttributeStr:(NSString*)string font:(NSInteger)font color:(UIColor*)color range:(NSRange)range
{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:string];
    [attributedStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font],NSForegroundColorAttributeName:color} range:range];
    
    return attributedStr;
}
+(NSString*)iphoneType {
    
    //需要导入头文件：#import <sys/utsname.h>
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString*platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([platform isEqualToString:@"iPhone1,1"]) {
       return @"iPhone 2G";
    }
    
    if([platform isEqualToString:@"iPhone1,2"]) {
       return @"iPhone 3G";
    }
    
    if([platform isEqualToString:@"iPhone2,1"]) {
       return @"iPhone 3GS";
    }
    
    if([platform isEqualToString:@"iPhone3,1"]){
        return@"iPhone 4";
    }
    
    if([platform isEqualToString:@"iPhone3,2"]){
        return@"iPhone 4";
    }
    
    if([platform isEqualToString:@"iPhone3,3"]){
        return@"iPhone 4";
    }
    if([platform isEqualToString:@"iPhone4,1"]){
        return@"iPhone 4S";
    }
    
    if([platform isEqualToString:@"iPhone5,1"]){
       return@"iPhone 5";
    }
    
    if([platform isEqualToString:@"iPhone5,2"]){
       return@"iPhone 5";
    }
    
    if([platform isEqualToString:@"iPhone5,3"]){
        return@"iPhone 5c";
    }
    
    if([platform isEqualToString:@"iPhone5,4"]){
        return@"iPhone 5c";
    }
    
    if([platform isEqualToString:@"iPhone6,1"]){
        return@"iPhone 5s";
    }
    
    if([platform isEqualToString:@"iPhone6,2"]){
        return@"iPhone 5s";
    }
    if([platform isEqualToString:@"iPhone7,1"]){
        return@"iPhone 6 Plus";
    }
    
    if([platform isEqualToString:@"iPhone7,2"]){
        return@"iPhone 6";
    }
    
    if([platform isEqualToString:@"iPhone8,1"]){
        return@"iPhone 6s";
    }
    
    if([platform isEqualToString:@"iPhone8,2"]){
        return@"iPhone 6s Plus";
    }
    
    if([platform isEqualToString:@"iPhone8,4"]){
        return@"iPhone SE";
    }
    
    if([platform isEqualToString:@"iPhone9,1"]){
        return@"iPhone 7";

    }
    if([platform isEqualToString:@"iPhone9,2"]){
        return@"iPhone 7 Plus";

    }
    if([platform isEqualToString:@"iPhone10,1"]) {
        return@"iPhone 8";
    }
    
    if([platform isEqualToString:@"iPhone10,4"]){
        return@"iPhone 8";

    }
    if([platform isEqualToString:@"iPhone10,2"]) {
        return@"iPhone 8 Plus";

    }
    if([platform isEqualToString:@"iPhone10,5"]){
         return@"iPhone 8 Plus";
    }
    
    if([platform isEqualToString:@"iPhone10,3"]) {
        return@"iPhone X";
    }
    
    if([platform isEqualToString:@"iPhone10,6"]){
         return@"iPhone X";
    }

    if([platform isEqualToString:@"iPhone11,8"]){
        return@"iPhone XR";
    }
    if([platform isEqualToString:@"iPhone11,2"]){
        return@"iPhone XS";
    }
    if([platform isEqualToString:@"iPhone11,6"]){
        return@"iPhone XS Max";
    }

    return platform;
    
}
+ (UIViewController *)getCurrentVC {
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    if (!window) {
        return nil;
    }
    UIView *tempView;
    for (UIView *subview in window.subviews) {
        if ([[subview.classForCoder description] isEqualToString:@"UILayoutContainerView"]) {
            tempView = subview;
            break;
        }
    }
    if (!tempView) {
        tempView = [window.subviews lastObject];
    }
    
    id nextResponder = [tempView nextResponder];
    while (![nextResponder isKindOfClass:[UIViewController class]] || [nextResponder isKindOfClass:[UINavigationController class]] || [nextResponder isKindOfClass:[UITabBarController class]]) {
        tempView =  [tempView.subviews firstObject];
        
        if (!tempView) {
            return nil;
        }
        nextResponder = [tempView nextResponder];
    }
    return  (UIViewController *)nextResponder;
}

+ (int)getRandomNumber:(int)from to:(int)to {
    return (int)(from + (arc4random() % (to - from + 1)));
}
    
#pragma mark - 权限相关
+ (BOOL)havePhotoLibraryAuthority
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusAuthorized) {
        return YES;
    }
    return NO;
}
    
#pragma mark - 判断是不是本地视频
+ (BOOL)judgeAssetisInLocalAblum:(PHAsset *)asset {
    __block BOOL result = NO;
    if (@available(iOS 10.0, *)) {
        // https://stackoverflow.com/questions/31966571/check-given-phasset-is-icloud-asset
        // 这个api虽然是9.0出的，但是9.0会全部返回NO，未知原因，暂时先改为10.0
        NSArray *resourceArray = [PHAssetResource assetResourcesForAsset:asset];
        if (resourceArray.count) {
            result = [[resourceArray.firstObject valueForKey:@"locallyAvailable"] boolValue];
        }
    } else {
        PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
        option.networkAccessAllowed = NO;
        option.synchronous = YES;
        
        [[PHCachingImageManager defaultManager] requestImageDataForAsset:asset options:option resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            result = imageData ? YES : NO;
        }];
    }
    return result;
}

+(void) removeCacheFile:(NSString*)filePath
{
    NSError * error;
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath] == YES) {
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
    }
}
//四边阴影
+(void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
    // 阴影颜色
    theView.layer.shadowColor = theColor.CGColor;
    // 阴影偏移，默认(0, -3)
    theView.layer.shadowOffset = CGSizeMake(0,0);
    // 阴影透明度，默认0
    theView.layer.shadowOpacity = 0.5;
    // 阴影半径，默认3
    theView.layer.shadowRadius = 5;
    
}

// 将16进制字符串转换成uicolor
+ (UIColor*)hexColor:(NSString*)hexColor {
    unsigned int red, green, blue, alpha;
    NSRange range;
    range.length = 2;
    @try {
        if ([hexColor hasPrefix:@"#"]) {
            hexColor = [hexColor stringByReplacingOccurrencesOfString:@"#" withString:@""];
        }
        range.location = 0;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
        range.location = 2;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
        range.location = 4;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
        
        if ([hexColor length] > 6) {
            range.location = 6;
            [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&alpha];
        }
    }
    @catch (NSException * e) {
        //        [MAUIToolkit showMessage:[NSString stringWithFormat:@"颜色取值错误:%@,%@", [e name], [e reason]]];
        //        return [UIColor blackColor];
    }
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:(float)(1.0f)];
}


// NSDictionary 转 jsonString
+ (NSString *)convertNSDictionaryToJsonString:(NSDictionary *)json {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"json解析失败:%@", error);
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

// jsonString 转 NSDictionary
+(NSDictionary *)convertJsonStringToNSDictionary:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"jsonString解析失败:%@", error);
        return nil;
    }
    return json;
    
}

//+(void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
//
//    theView.layer.shadowColor = theColor.CGColor;
//    theView.layer.shadowOffset = CGSizeMake(0,0);
//    theView.layer.shadowOpacity = 0.5;
//    theView.layer.shadowRadius = 5;
//    // 单边阴影 顶边
//    float shadowPathWidth = theView.layer.shadowRadius;
//    CGRect shadowRect = CGRectMake(0, 0-shadowPathWidth/2.0, theView.bounds.size.width, shadowPathWidth);
//    UIBezierPath *path = [UIBezierPath bezierPathWithRect:shadowRect];
//    theView.layer.shadowPath = path.CGPath;
//
//}
/**
 *  根据图片url获取图片尺寸
 */
+ (CGSize)getImageSizeWithURL:(id)URL{
    NSURL * url = nil;
    if ([URL isKindOfClass:[NSURL class]]) {
        url = URL;
    }
    if ([URL isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:URL];
    }
    if (!URL) {
        return CGSizeZero;
    }
    CGImageSourceRef imageSourceRef =     CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    CGFloat width = 0, height = 0;
    if (imageSourceRef) {
        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, NULL);
        if (imageProperties != NULL) {
            CFNumberRef widthNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
            
            //            if (widthNumberRef != NULL) {
            //                CFNumberGetValue(widthNumberRef, kCFNumberFloat64Type, &width);
            //            }
            //            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            //            if (heightNumberRef != NULL) {
            //                CFNumberGetValue(heightNumberRef, kCFNumberFloat64Type, &height);
            //            }
            //判断设备是否为64位
#if defined(__LP64__) && __LP64__
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat64Type, &width);
            }
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat64Type, &height);
            }
#else
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat32Type, &width);
            }
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat32Type, &height);
            }
#endif
            
            CFRelease(imageProperties);
        }
        CFRelease(imageSourceRef);
    }
    return CGSizeMake(width, height);
}

+(NSString*)convertBefore:(NSString*)str1 after:(NSString*)str2 value:(NSString*)str3{
    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:str1];
    NSDate *date = [formatter dateFromString:str3];
    NSDateFormatter * newformatter=[[NSDateFormatter alloc]init];
    [newformatter setDateFormat:str2];
    NSString *timeS = [newformatter stringFromDate:date];
    return timeS;
}


+ (NSDateFormatter *)dateFormatter{
    static NSDateFormatter *fmt = nil;
    /// 由于NSDateFormatter 有一定的性能问题 故全局共享一个
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
        ///  真机调试的时候，必须加上这句
        fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    });
    return fmt;
}

+(NSString *)convertdateToAge:(NSDate *)bornDate{
    //获得当前系统时间
    NSDate *currentDate = [NSDate date];
    //获得当前系统时间与出生日期之间的时间间隔
    NSTimeInterval time = [currentDate timeIntervalSinceDate:bornDate];
    //时间间隔以秒作为单位,求年的话除以60*60*24*356
    int age = ((int)time)/(3600*24*365);
    return [NSString stringWithFormat:@"%d",age];
}

+(UIWindow*)getKeyWindow{
    if (@available(iOS 13.0, *))
    {
        for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive)
            {
                for (UIWindow *window in windowScene.windows)
                {
                    if (window.isKeyWindow)
                    {
                        return window;
                        break;
                    }
                }
            }
        }
    }
    else
    {
        return [UIApplication sharedApplication].keyWindow;
    }
    return nil;
}

+ (BOOL)isChineseLanguage {
    NSString *currentLanguage = [[NSLocale preferredLanguages]objectAtIndex:0];;
    return [currentLanguage hasPrefix:@"zh-Hans"];
}
+(UIView*)createViewFrame:(CGRect)frame startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint colorS:(NSArray*)colorArr locationS:(NSArray*)locationArr{
    
    //实现背景渐变
    
    //初始化我们需要改变背景色的UIView，并添加在视图上
    UIView *view = [[UIView alloc] initWithFrame:frame];
   
    //初始化CAGradientlayer对象，使它的大小为UIView的大小
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [view.layer addSublayer:gradientLayer];
    
    //设置渐变区域的起始和终止位置（范围为0-1）
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    
    //设置颜色数组
    gradientLayer.colors = colorArr ;
    //设置颜色分割点（范围：0-1）
    gradientLayer.locations = locationArr;
    
    return view;

}

+(NSString*)getFrameNameWithValue:(NSInteger)value{
    if (value == 1) {
        return @"蓝";
    }
    if (value == 2) {
        return @"紫";
    }
    if (value == 3) {
        return @"黄";
    }
    if (value == 4) {
        return @"橙";
    }
    if (value == 5) {
        return @"红";
    }
    if (value == 6) {
        return @"绿";
    }
    if (value == 7) {
        return @"暗金";
    }
    return @"";
}
@end
