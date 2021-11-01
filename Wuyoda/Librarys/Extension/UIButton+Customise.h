//
//  UIButton+Customise.h
//  HongTianTao_ refectory
//
//  Created by hongtiantao on 19/11/3.
//  Copyright © 2019年 hongtiantao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ClickActionBlock) (id obj);

@interface UIButton (Customise)
- (void)buttonWithClickBlock:(ClickActionBlock)clickBlock for:(UIControlEvents)event;
@end
