//
//  LCTools.h
//  Reputation
//
//  Created by Imac on 2020/4/8.
//  Copyright © 2020 wyh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCTools : NSObject

+ (LCTools *)share;
///退出登录
+ (void)logOut;
//阴影
+ (void)makeShadow:(UIView *)view;
//获取当前控制器
+ (UIViewController *)getCurrentVC;
//按钮图片文字居中
+ (void)setButtonImageAndTitleWithSpace:(CGFloat)spacing WithButton:(UIButton *)btn;
//正则手机号
+ (BOOL)checkTel:(NSString *)str;
//正则身份证
+ (BOOL)isValidateIdentityCard:(NSString *)identityCard;
//颜色生成图片
+ (UIImage *)imageWithColor:(UIColor *)color;
//文字宽
+ (CGFloat)widthWithString:(NSString *)str font:(CGFloat)font;
//文字高度
+ (CGFloat)getLabelFrame:(UILabel*)label setData:(NSString *)data setLabelWidth:(CGFloat)width;
//转json字符串
+ (NSString*)objectToJson:(id)object;
//btn图片右侧
+(void)changeBtnImageRight:(UIButton *)btn;
//改变电话*号
+(NSString *)changePhone:(NSString *)phone;
+(NSString *)judgeEmptyString:(NSString *)string;
///拨打电话
+ (void)PickPhoneWithPhoneNum:(NSString *)num;
//Alert
+ (void)alertWithTitle:(NSString *)title
messages:(NSString *)messages
 sureBlock:(void(^)())sureBlock
cannelClick:(void(^)())cannelClick;
+ (void)alertBlackMessage:(NSString *)text view:(UIView *)view afterDelay:(NSTimeInterval)delay;
//密码验证8-16位
+ (BOOL)judgePassWordLegal:(NSString *)pass;
//textfield添加左侧图片
+ (void)addTextFieldLeftImage:(NSString *)image textField:(UITextField *)textfField;
//时间戳
+(NSString *)getNowTimeTimestamp;
//字典转json
+(NSString *)convertToJsonData:(NSDictionary *)dict;
//上传
+ (void)upLoadImage:(UIImage *)image successBlock:(void(^)(NSString *imagePath))successBlock failBlock:(void(^)())failBlock;
//图片压缩指定大小
+ (NSData *)resetSizeOfImageData:(UIImage *)sourceImage maxSize:(NSInteger)maxSize;
//获取年月日周几
+ (NSString *)currentDate;
+ (NSString *)AES128Encrypt:(NSDictionary *)dict key:(NSString *)key;
+ (NSString *)gs_jsonStringCompactFormatForDictionary:(NSDictionary *)dicJson;
+ (NSString *)getCachesSize;
+ (BOOL)removeCache;

+(CGFloat)getStringHeight:(NSString *)data Font:(UIFont *)font SetWidth:(CGFloat)width ;
@end

NS_ASSUME_NONNULL_END
