//
//  UITabBar+badge.h
//  DuiDianIMProject
//
//  Created by 樊静 on 2020/2/14.
//  Copyright © 2020 longcai. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBar (badge)

- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点

@end

NS_ASSUME_NONNULL_END
