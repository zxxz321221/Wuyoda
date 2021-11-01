//
//  NSNotificationCenter+Extension.h
//  SmartHouseKeeperIPad_iOS
//
//  Created by 陈杰 on 2017/7/10.
//  Copyright © 2017年 别智颖. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (Extension)

+ (void)postNotificationWithName:(NSString *)strName object:(id)object;


@end
