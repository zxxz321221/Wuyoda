//
//  UILabel+Extension.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

+ (instancetype)kk_labelWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize {
    return [self kk_labelWithTitle:title color:color fontSize:fontSize alignment:NSTextAlignmentCenter];
}

+ (instancetype)kk_labelWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize alignment:(NSTextAlignment)alignment {
    
    UILabel *label = [[UILabel alloc] init];
    
    label.text = title;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:fontSize];
    //label.numberOfLines = 0;
    label.textAlignment = alignment;
    label.backgroundColor = [UIColor clearColor];
    
    [label sizeToFit];
    
    return label;
}

+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}


- (void)kk_adjustsFontSizeToFitWidth{
    
    self.adjustsFontSizeToFitWidth = YES;
    self.minimumScaleFactor = 0.1;
    self.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
}

//白色字绿色背景
- (void)whiteTextGreenBG {
    self.backgroundColor = [UIColor colorWithHexString:@"#66C2BF"];
    self.textColor = [ColorManager WhiteColor];
    self.font = kFont(12);
    self.layer.borderWidth = 0;
}

////黑色字黑色边框
//- (void)blackTextABorderGreenBG {
//    self.backgroundColor = [UIColor whiteColor];
//    self.textColor = [ColorManager ColorBlackText111111];
//    self.font = kFont(12);
//    self.layer.borderColor = [ColorManager ColorBlackText111111].CGColor;
//    self.layer.borderWidth = kWidth(0.5);
//}

@end
