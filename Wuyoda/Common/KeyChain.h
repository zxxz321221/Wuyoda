//
//  KeyChain.h
//  Wuyoda
//
//  Created by 赵祥 on 2022/7/1.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

#define KEY_PASSWORD  @"com.wuyoda.app.password"
#define KEY_USERNAME_PASSWORD  @"com.wuyoda.app.usernamepassword"
static const char randomStr[] = "QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm0123456789";

NS_ASSUME_NONNULL_BEGIN

@interface KeyChain : NSObject

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service;

+ (NSString *)get32RandomDigit;

@end

NS_ASSUME_NONNULL_END
