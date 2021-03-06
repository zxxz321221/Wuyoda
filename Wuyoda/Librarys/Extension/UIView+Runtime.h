//
//  UIView+Runtime.h
//  Weibo11
//
//  Created by 刘凡 on 15/12/12.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Runtime)

/// 查找子视图
///
/// @param view      要查找的视图
/// @param clazzName 子控件类名
///
/// @return 找到的第一个子视图
+ (UIView *)ff_firstInView:(UIView *)view clazzName:(NSString *)clazzName;

/// TODO: 可以抽取到 NSObject 分类中国年
/// 遍历当前视图的成员变量 - 仅供测试使用
- (void)ff_ivarsList;

@end
