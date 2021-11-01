//
//  UIButton+FixScreenFont.m
//  HuoZhiShop
//
//  Created by MAC02 on 2020/12/22.
//

#import "UIButton+FixScreenFont.h"

@implementation UIButton (FixScreenFont)

- (void)setFixWidthScreenFont:(float)fixWidthScreenFont{
    
    if (fixWidthScreenFont > 0 ) {
        [self.titleLabel setFont:kFont(fixWidthScreenFont)];
    }else {
        [self.titleLabel setFont:self.titleLabel.font];
    }
}

- (float )fixWidthScreenFont{
    return self.fixWidthScreenFont;
}

- (void)setFixWidth:(float)fixWidth {
    if (fixWidth > 0) {
        self.width = fixWidth;
    }else {
        self.width = self.width;
    }
}

- (float)fixWidth {
    return self.fixWidth;
}

- (void)setFixHeight:(float)fixHeight {
    if (fixHeight > 0) {
        self.height = fixHeight;
    }else {
        self.height = self.height;
    }
}

- (float)fixHeight {
    return self.fixHeight;
}

@end
