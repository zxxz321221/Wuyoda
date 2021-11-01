//
//  UIView+IBExtension.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/6.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "UIView+IBExtension.h"
#import "UIScreen+Extension.h"

static char jk_kActionHandlerTapGestureKey;
static char jk_kActionHandlerTapBlockKey;

@implementation UIView (IBExtension)

- (UIViewController*)CurrentViewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (void)jk_addTapActionWithBlock:(JKGestureActionBlock)block
{
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &jk_kActionHandlerTapGestureKey);
    if (!gesture)
    {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jk_handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &jk_kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &jk_kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)jk_handleActionForTapGesture:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        JKGestureActionBlock block = objc_getAssociatedObject(self, &jk_kActionHandlerTapBlockKey);
        if (block)
        {
            block(gesture);
        }
    }
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    
    // 栅格化 - 提高性能
    // 设置栅格化后，图层会被渲染成图片，并且缓存，再次使用时，不会重新渲染
    self.layer.rasterizationScale = UIScreen.kk_scale;
    self.layer.shouldRasterize = YES;
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

//添加阴影
- (void)addShadowWithCornerRadius:(float)radius Corners:(UIRectCorner)corners {
    
    UIBezierPath *bPath1 = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:corners
                                                       cornerRadii:CGSizeMake(radius, 0)];

    self.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = 1;//阴影透明度，默认0
    self.layer.shadowRadius = 4;//阴影半径，默认3
    self.layer.shadowPath = bPath1.CGPath; //阴影路径

}

- (void)addShadowWithCornerRadius:(float)radius{
    
    [self addShadowWithCornerRadius:radius Corners:UIRectCornerAllCorners];
 
}

//只设置view圆角
- (void)setMaskTobyRoundingCorners:(UIRectCorner)corners
                      cornerRadius:(CGFloat)cornerRadius {
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                  byRoundingCorners:corners
                                                        cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    self.layer.mask = shape;
}

//view设置圆角，并添加边框  bColor：边框颜色
- (CAShapeLayer *)setMaskTobyRoundingCorners:(UIRectCorner)corners
                                cornerRadius:(CGFloat)cornerRadius
                                  withBorder:(CGRect)rect
                                 borderColor:(UIColor *)bColor {
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                  byRoundingCorners:corners
                                                        cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    self.layer.mask = shape;
    
    shape = [CAShapeLayer layer];
    shape.frame       = rect;
    shape.path        = rounded.CGPath;
    shape.lineWidth   = 1.0;
    shape.fillColor   = [UIColor clearColor].CGColor;
    shape.strokeColor = bColor.CGColor;
    [self.layer addSublayer:shape];
    
    return shape;
}

@end
