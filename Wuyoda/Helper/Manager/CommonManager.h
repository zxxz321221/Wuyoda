//
//  CommonManager.h
//  SunflowerFramework
//
//  Created by 樊静 on 2020/6/5.
//  Copyright © 2020 Sunflower. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonManager : NSObject
/**
 获取当前最上边显示的ViewController

 @return 最上边的ViewController
 */
+ (UIViewController *)getCurrentViewController;


// 获取多行文字高度
+ (CGFloat)getTextFitHeightwithText:(NSString *)text
   width:(CGFloat)width
                           fontSize:(NSInteger)fontSize;

////登录
//+(BOOL)login;

/**
 获取当前年月日
 
 @return 当前年月日
 */
+ (NSString *)getCurrentDateOfYearMonthDay;
/**
 获取当前年月日时分秒

 @return 当前年月日时分秒
 */
+ (NSString *)timeGetCurrentDateOfYearMonthDayHourMinutesSecond;

/**
 根据给定的日期返回该月的天数
 
 @param dateStr 特定的日期格式
 @return 该月天数
 */
+ (NSInteger)getNumberOfDayInMonthWithDateStr:(NSString *)dateStr;

/*数组写入本地*/
+ (void)writeArrayToLocal:(NSArray *)dataArr;
/*取出本地数组*/
+ (NSArray *)GetLocalArray;

+ (CGFloat)getStatusBarHight;

//判断未登录跳登录
+ (BOOL)isLogin:(UIViewController *)viewCotroller;

// 数组转字符串
+ (NSString *)toReadableJSONString:(NSArray *)dataArr;

//获知运费算法
+ (NSString *)freightCalculation:(int)goodsNum first:(float)first second:(float)second third:(float)third;

// ------处理广告图跳转------
+ (void)bannerJump:(int)type viewController:(UIViewController *)viewController parStr:(NSString *)parStr;
/*加下阴影*/
+(void)addSingleSidesShadowToView:(UIView *)theView withColor:(UIColor*)theColor;

+ (CGFloat)getString:(NSString *)string lineSpacing:(CGFloat)lineSpacing font:(UIFont*)font width:(CGFloat)width;
#pragma mark -------设置行间距--------
+(void)setLineSpace:(CGFloat)lineSpace withText:(NSString *)text inLabel:(UILabel *)label;
#pragma mark ------文字后面拼图片--------
+ (NSAttributedString *)attachHeadImage:(UIImage *)headImage footImage:(UIImage *)footImage targatStr:(NSString *)targatStr;

// 版本更新 判断
+ (BOOL)backVersionUpdate:(NSString *)currentVersion appVersion:(NSString *)appVersion;

@end

NS_ASSUME_NONNULL_END
