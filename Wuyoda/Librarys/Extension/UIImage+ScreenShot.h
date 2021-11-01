//
//  UIImage+ScreenShot.h
//  Weibo11
//
//  Created by 刘凡 on 15/12/12.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ScreenShot)

/// 获取屏幕截图
///
/// @return 屏幕截图图像
+ (UIImage *)screenShot;

//区域截图
+ (UIImage *)zoneScreenshot:(UIView *)screenshotView;

//区域滚动截图
+ (UIImage *)zoneScrollViewScreenshot:(UIScrollView *)scrollView;
@end
