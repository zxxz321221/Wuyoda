//
//  UILabel+Extension.h
//  Weibo11
//
//  Created by 刘凡 on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)

/// 创建 UILabel
///
/// @param title     标题
/// @param color     标题颜色
/// @param fontSize  字体大小
///
/// @return UILabel(文本水平居中)
+ (instancetype)kk_labelWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize;

/// 创建 UILabel
///
/// @param title     标题
/// @param color     标题颜色
/// @param fontSize  字体大小
/// @param alignment 对齐方式
///
/// @return UILabel
+ (instancetype)kk_labelWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize alignment:(NSTextAlignment)alignment;

//UILabel通过调用此方法计算出文本的高度
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;

//缩小字体以适应宽度
- (void)kk_adjustsFontSizeToFitWidth;
//白色字绿色背景
- (void)whiteTextGreenBG;
////黑色字黑色边框
//- (void)blackTextABorderGreenBG;

@end
