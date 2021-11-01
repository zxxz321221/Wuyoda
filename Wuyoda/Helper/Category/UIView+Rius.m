//
//  UIView+Rius.m
//  Standard Mall
//
//  Created by 王玉鑫 on 2019/12/16.
//  Copyright © 2019 闪电. All rights reserved.
//

#import "UIView+Rius.h"

@implementation UIView (Rius)
@dynamic borderColor,borderWidth,cornerRadius;
-(void)setBorderColor:(UIColor *)borderColor{
    [self.layer setBorderColor:borderColor.CGColor];
}

-(void)setBorderWidth:(CGFloat)borderWidth{
    [self.layer setBorderWidth:borderWidth];
}

-(void)setCornerRadius:(CGFloat)cornerRadius{
    [self.layer setCornerRadius:cornerRadius];
}

@end
