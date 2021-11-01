//
//  UIViewController+FJHUD.h
//  DLFramework
//
//  Created by 樊静 on 2019/5/13.
//  Copyright © 2019 樊静. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJProgressHUD.h"
NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (FJHUD)

@property  (nonatomic,strong) FJProgressHUD * FJHUD;
- (void)showHudInView:(UIView *)view hint:(NSString *)hint;

- (void)hideHud;

- (void)showHint:(NSString *)hint;

// 从默认(showHint:)显示的位置再往上(下)yOffset
- (void)showHint:(NSString *)hint yOffset:(float)yOffset;

- (void)showFJHint:(NSString *)hint yOffset:(float)yOffset;

- (void)showFJAnimationHint:(NSString *)hint withAnimate:(BOOL)animate;

- (void)showFJAnimationHint:(NSString *)hit withAnimate:(BOOL)animate withColor:(UIColor *)color ;
@end

NS_ASSUME_NONNULL_END
