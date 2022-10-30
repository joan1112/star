//
//  Tool.h
//  ChambersApp
//
//  Created by 程灯亮 on 2017/11/18.
//  Copyright © 2017年 Cheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface Tool : NSObject

//ASCII签名
+(NSString*)setASCIISign:(NSDictionary*)dic time:(NSString*)time;
// 设置字符串中不同字符的颜色
+(void)setTextColor:(UILabel *)label FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor;
//隐藏键盘
+ (void)hideKeyBoard;
// 判断该应用是否为企业版
+ (BOOL)isMyAppEnterpriseEdition;
// 随机生成UUID
+(NSString *)uuidString;

//判断是否为手机号
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
// 判读是否为邮箱
+ (BOOL)isEmail:(NSString *)email;
// QQ验证
+ (BOOL)isQQMobile:(NSString *)mobile;
// 邮编验证
+ (BOOL)isZipCode:(NSString *)zipCode;

/**
 *  根据图片url获取图片尺寸
 */
+ (CGSize)getImageSizeWithURL:(id)URL;
//定宽度 求高度  content 计算的内容  width 计算的宽度 font字体大小
+ (CGFloat)getHeightWithContent:(NSString *)content width:(CGFloat)width font:(CGFloat)font;
//定高度 求宽度  content 计算的内容  Height 计算的高度 font字体大小
+ (CGFloat)getWidthWithContent:(NSString *)content height:(CGFloat)height font:(CGFloat)font;


//银行卡号加星号
+(NSString*)backBankCardWithStar:(NSString*)string;
//手机号码加星号
+(NSString*)backPhoneWithStar:(NSString*)string;
/**
 获取验证码倒计时
 @param btn 倒计时button
 @param downTitle 倒计时中显示标题
 @param endTitle 倒计时结束显示标题
 */
+ (void)getCodeOfButtonCountDown:(UIButton*)btn andCountDownTitle:(NSString*)downTitle andEndTitle:(NSString*)endTitle;

// 字符串为空判断
+ (BOOL)isNull:(NSString *)content;

//根据颜色返回图片
+ (UIImage *)imageWithColor:(UIColor *)color;
//圆角
+ (void)layerCornerRadius:(UIView*)view radius:(CGFloat)value;
+ (UILabel *)createLabelWithFrame:(CGRect)frame textColor:(UIColor*)textColor textFont:(UIFont*)font textAligion:(NSTextAlignment)align labelText:(NSString*)text;
//华丽丽的分割线
+ (UIView *)createLinewithFrame:(CGRect)frame alpha:(CGFloat)alpha;
//带占位图的imageView
+ (UIImageView*)createImageViewWithFrame:(CGRect)frame image:(UIImage*)image placeholderImge:(UIImage*)placeholderImage;

//文字button
+ (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString*)title titleColor:(UIColor*)color textFont:(UIFont*)textFont backgroudColor:(UIColor*)bgColor target:(id)target action:(SEL)action;
//图片button
+ (UIButton *)createButtonWithFrame:(CGRect)frame normalImage:(UIImage*)normalImage selectImage:(UIImage*)selectImage target:(id)target action:(SEL)action;
//textField
+ (UITextField*)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder target:(id)target textColor:(UIColor*)textColor;
//NSMutableAttributedString 转富文本
+ (NSMutableAttributedString*)convertStringToAttributeStr:(NSString*)string font:(NSInteger)font color:(UIColor*)color range:(NSRange)range;
//判断设备型号
+(NSString*)iphoneType ;
//获取当前视图所在的控制器
+ (UIViewController *)getCurrentVC ;
//MD5加密
+(NSString*)MD5String:(NSString*)str;
//取随机值
+(int)getRandomNumber:(int)from to:(int)to;
    /** 权限相关 */
+(BOOL)havePhotoLibraryAuthority;
+ (BOOL)judgeAssetisInLocalAblum:(PHAsset *)asset;
+(void) removeCacheFile:(NSString*)filePath;
+(void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor;
// 将16进制字符串转换成uicolor
+(UIColor*)hexColor:(NSString*)hexColor;
// NSDictionary 转 jsonString
+(NSString *)convertNSDictionaryToJsonString:(NSDictionary *)json;
// jsonString 转 NSDictionary
+(NSDictionary *)convertJsonStringToNSDictionary:(NSString *)jsonString;
+(NSString *)convertdateToAge:(NSDate *)bornDate;
//获取主窗口
+(UIWindow*)getKeyWindow;
//是否是中文语言
+ (BOOL)isChineseLanguage;
//渐变背景View
+(UIView*)createViewFrame:(CGRect)frame startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint colorS:(NSArray*)colorArr locationS:(NSArray*)locationArr;

+(NSString*)getFrameNameWithValue:(NSInteger)value;
@end
