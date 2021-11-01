//
//  UIView+FJHUD.m
//  FJFramework
//
//  Created by 樊静 on 2017/6/30.
//  Copyright © 2017年 樊静. All rights reserved.
//

#import "UIView+FJHUD.h"
#import <objc/runtime.h>
static const void *HUDLabelKey = &HUDLabelKey;

@implementation UIView (FJHUD)
- (void)setHUD:(UILabel *)hud{
    
    if (hud) {
        hud.height += 20;
        
        hud.textAlignment = NSTextAlignmentCenter;
        hud.layer.cornerRadius = kWidth(4);
        hud.clipsToBounds = YES;
        hud.backgroundColor = [UIColor colorWithHexString:@"#111111"];
//        hud.layer.shadowColor = [UIColor colorWithRed:48/255.0 green:50/255.0 blue:79/255.0 alpha:0.24].CGColor;
//        hud.layer.shadowOffset = CGSizeMake(2,1);
//        hud.layer.shadowOpacity = 1;
//        hud.layer.shadowRadius = 8;
//        hud.layer.cornerRadius = 4;
    }
    objc_setAssociatedObject(self,  HUDLabelKey, hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (UILabel *)getHUDLabel{
    
    return objc_getAssociatedObject(self, HUDLabelKey);
}

- (void)removeHud{
    
    UILabel *la = [self getHUDLabel];
    [la removeFromSuperview];
    
}

- (void)showHUDWithText:(NSString *)text withYOffSet:(CGFloat)yOffSet {
    
    
    UILabel * label = [self getHUDLabel];
    if (!label) {
        label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines = 0;
        label.textColor = [UIColor whiteColor];
        label.layer.cornerRadius = kWidth(4);
        
        
    }
    [[UIApplication sharedApplication].keyWindow addSubview:label];
    label.text = text;
    
    
    CGFloat labelW = labelSize(label.text, label.font, CGSizeMake(kScreenWidth-kWidth(20), MAXFLOAT)).width;
    CGFloat labelH = labelSize(label.text, label.font, CGSizeMake(kScreenWidth-kWidth(20), MAXFLOAT)).height;
    label.layer.cornerRadius = 1;

    if (labelW >= kScreenWidth - 60) {
        label.frame = CGRectMake((kScreenWidth - labelW+60)/2 , (kScreenHeight - labelH) / 3 + yOffSet + kHeight_NavBar, labelW-60, labelH+10);
        
    } else {
        label.frame = CGRectMake((kScreenWidth - labelW - 60)/2 , (kScreenHeight - labelH) / 3 + yOffSet+ kHeight_NavBar, labelW + 60, labelH);
    }
    
    
    [self setHUD:label];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeHud];
    });
}

-(void)showHUD {

   MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow  animated:YES];

    HUD.animationType=MBProgressHUDAnimationFade;

    [HUD showAnimated:YES];

    HUD.bezelView.backgroundColor = [UIColor blackColor];
    HUD.bezelView.style =  MBProgressHUDBackgroundStyleBlur;
    // 默认指示器是菊花

    HUD.mode = MBProgressHUDModeIndeterminate;

//    HUD.activityIndicatorColor = [UIColor whiteColor];
    HUD.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果（去掉半透明蒙版）

 //   HUD.dimBackground = NO;




}

-(void)hideHUD {
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}


@end
