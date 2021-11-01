//
//  NSNotificationCenter+Extension.m
//  SmartHouseKeeperIPad_iOS
//
//  Created by 陈杰 on 2017/7/10.
//  Copyright © 2017年 别智颖. All rights reserved.
//

#import "NSNotificationCenter+Extension.h"

@implementation NSNotificationCenter (Extension)

+ (void)postNotificationWithName:(NSString *)strName object:(id)object{
    if ([NSThread isMainThread]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:strName object:object];
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:strName object:object];
        });
    }
    return;
}

@end

