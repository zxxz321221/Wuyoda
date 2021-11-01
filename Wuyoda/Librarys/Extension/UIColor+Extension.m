//
//  UIColor+Extension.m
//  SmartHouseKeeperIPad_iOS
//
//  Created by 陈杰 on 2017/6/6.
//  Copyright © 2017年 别智颖. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

- (UIImage *)creatImageWithSize:(CGSize)size cornerRadius:(float)radius{
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    if(radius > 0){ //切圆角
        
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        // 1 > 开启图片上下文
        //第二个参数为不透明度 设为YES 表示不透明 性能更好
        //第三个参数为分辨率 默认为1.0,设为0表示当前设备屏幕分辨率
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
        
//        // 1.1 > 不透明以后要设背景颜色,不然四个角为黑色
//        [bgColor setFill];
//        UIRectFill(rect);
        
        // 1.2 > 裁切路径 创建圆形路径,之后的绘图只会在此路径内部绘制
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect
                                                   byRoundingCorners:UIRectCornerAllCorners
                                                         cornerRadii:CGSizeMake(radius, 0)];
        [path addClip];
        
        // 2 > 绘图
        [theImage drawInRect:rect];
        
        // 3 > 得到结果
        UIImage *recultImg = UIGraphicsGetImageFromCurrentImageContext();
        
        // 4 > 关闭上下文
        UIGraphicsEndImageContext();
        
        return recultImg;
        
    }
    
    return theImage;
}

//随机颜色
+ (UIColor *)randomColor{

    float i = arc4random() % 255;
    float j = arc4random() % 255;
    float k = arc4random() % 255;
    return kColor(i, j, k);
}

+ (UIColor *)colorWithHexString:(NSString *)color {
  return  [self colorWithHexString:color alpha:1.0f];
}

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha{
    
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }

    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];

    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
    
}

@end
