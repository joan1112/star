//
//  UIColor+GradientLayer.h
//  yike
//
//  Created by Apple on 2019/7/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (GradientLayer)
//绘制渐变色颜色的方法
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view
                                   fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

+ (UIImage *)gradientImageWithView:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint cornerRadius:(CGFloat)cornerRadius;
@end

NS_ASSUME_NONNULL_END
