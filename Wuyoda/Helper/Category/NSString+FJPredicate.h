//
//  NSString+FJPredicate.h
//  FJFramework
//
//  Created by 樊静 on 2017/6/30.
//  Copyright © 2017年 樊静. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FJPredicate)
//1. 验证手机号
- (BOOL)IsTruePhoneNum;  // YES 代表正确
//2. 验证身份证号
- (BOOL)IsTrueIdCardNum; // YES 代表正确
//3. 邮箱的有效性

- (BOOL)isTrueEmailAddress;  // YES 代表正确

//4. 是否是空字符
- (BOOL)isNULLString;   // YES 表示是空字符


// 表情符号的判断
+ (BOOL)stringContainsEmoji:(NSString *)string;

//是否是系统自带九宫格输入 yes-是 no-不是
+ (BOOL)isNineKeyBoard:(NSString *)string;

//判断第三方键盘中的表情
+ (BOOL)hasEmoji:(NSString*)string;

//去除表情
+ (NSString *)disableEmoji:(NSString *)text;

// 中英文混合的字符长度
+ (int)convertToInt:(NSString*)strtemp;

// 验证是不是密码 英文和数字
-(BOOL)isValidPasswordString;

@end
