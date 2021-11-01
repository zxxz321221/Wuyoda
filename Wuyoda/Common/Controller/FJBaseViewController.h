//
//  FJBaseViewController.h
//  FJFramework
//
//  Created by 樊静 on 2017/6/30.
//  Copyright © 2017年 樊静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FJBaseViewController : UIViewController
/** 隐藏左上角返回按钮 */
@property(nonatomic, assign) BOOL hideLeftButton;

/**更改返回按钮颜色*/
- (void)updateBackColor;

/** 返回按钮事件，子类可重写此方法处理相关返回逻辑 */
- (void)leftBackButtonClick:(UIButton *)sender;

/**图片创建导航右侧按钮*/
- (void)addNavigationRightImage:(NSString*)image;

/**导航右侧按钮点击*/
- (void)navRightButtonClick:(UIButton*)sender;



@end
