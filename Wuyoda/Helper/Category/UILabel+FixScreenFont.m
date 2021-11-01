//
//  UILabel+FixScreenFont.m
//  Standard Mall
//
//  Created by 王玉鑫 on 2019/11/2.
//  Copyright © 2019 闪电. All rights reserved.
//

#import "UILabel+FixScreenFont.h"

@implementation UILabel (FixScreenFont)

- (void)setFixWidthScreenFont:(float)fixWidthScreenFont{
    
    if (fixWidthScreenFont > 0 ) {
        self.font = [UIFont systemFontOfSize:kWidth(fixWidthScreenFont)];
    }else{
        self.font = self.font;
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
