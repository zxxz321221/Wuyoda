//
//  UIColor+Extension.h
//  SmartHouseKeeperIPad_iOS
//  Copyright © 2017年 别智颖. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

//创建图片
- (UIImage *)creatImageWithSize:(CGSize)size cornerRadius:(float)radius;

//随机颜色
+ (UIColor *)randomColor;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)color;

@end
