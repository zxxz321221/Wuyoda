//
//  LCTools.m
//  Reputation
//
//  Created by Imac on 2020/4/8.
//  Copyright © 2020 wyh. All rights reserved.
//

#import "LCTools.h"
#import <CommonCrypto/CommonCryptor.h>

#define cachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]


@interface LCTools()
//@property (nonatomic ,strong)AMapLocationManager *locationManager;

@end
@implementation LCTools

+(LCTools *)share{
    static LCTools *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

+ (void)logOut
{
//    [[EMClient sharedClient] logout:YES];
//    [[UserObject create] deleteFile];
//    UIApplication *application = [UIApplication sharedApplication];
//    [application setApplicationIconBadgeNumber:0];
//    [application cancelAllLocalNotifications];
//    NSMutableArray *arr = [NSMutableArray new];
//    PsdLoginViewController *vc = [PsdLoginViewController new];
//    FJBaseNavigationController *nav = [[FJBaseNavigationController alloc] initWithRootViewController:vc];
//    [[UIApplication sharedApplication] delegate].window.rootViewController = nav;
}
+(void)changeBtnImageRight:(UIButton *)btn
{
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, - btn.imageView.image.size.width, 0, btn.imageView.image.size.width)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, btn.titleLabel.bounds.size.width, 0, -btn.titleLabel.bounds.size.width)];
}
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+(NSString *)changePhone:(NSString *)phone
{
    if (!phone.length)
    {
        return @"";
    }
    if (phone.length<11)
    {
        return phone;
    }
    phone = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    return phone;
}
+ (BOOL)isValidateIdentityCard:(NSString *)identityCard
{
    BOOL flag;
    
    if (identityCard.length <= 0) {
        
        flag = NO;
        
        return flag;
        
    }
    
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    
    return [identityCardPredicate evaluateWithObject:identityCard];
    
}
+ (void)alertWithTitle:(NSString *)title
    messages:(NSString *)messages
 sureBlock:(void(^)())sureBlock
cannelClick:(void(^)())cannelClick
{
    UIAlertController *alview  = [UIAlertController alertControllerWithTitle:title message:messages preferredStyle:UIAlertControllerStyleAlert];
    [alview addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        cannelClick();
    }]];
    [alview addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        sureBlock();
    }]];
    UIViewController *vc = [LCTools getCurrentVC];
    [vc presentViewController:alview animated:YES completion:^{
        
    }];
}
+ (void)upLoadImage:(UIImage *)image successBlock:(void(^)(NSString *imagePath))successBlock failBlock:(void(^)())failBlock
{
    
}
+(NSString *)judgeEmptyString:(NSString *)string
{
    NSString *str = @"";
    if (!string || !string.length || [string isKindOfClass:[NSNull class]])
    {
        string = str;
    }
    return string;
}
+ (UIViewController *)jsd_getRootViewController{

    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    NSAssert(window, @"The window is empty");
    return window.rootViewController;
}

+ (UIViewController *)getCurrentVC
{
    UIViewController* currentViewController = [self jsd_getRootViewController];

    BOOL runLoopFind = YES;
    while (runLoopFind) {
       if (currentViewController.presentedViewController) {
           currentViewController = currentViewController.presentedViewController;
       } else {
           if ([currentViewController isKindOfClass:[UINavigationController class]]) {
               currentViewController = ((UINavigationController *)currentViewController).visibleViewController;
           } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
               currentViewController = ((UITabBarController* )currentViewController).selectedViewController;
           } else {
               break;
           }
       }
    }

    return currentViewController;

}
+ (void)setButtonImageAndTitleWithSpace:(CGFloat)spacing WithButton:(UIButton *)btn
{
    CGSize imageSize = btn.imageView.frame.size;
    CGSize titleSize = btn.titleLabel.frame.size;
    CGSize textSize = [btn.titleLabel.text sizeWithFont:btn.titleLabel.font];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    btn.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
}
+ (CGFloat)widthWithString:(NSString *)str font:(CGFloat)font
{
    CGSize size =[str sizeWithAttributes:@{NSFontAttributeName:kFont(font)}];
    return size.width;
}

///拨打电话
+ (void)PickPhoneWithPhoneNum:(NSString *)num
{
    UIApplication *application = [UIApplication sharedApplication];
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",num];
    NSURL *URL = [NSURL URLWithString:str];
    if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
      [application openURL:URL options:@{}
         completionHandler:^(BOOL success) {
      }];
    } else {
      BOOL success = [application openURL:URL];
    }
}
+ (NSString *)getMMSSFromSS:(NSInteger)totalTime{

    NSInteger seconds = totalTime;

    NSString *str_minute = [NSString stringWithFormat:@"%ld",seconds/60];
    NSString *str_second = [NSString stringWithFormat:@"%ld",seconds%60];
    NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];

    return format_time;

}
//正则手机号
+ (BOOL)checkTel:(NSString *)str
{
    str = [str stringByReplacingOccurrencesOfString:@" "withString:@""];
    if (str.length != 11)
    {
        return NO;
    }else{
        NSString *MOBILE = @"^1(3[0-9]|4[579]|5[0-35-9]|6[6]|7[0-35-9]|8[0-9]|9[89])\\d{8}$";
        NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
        return [regextestmobile evaluateWithObject:str];
    }
    
}
+ (CGFloat)getLabelFrame:(UILabel*)label setData:(NSString *)data setLabelWidth:(CGFloat)width
{
    if (data.length == 0)
    {
        return 0;
    }
    
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByCharWrapping;
    style.lineSpacing = 0;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:label.font,
                                 NSParagraphStyleAttributeName:style
                                 };
    
    label.attributedText = [[NSAttributedString alloc] initWithString:data attributes:attributes];
    CGRect frame = [label.text boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine  attributes:attributes context:nil];
    
    return frame.size.height;
}

+(CGFloat)getStringHeight:(NSString *)data Font:(UIFont *)font SetWidth:(CGFloat)width {
    if (data.length == 0)
    {
        return 0;
    }
    
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByCharWrapping;
    style.lineSpacing = 0;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:font,
                                 NSParagraphStyleAttributeName:style
                                 };
    
    CGRect frame = [data boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine  attributes:attributes context:nil];
    
    return frame.size.height;
}

+ (NSString*)objectToJson:(id)object
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

#pragma mark - RCIMUserInfoDataSource
//- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion {
//
//    //开发者调自己的服务器接口根据userID异步请求数据
//
//}

+ (BOOL)judgePassWordLegal:(NSString *)pass {

    NSInteger count = 0;
    // 验证密码长度
    if(pass.length < 8 || pass.length > 20) {
        return NO;
    }
    NSString *newPattern = @"^(?=.*)(?=.*[a-z])(?=.*[~!@#$%^&*:;,.=?$\x22]).{8,16}$";
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", newPattern];

   if ([regextestcm evaluateWithObject:pass] == YES)
   {
       return YES;
   }
   else
   {
       return NO;
   }

//    // 验证密码是否包含数字
//    NSString *numPattern = @".*\\d+.*";
//    NSPredicate *numPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numPattern];
//    if ([numPred evaluateWithObject:pass])
//    {
//        count++;
//    }
//
//    // 验证密码是否包含小写字母
//    NSString *lowerPattern = @".*[a-zA-Z]+.*";
//    NSPredicate *lowerPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", lowerPattern];
//    if ([lowerPred evaluateWithObject:pass])
//    {
//            count++;
//    }
//
//    // 验证密码是否包含大写字母
//    NSString *upperPattern = @".*[~!@#$^&|*-_+=.?,]+.*";
//    NSPredicate *upperPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", upperPattern];
//    if ([upperPred evaluateWithObject:pass])
//    {
//                count++;
//    }
//    if (count<3)
//    {
//        return NO;
//    }
//    return YES;
}
+ (void)addTextFieldLeftImage:(NSString *)image textField:(UITextField *)textfField;
{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0,40, textfField.height);
    UIImageView *leftImageView = [[UIImageView alloc] init];
    leftImageView.frame = CGRectMake(11, kWidth(13),24, 24);
    leftImageView.image = [UIImage imageNamed:image];
    [view addSubview:leftImageView];
    textfField.leftView = view;
    textfField.leftViewMode = UITextFieldViewModeAlways;
}

+ (void)shakeToShow:(UIView*)aView{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
    
}
+(NSString *)getNowTimeTimestamp
{

    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式

    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)([datenow timeIntervalSince1970]*1000)];

    return timeSp;
}
+(NSString *)convertToJsonData:(NSDictionary *)dict

{

    NSError *error;

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];

    NSString *jsonString;

    if (!jsonData) {

        NSLog(@"%@",error);

    }else{

        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];

    }

    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];

    NSRange range = {0,jsonString.length};

    //去掉字符串中的空格

    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];

    NSRange range2 = {0,mutStr.length};

    //去掉字符串中的换行符

    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];

    return mutStr;

}
+ (NSString *)gs_jsonStringCompactFormatForDictionary:(NSDictionary *)dicJson {


    if (![dicJson isKindOfClass:[NSDictionary class]] || ![NSJSONSerialization isValidJSONObject:dicJson]) {

        return nil;

    }

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicJson options:0 error:nil];

    NSString *strJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    return strJson;

}
+ (NSData *)resetSizeOfImageData:(UIImage *)sourceImage maxSize:(NSInteger)maxSize {
    //先判断当前质量是否满足要求，不满足再进行压缩
    __block NSData *finallImageData = UIImageJPEGRepresentation(sourceImage,1.0);
    NSUInteger sizeOrigin   = finallImageData.length;
    NSUInteger sizeOriginKB = sizeOrigin / 1000;
    
    if (sizeOriginKB <= maxSize) {
        return finallImageData;
    }
    
    //获取原图片宽高比
    CGFloat sourceImageAspectRatio = sourceImage.size.width/sourceImage.size.height;
    //先调整分辨率
    CGSize defaultSize = CGSizeMake(1024, 1024/sourceImageAspectRatio);
    UIImage *newImage = [self newSizeImage:defaultSize image:sourceImage];
    
    finallImageData = UIImageJPEGRepresentation(newImage,1.0);
    
    //保存压缩系数
    NSMutableArray *compressionQualityArr = [NSMutableArray array];
    CGFloat avg   = 1.0/250;
    CGFloat value = avg;
    for (int i = 250; i >= 1; i--) {
        value = i*avg;
        [compressionQualityArr addObject:@(value)];
    }
    
    /*
     调整大小
     说明：压缩系数数组compressionQualityArr是从大到小存储。
     */
    //思路：使用二分法搜索
    finallImageData = [self halfFuntion:compressionQualityArr image:newImage sourceData:finallImageData maxSize:maxSize];
    //如果还是未能压缩到指定大小，则进行降分辨率
    while (finallImageData.length == 0) {
        //每次降100分辨率
        CGFloat reduceWidth = 100.0;
        CGFloat reduceHeight = 100.0/sourceImageAspectRatio;
        if (defaultSize.width-reduceWidth <= 0 || defaultSize.height-reduceHeight <= 0) {
            break;
        }
        defaultSize = CGSizeMake(defaultSize.width-reduceWidth, defaultSize.height-reduceHeight);
        UIImage *image = [self newSizeImage:defaultSize
                                      image:[UIImage imageWithData:UIImageJPEGRepresentation(newImage,[[compressionQualityArr lastObject] floatValue])]];
        finallImageData = [self halfFuntion:compressionQualityArr image:image sourceData:UIImageJPEGRepresentation(image,1.0) maxSize:maxSize];
    }
    return finallImageData;
}
#pragma mark 调整图片分辨率/尺寸（等比例缩放）
+ (UIImage *)newSizeImage:(CGSize)size image:(UIImage *)sourceImage {
    CGSize newSize = CGSizeMake(sourceImage.size.width, sourceImage.size.height);
    
    CGFloat tempHeight = newSize.height / size.height;
    CGFloat tempWidth = newSize.width / size.width;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempWidth, sourceImage.size.height / tempWidth);
    } else if (tempHeight > 1.0 && tempWidth < tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempHeight, sourceImage.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [sourceImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
#pragma mark 二分法
+ (NSData *)halfFuntion:(NSArray *)arr image:(UIImage *)image sourceData:(NSData *)finallImageData maxSize:(NSInteger)maxSize {
    NSData *tempData = [NSData data];
    NSUInteger start = 0;
    NSUInteger end = arr.count - 1;
    NSUInteger index = 0;
    
    NSUInteger difference = NSIntegerMax;
    while(start <= end) {
        index = start + (end - start)/2;
        
        finallImageData = UIImageJPEGRepresentation(image,[arr[index] floatValue]);
        
        NSUInteger sizeOrigin = finallImageData.length;
        NSUInteger sizeOriginKB = sizeOrigin / 1024;
        NSLog(@"当前降到的质量：%ld", (unsigned long)sizeOriginKB);
        NSLog(@"\nstart：%zd\nend：%zd\nindex：%zd\n压缩系数：%lf", start, end, (unsigned long)index, [arr[index] floatValue]);
        
        if (sizeOriginKB > maxSize) {
            start = index + 1;
        } else if (sizeOriginKB < maxSize) {
            if (maxSize-sizeOriginKB < difference) {
                difference = maxSize-sizeOriginKB;
                tempData = finallImageData;
            }
            if (index<=0) {
                break;
            }
            end = index - 1;
        } else {
            break;
        }
    }
    return tempData;
}

+ (NSString *)currentDate
{
    NSString *time;
    NSDate *date =[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    NSInteger currentYear=[[formatter stringFromDate:date] integerValue];
    [formatter setDateFormat:@"MM"];
    NSInteger currentMonth=[[formatter stringFromDate:date]integerValue];
    [formatter setDateFormat:@"dd"];
    NSInteger currentDay=[[formatter stringFromDate:date] integerValue];
    NSString *day = [NSString stringWithFormat:@"%ld",currentDay];
    NSString *month = [NSString stringWithFormat:@"%ld",currentMonth];
    NSString *week = [self weekdayStringFromDate:date];
    if (currentMonth < 10)
    {
         month = [NSString stringWithFormat:@"0%@",month];
    }
    if (currentDay < 10)
    {
        day = [NSString stringWithFormat:@"0%@",day];

    }
    time = [NSString stringWithFormat:@"%ld年%@月%@日 %@",currentYear,month,day,week];

    return time;
}
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {

    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];

    [calendar setTimeZone: timeZone];

    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;

    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];

    return [weekdays objectAtIndex:theComponents.weekday];

}
+ (NSString *)getHours
{
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitHour;//小时
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:nowDate];
    
    NSInteger hour = [dateComponent hour];
    NSInteger subHour = hour +1;
    NSString *hours = [NSString stringWithFormat:@"%ld:00-%ld:00",hour,subHour];
    return hours;

}

+ (NSString *)AES128Encrypt:(NSDictionary *)dict key:(NSString *)key
{
    char keyPtr[kCCKeySizeAES128+1];//
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSData* data = [@"Hello ~ World" dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *data = [self compactFormatDataForDictionary:dict];
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        NSString *stringBase64 = [resultData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed]; // base64格式的字符串
        return stringBase64;
        
    }
    free(buffer);
    return nil;
}

+ (NSData *)compactFormatDataForDictionary:(NSDictionary *)dicJson

{

    if (![dicJson isKindOfClass:[NSDictionary class]]) {

        return nil;

    }

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicJson options:0 error:nil];

    if (![jsonData isKindOfClass:[NSData class]]) {

        return nil;

    }

    return jsonData;

}
+(NSString *)getCachesSize
{

    //1.获取“cachePath”文件夹下面的所有文件
    NSArray *subpathArray= [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    
    NSString *filePath = nil;
    long long totalSize = 0;
    
    for (NSString *subpath in subpathArray) {
        
        // 拼接每一个文件的全路径
        filePath =[cachePath stringByAppendingPathComponent:subpath];
        
        BOOL isDirectory = NO;   //是否文件夹，默认不是
        
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];   // 判断文件是否存在
        
        // 文件不存在,是文件夹,是隐藏文件都过滤
        if (!isExist || isDirectory || [filePath containsString:@".DS"]) continue;
        
        // attributesOfItemAtPath 只可以获得文件属性，不可以获得文件夹属性，
        //这个也就是需要遍历文件夹里面每一个文件的原因
        
        long long fileSize = [[[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil] fileSize];
        
        totalSize += fileSize;
        
    }
    
    // 2.将文件夹大小转换为 M/KB/B
    NSString *totalSizeString = nil;
    
    if (totalSize > 1000 * 1000) {
        
        totalSizeString = [NSString stringWithFormat:@"%.1fM",totalSize / 1000.0f /1000.0f];
        
    } else if (totalSize > 1000) {
        
        totalSizeString = [NSString stringWithFormat:@"%.1fKB",totalSize / 1000.0f ];
        
    } else {
        
        totalSizeString = [NSString stringWithFormat:@"%.1fB",totalSize / 1.0f];
        
    }
    
    return totalSizeString;
    
}
+ (BOOL)removeCache{
    
    // 1.拿到cachePath路径的下一级目录的子文件夹
    // contentsOfDirectoryAtPath:error:递归
    // subpathsAtPath:不递归
    
    NSArray *subpathArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:cachePath error:nil];
    
    // 2.如果数组为空，说明没有缓存或者用户已经清理过，此时直接return
    if (subpathArray.count == 0) {
//        [SVProgressHUD showNOmessage:@"缓存已清理"];
        return NO;
    }

    NSError *error = nil;
    NSString *filePath = nil;
    BOOL flag = NO;
    
    NSString *size = [self getCachesSize];
    
    for (NSString *subpath in subpathArray) {
        
        filePath = [cachePath stringByAppendingPathComponent:subpath];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
            
            // 删除子文件夹
            BOOL isRemoveSuccessed = [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
            
            if (isRemoveSuccessed) { // 删除成功
                
                flag = YES;
            }
        }
        
    }
    
//    if (NO == flag)
//        [SVProgressHUD showNOmessage:@"缓存已清理"];
//    else
//        [SVProgressHUD showYESmessage:[NSString stringWithFormat:@"为您腾出%@空间",size]];
        
    return flag;
    
}
@end
