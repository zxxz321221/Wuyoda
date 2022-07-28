//
//  LogisticsStateMessageHandle.h
//  Wuyoda
//
//  Created by 赵祥 on 2022/7/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LogisticsStateMessageHandle : NSObject

+(NSString *)getStateMessage:(NSString *)code;

@end

NS_ASSUME_NONNULL_END
