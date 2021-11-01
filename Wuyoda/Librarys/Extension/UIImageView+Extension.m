//
//  UIImageView+Extension.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "UIImageView+Extension.h"

@implementation UIImageView (Extension)

+ (instancetype)kk_imageViewWithImageName:(NSString *)imageName {
    
    if (imageName.length == 0) {
        return [[UIImageView alloc] init];
    }
    
    UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [imgV sizeToFit];
    
    return imgV;
}

@end
