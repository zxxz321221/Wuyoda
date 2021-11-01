//
//  UIImage+ScreenShot.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/12.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "UIImage+ScreenShot.h"

@implementation UIImage (ScreenShot)

/// 获取屏幕截图
///
/// @return 屏幕截图图像
+ (UIImage *)screenShot {
    // 1. 获取到窗口
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    // 2. 开始上下文
    UIGraphicsBeginImageContextWithOptions(window.bounds.size, YES, 0);
    
    // 3. 将 window 中的内容绘制输出到当前上下文
    [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:NO];
    
    // 4. 获取图片
    UIImage *screenShot = UIGraphicsGetImageFromCurrentImageContext();
    
    // 5. 关闭上下文
    UIGraphicsEndImageContext();
    
    return screenShot;
}

//区域截图
+ (UIImage *)zoneScreenshot:(UIView *)screenshotView; {
    UIGraphicsBeginImageContextWithOptions(screenshotView.bounds.size, YES, 0);
    // 3. 将 window 中的内容绘制输出到当前上下文
    [screenshotView drawViewHierarchyInRect:screenshotView.bounds afterScreenUpdates:NO];
    // 4. 获取图片
    UIImage *screenShot = UIGraphicsGetImageFromCurrentImageContext();
    // 5. 关闭上下文
    UIGraphicsEndImageContext();
    return screenShot;
}

//区域滚动截图
+ (UIImage *)zoneScrollViewScreenshot:(UIScrollView *)scrollView {
    UIImage *image = nil;
    UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, scrollView.opaque, 0.0);//scrollView.opaque或者NO保证不失真
       {//重点，既要获取整个scrollerView,又要保证不破环界面本身
           CGPoint savedContentOffset = scrollView.contentOffset;
           CGRect savedFrame = scrollView.frame;
           scrollView.contentOffset = CGPointZero;
           scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
           [scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
           image = UIGraphicsGetImageFromCurrentImageContext();
           scrollView.contentOffset = savedContentOffset;
           scrollView.frame = savedFrame;
       }
       UIGraphicsEndImageContext();
    return image;
}



@end
