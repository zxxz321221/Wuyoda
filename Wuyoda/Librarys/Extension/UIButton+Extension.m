//
//  UIButton+Extension.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "UIButton+Extension.h"

/// 标题默认颜色
#define kItemTitleColor             [UIColor whiteColor]
/// 标题高亮颜色
#define kItemTitleHighlightedColor  kColor(142,142,142)
/// 标题字体大小
#define kItemFontSize   14

@implementation UIButton (Extension)

+ (instancetype)kk_buttonWithTitle:(NSString *)title
                         imageName:(NSString *)imageName
                            target:(id)target
                            action:(SEL)action {
    
    UIButton *button = [[self alloc] init];
    
    // 设置图像
    if (imageName.length > 0) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        
//        NSString *highlighted = [NSString stringWithFormat:@"%@_highlighted", imageName];
//        [button setImage:[UIImage imageNamed:highlighted] forState:UIControlStateHighlighted];
    }
    
    // 设置标题
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:kItemTitleColor forState:UIControlStateNormal];
    [button setTitleColor:kItemTitleHighlightedColor forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:kItemFontSize];
    
    [button sizeToFit];
    
    // 监听方法
    if (action != nil) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}

+ (instancetype)kk_buttonWithTitle:(NSString *)title
                             color:(UIColor *)color
                          fontSize:(CGFloat)fontSize
                         imageName:(NSString *)imageName
                     backImageName:(NSString *)backImageName {
    
    UIButton *button = [[UIButton alloc] init];
    
    // 设置标题
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    // 图片
    if (imageName.length > 0) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    
    // 背景图片
    if (backImageName.length > 0) {
        [button setBackgroundImage:[UIImage imageNamed:backImageName] forState:UIControlStateNormal];
    }
    
    return button;
}

+ (instancetype)kk_buttonWithTitle:(NSString *)title
                        titleColor:(UIColor *)titleColor
                     backImageName:(NSString *)backImageName {
    
    UIButton *button = [[UIButton alloc] init];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    if (backImageName.length > 0) {
        [button setBackgroundImage:[UIImage imageNamed:backImageName] forState:UIControlStateNormal];
    }

    return button;
}

//背景图片按钮
+ (instancetype)kk_buttonWithBackgroundImage:(UIImage *)image
                                      target:(id)target
                                      action:(SEL)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (image != nil){
        [button setBackgroundImage:image forState:UIControlStateNormal];
    }
    [button sizeToFit];
    
    // 监听方法
    if (action != nil) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;

}

+ (instancetype)kk_buttonWithBackgroundImage:(UIImage *)image
                             selectedBGImage:(UIImage *)selImg
                                      target:(id)target
                                      action:(SEL)action{

    UIButton *button = [self kk_buttonWithBackgroundImage:image target:target action:action];
    
    [button setBackgroundImage:selImg forState:UIControlStateSelected];
    
    return button;
    
}

//背景图和按钮图
+ (instancetype)kk_buttonWithNorMalImage:(UIImage *)normalImage
                             selectedImg:(UIImage *)selectedImg
                             normalBGImg:(UIImage *)normalBGImg
                         selectedBGImage:(UIImage *)selectedBGImage
                                  target:(id)target
                                  action:(SEL)action {

    UIButton *button = [self kk_buttonWithNormalImage:normalImage selectedImage:selectedImg target:target action:action];
    
    [button setBackgroundImage:normalBGImg forState:UIControlStateNormal];
    [button setBackgroundImage:selectedBGImage forState:UIControlStateSelected];
    
    return button;
    
}
//图片按钮
+ (instancetype)kk_buttonWithNormalImage:(UIImage *)normalImage
                           selectedImage:(UIImage *)selectedImg
                                  target:(id)target
                                  action:(SEL)action{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (normalImage != nil) {
        [button setImage:normalImage forState:UIControlStateNormal];
    }
    if (selectedImg != nil) {
        [button setImage:selectedImg forState:UIControlStateSelected];
        [button setImage:selectedImg forState:UIControlStateSelected|UIControlStateHighlighted];
    }
    
    button.adjustsImageWhenHighlighted = NO;
    
    [button sizeToFit];
    
    // 监听方法
    if (action != nil) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}

+ (instancetype)kk_buttonWithNormalImage:(UIImage *)normalImage
                        highlightedImage:(UIImage *)highlightedImg
                                  target:(id)target
                                  action:(SEL)action{
    
    UIButton *button = [self kk_buttonWithNormalImage:normalImage selectedImage:nil target:(id)target action:(SEL)action];
    
    if (highlightedImg != nil) {
        [button setImage:highlightedImg forState:UIControlStateHighlighted];
    }
    
   return button;
}

//fx 图片在上，文字在下的按钮
- (void)kk_buttonContentEdgeImageTop_titleBelow {
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [self setTitleEdgeInsets:UIEdgeInsetsMake(self.imageView.frame.size.height + 10,
                                              -self.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [self setImageEdgeInsets:UIEdgeInsetsMake(- self.titleLabel.bounds.size.height, 0.0, 0.0, -self.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
}


+ (instancetype)kk_buttonWithTitle:(NSString *)title
                        titleColor:(UIColor *)titleColor
                         titleFont:(UIFont *)titleFont {
    
    UIButton *button = [[UIButton alloc] init];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button.titleLabel setFont:titleFont];

    return button;
}

+ (instancetype)kk_buttonWithTitle:(NSString *)title
                        titleColor:(UIColor *)titleColor
                         titleFont:(UIFont *)titleFont
                     backGroundColor:(UIColor *)backGroundColor {
    
    UIButton *button = [[UIButton alloc] init];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button.titleLabel setFont:titleFont];
    [button setBackgroundColor:backGroundColor];
    return button;
}

@end
