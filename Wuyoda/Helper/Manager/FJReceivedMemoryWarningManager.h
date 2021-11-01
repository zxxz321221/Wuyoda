//
//  FJReceivedMemoryWarningManager.h
//  FJFramework
//
//  Created by 樊静 on 2017/6/30.
//  Copyright © 2017年 樊静. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FJReceivedMemoryWarningManager : NSObject
+ (instancetype) sharedInstance;
- (NSString *)currentCacheSize;
- (void)clearCache;
@end
