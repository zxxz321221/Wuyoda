//
//  CommonManager.m
//  SunflowerFramework
//
//  Created by 樊静 on 2020/6/5.
//  Copyright © 2020 Sunflower. All rights reserved.
//

#import "CommonManager.h"
#import "CountDown.h"

@implementation CommonManager
/**
 获取当前最上边显示的ViewController

 @return 最上边的ViewController
 */
+ (UIViewController *)getCurrentViewController {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    if (@available(iOS 13.0, *)) {
            window = [UIApplication sharedApplication].windows[0];
    } else {
            window = [UIApplication sharedApplication].delegate.window;
    }
    
     UIViewController *rootViewController = window.rootViewController;
      if ([rootViewController isKindOfClass:[UITabBarController class]]) {
          UITabBarController *tabBarController = (UITabBarController *)rootViewController;
          UINavigationController *navController = tabBarController.selectedViewController;
          UIViewController *topViewController = navController.topViewController;
          return topViewController;
      }
      return rootViewController;
}

+ (CGFloat)getTextFitHeightwithText:(NSString *)text
                               width:(CGFloat)width
                            fontSize:(NSInteger)fontSize {
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: kFont(fontSize)} context:nil];
    return rect.size.height + 1;
}

// 数组转字符串
+ (NSString *)toReadableJSONString:(NSArray *)dataArr {
    NSData *data = [NSJSONSerialization dataWithJSONObject:dataArr
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
    if (data == nil) {
        return nil;
    }
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}

#pragma -- mark 登录
//+ (BOOL)login {
////
////    if ([FJAppSetting appsetting].token.length <=0 || [FJAppSetting appsetting].token == nil || [[FJAppSetting appsetting].token isNULLString]) {
////
////        //跳转登录页面模态跳转,需要带导航
//////        RootLoginAndRegViewController *loginVc = [[RootLoginAndRegViewController alloc]init];
//////        FJBaseNavigationController *loginNavi = [[FJBaseNavigationController alloc]initWithRootViewController:loginVc];
//////        loginNavi.modalPresentationStyle = UIModalPresentationFullScreen;
//////
//////        [[self getCurrentViewController].navigationController presentViewController:loginNavi animated:YES completion:^{
////
////  //      }];
////        return NO;
////    }else{
////        return YES;
////    }
//
//}
/**
 获取当前年月日
 
 @return 当前年月日
 */
+ (NSString *)getCurrentDateOfYearMonthDay:(NSDate *)date {
    //NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:date];
}

+ (NSString *)getCurrentDateOfYearMonth:(NSDate *)date {
    //NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM"];
    return [formatter stringFromDate:date];
}

/**
 获取当前年月日时分秒

 @return 当前年月日时分秒
 */
+ (NSString *)timeGetCurrentDateOfYearMonthDayHourMinutesSecond:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:date];
}

/**
 根据给定的日期返回该月的天数
 
 @param dateStr 特定的日期格式
 @return 该月天数
 */
+ (NSInteger)getNumberOfDayInMonthWithDateStr:(NSString *)dateStr {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy/MM"];
    NSDate * date = [dateFormatter dateFromString:dateStr];
    NSCalendar * calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSRange monthRange =  [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return monthRange.length;
}

/*数组写入本地*/
+ (void)writeArrayToLocal:(NSArray *)dataArr {
    
    //这个方法获取出的结果是一个数组.因为有可以搜索到多个路径.
       NSArray *array =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
       //在这里,我们指定搜索的是Cache目录,所以结果只有一个,取出Cache目录
       NSString *cachePath = array[0];
//       NSLog(@"%@",cachePath);
       //拼接文件路径
       NSString *filePathName = [cachePath stringByAppendingPathComponent:@"array.plist"];
       //用数组写,plist文件当中保存的类型是数组.
       //获取沙盒路径
       //ToFile:要写入的沙盒路径
    NSMutableArray *dataArray = [NSMutableArray array];
//    for (ProgramModel *mo in dataArr) {
//            NSDictionary*dic = [mo mj_keyValues];
//        [dataArray addObject:dic];
//    }
    [dataArray writeToFile:filePathName atomically:YES];

}
/*取出本地数组*/
+ (NSArray *)GetLocalArray {
     NSArray *array =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
       //在这里,我们指定搜索的是Cache目录,所以结果只有一个,取出Cache目录
       NSString *cachePath = array[0];
//       NSLog(@"%@",cachePath);
       //拼接文件路径
       NSString *filePathName = [cachePath stringByAppendingPathComponent:@"array.plist"];

       //从文件当中读取字典, 保存的plist文件就是一个字典,这里直接填写plist文件所存的路径
       NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePathName];
//       NSLog(@"%@",dict);
    NSMutableArray *arr = [NSMutableArray array];
    
       //如果保存的是一个数组.那就通过数组从文件当中加载.
       NSArray *dataArray = [NSArray arrayWithContentsOfFile:filePathName];
 //   [arr addObjectsFromArray:[ProgramModel mj_objectArrayWithKeyValuesArray:dataArray]];
//       NSLog(@"%@",arr);
    
        return arr;
}

+ (CGFloat)getStatusBarHight {
    float statusBarHeight = 0;
    if (@available(iOS 13.0, *)) {
        UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
        statusBarHeight = statusBarManager.statusBarFrame.size.height;
    }
    else {
        statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    return statusBarHeight;
}

//判断未登录跳登录
+ (BOOL)isLogin:(UIViewController *)viewCotroller isPush:(BOOL)isPush{
    UserInfoModel *model = [UserInfoModel getUserInfoModel];
    if (!model) {
        if (isPush) {
            LoginViewController *VC = [[LoginViewController alloc] init];
            VC.modalPresentationStyle = UIModalPresentationFullScreen;
            //[viewCotroller.navigationController pushViewController:VC animated:YES];
            FJBaseNavigationController *nav = [[FJBaseNavigationController alloc]initWithRootViewController:VC];
            nav.modalPresentationStyle = UIModalPresentationFullScreen;
            [viewCotroller presentViewController:nav animated:YES completion:nil];
        }
        
        return NO;
    }
    return YES;
}

//获知运费算法
+ (NSString *)freightCalculation:(int)goodsNum first:(float)first second:(float)second third:(float)third {
    NSString *resultStr = @"0.00";
    if (goodsNum == 1) {
        resultStr = [NSString stringWithFormat:@"%.2f",first];
        return resultStr;
    }else if (goodsNum > 1 && goodsNum < 5) {
        float result = 0.00;
        result = first + (goodsNum - 1)*second;
        resultStr = [NSString stringWithFormat:@"%.2f",result];
        return resultStr;
    }else if (goodsNum >= 5){
        float result = 0.00;
        result = first + 3*second + (goodsNum - 4)*third;
        resultStr = [NSString stringWithFormat:@"%.2f",result];
        return resultStr;
    }
    return resultStr;
}

+ (NSString *)getPriceType:(NSString *)type{
    if ([type isEqualToString:@"1"]) {
        return @"￡";
    }else if ([type isEqualToString:@"2"]) {
        return @"NT$";
    }else if ([type isEqualToString:@"3"]) {
        return @"$";
    }else if ([type isEqualToString:@"4"]) {
        return @"HK$";
    }else if ([type isEqualToString:@"5"]) {
        return @"PY¥";
    }else if ([type isEqualToString:@"6"]) {
        return @"₩";
    }else{
        return @"￥";
    }
}

+(void)addSingleSidesShadowToView:(UIView *)theView withColor:(UIColor*)theColor{
    theView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:70/255.0 blue:160/255.0 alpha:0.35].CGColor;
    theView.layer.shadowOffset = CGSizeMake(0,10);
    theView.layer.shadowOpacity = 1;
    theView.layer.shadowRadius = 15;
}
#pragma mark -------计算文字高度--------
+ (CGFloat)getString:(NSString *)string lineSpacing:(CGFloat)lineSpacing font:(UIFont*)font width:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = lineSpacing;
    NSDictionary *dic = @{ NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle };
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return  ceilf(size.height);
}
#pragma mark -------设置行间距--------
+(void)setLineSpace:(CGFloat)lineSpace withText:(NSString *)text inLabel:(UILabel *)label{
    if (!text || !label) {
        return;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace;  //设置行间距
    paragraphStyle.lineBreakMode = label.lineBreakMode;
    paragraphStyle.alignment = label.textAlignment;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    label.attributedText = attributedString;
}
#pragma mark ------文字后面拼图片--------
+ (NSAttributedString *)attachHeadImage:(UIImage *)headImage footImage:(UIImage *)footImage targatStr:(NSString *)targatStr {
    // 1.创建富文本
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:targatStr];
    
    // 2.创建NSTextAttachment:做图文混排的利器
//    NSTextAttachment *headAttchment = [NSTextAttachment new];
//    headAttchment.image = headImage;
//    headAttchment.bounds = CGRectMake(0, 0, 15, 15);
    
    NSTextAttachment *footAttchment = [NSTextAttachment new];
    footAttchment.image = footImage;
    footAttchment.bounds = CGRectMake(0, 0, kWidth(30), kWidth(15));
    
    // 3.将NSTextAttachment转化为NSAttributedString
//    NSAttributedString *headImageString = [NSAttributedString attributedStringWithAttachment:headAttchment];
    NSAttributedString *footImageString = [NSAttributedString attributedStringWithAttachment:footAttchment];
    
    // 4.拼接字符串
//    [attributedStr insertAttributedString:headImageString atIndex:0];
    [attributedStr appendAttributedString:footImageString];
 
    return attributedStr;
}
// 版本比较
/// @param currentVersion 当前app版本
/// @param appVersion 服务器返回版本
+ (BOOL)backVersionUpdate:(NSString *)currentVersion appVersion:(NSString *)appVersion {
    NSMutableArray *currentArr = [NSMutableArray array];
    NSMutableArray *appVersionArr = [NSMutableArray array];
    
    [currentArr addObjectsFromArray:[currentVersion componentsSeparatedByString:@"."]];
    [appVersionArr addObjectsFromArray:[appVersion componentsSeparatedByString:@"."]];
    if (currentArr.count == 2) {
        [currentArr addObject:@"0"];
    }
    if (appVersionArr.count == 2) {
        [appVersionArr addObject:@"0"];
    }
    
    if (currentArr.count == appVersionArr.count && currentArr.count == 3) {
        // 取第一位
        CGFloat currentFirst =  [currentArr[0] floatValue];
        CGFloat appversionFirst =  [appVersionArr[0] floatValue];

        if (appversionFirst > currentFirst) { // 第一位大于 直接更新
            return YES;
        }else {
            // 取第二位
            CGFloat currentSecond =  [currentArr[1] floatValue];
            CGFloat appversionSecond =  [appVersionArr[1] floatValue];
            if (appversionSecond > currentSecond) { // 第二位大于 直接更新
                return YES;
            }else {
                // 取第三位
                CGFloat currentThird =  [currentArr[2] floatValue];
                CGFloat appversionThird =  [appVersionArr[2] floatValue];
                if (appversionThird > currentThird) { // 第三位大于 直接更新
                    return YES;
                }else {
                    return NO;
                }
                
            }
        }
        return NO;
    }else {
        return NO;
    }
}

@end
