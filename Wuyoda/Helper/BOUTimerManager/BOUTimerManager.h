//
//  BOUTimerManager.h
//  JiaHeOil
//
//  Created by longcai on 2020/11/26.
//
#import <Foundation/Foundation.h>
#undef    DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef    IMP_SINGLETON
#define IMP_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}

#define kLoginCountDownCompletedNotification            @"kLoginCountDownCompletedNotification"
#define kFindPasswordCountDownCompletedNotification     @"kFindPasswordCountDownCompletedNotification"
#define kRegisterCountDownCompletedNotification            @"kRegisterCountDownCompletedNotification"
#define kModifyPhoneCountDownCompletedNotification            @"kModifyPhoneCountDownCompletedNotification"
#define kBindWechatCountDownCompletedNotification            @"kBindWechatCountDownCompletedNotification"
#define kteacherRegisterCountDownCompletedNotification            @"kteacherRegisterCountDownCompletedNotification"

#define kLoginCountDownExecutingNotification            @"kLoginCountDownExecutingNotification"
#define kFindPasswordCountDownExecutingNotification     @"kFindPasswordCountDownExecutingNotification"
#define kRegisterCountDownExecutingNotification            @"kRegisterCountDownExecutingNotification"
#define kModifyPhoneCountDownExecutingNotification            @"kModifyPhoneCountDownExecutingNotification"
#define kBindWechatCountDownExecutingNotification            @"kBindWechatCountDownExecutingNotification"
#define kteacherRegisterCountDownExecutingNotification            @"kteacherRegisterCountDownExecutingNotification"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BOUCountDownType) {
    BOUCountDownTypeLogin,
    BOUCountDownTypeFindPassword,
    BOUCountDownTypeRegister,
    BOUCountDownTypeteacherRegister,
    BOUCountDownTypeModifyPhone,
};


@interface BOUTimerManager : NSObject

DEF_SINGLETON(BOUTimerManager);

- (void)timerCountDownWithType:(BOUCountDownType)countDownType;

- (void)cancelTimerWithType:(BOUCountDownType)countDownType;

@end

NS_ASSUME_NONNULL_END

