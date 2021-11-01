//
//  UIButton+Customise.m
//  HongTianTao_ refectory
//
//  Created by hongtiantao on 19/11/3.
//  Copyright © 2019年 hongtiantao. All rights reserved.
//

#import "UIButton+Customise.h"
#import <objc/runtime.h>

static id key;
@implementation UIButton (Customise)
- (void)buttonWithClickBlock:(ClickActionBlock)clickBlock for:(UIControlEvents)event{
    objc_setAssociatedObject(self, &key, clickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(clickAction:) forControlEvents:event];
 
}



- (void)clickAction:(UIButton *)sender{
    ClickActionBlock block = (ClickActionBlock)objc_getAssociatedObject(self, &key);
    if (block) {
        block(sender);
    }
}
@end
