//
//  NSString+Extension.h
//  NewHotel
//
//  Created by 樊静 on 2018/11/6.
//  Copyright © 2018 樊静. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

@interface NSString (Extension)
//1. 验证手机号
- (BOOL)IsTruePhoneNum;  // YES 代表正确
//2. 验证身份证号
- (BOOL)IsTrueIdCardNum; // YES 代表正确
//3. 邮箱的有效性

- (BOOL)isTrueEmailAddress;  // YES 代表正确

//4. 是否是空字符
- (BOOL)isNULLString;   // YES 表示是空字符

/**
 *  md5加密
 *
 *  @return 加密后的字符串
 */
- (NSString *)md5;

/**
 md5加密区分32、16位与大小写

 @param str 需要md5加密的字符串
 @param bateNum 填32即32位md5，16或32之外的即16位md5
 @param isLowercaseStr YES即小写，NO即大写
 @return md5加密后的字符串
 */
+ (NSString *)md5EncryptStr:(NSString *)str bateNum:(NSInteger)bateNum isLowercaseStr:(BOOL)isLowercaseStr;

// 表情符号的判断
+ (BOOL)stringContainsEmoji:(NSString *)string;

//是否是系统自带九宫格输入 yes-是 no-不是
+ (BOOL)isNineKeyBoard:(NSString *)string;

//判断第三方键盘中的表情
+ (BOOL)hasEmoji:(NSString*)string;

//去除表情
+ (NSString *)disableEmoji:(NSString *)text;

// URL转码
+(NSString *)URLEncode:(NSString *)string;

//URL解码
+ (NSString *)URLDecode:(NSString *)string;

// 字符串是否是全数字
+(BOOL)deptNumInputShouldNumber:(NSString *)str;


+(BOOL)isEmptyAndReturn:(NSString *)str;



+ (NSAttributedString *)getAttributeWith:(id)sender
        string:(NSString *)string
     orginFont:(UIFont *)orginFont
    orginColor:(UIColor *)orginColor
 attributeFont:(UIFont *)attributeFont
                          attributeColor:(UIColor *)attributeColor;



-(BOOL)isValidPasswordString;



// 指定字符串随机生成指定长度的新字符串
+(NSString *)randomStringWithLength:(NSInteger)len String:(NSString *)letters;

@end
