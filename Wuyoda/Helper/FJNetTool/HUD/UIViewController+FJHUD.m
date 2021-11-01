//
//  UIViewController+FJHUD.m
//  DLFramework
//
//  Created by 樊静 on 2019/5/13.
//  Copyright © 2019 樊静. All rights reserved.
//

#import "UIViewController+FJHUD.h"
#import "FJProgressHUD.h"
#import <objc/runtime.h>
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )


static const void *HttpRequestHUDKey = &HttpRequestHUDKey;
static const void *HttpRequestMXHUDKey = &HttpRequestMXHUDKey;

@implementation UIViewController (FJHUD)
- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}

- (FJProgressHUD *)FJHUD{
    return objc_getAssociatedObject(self, HttpRequestMXHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setFJHUD:(FJProgressHUD *)HUD {
    objc_setAssociatedObject(self, HttpRequestMXHUDKey, HUD,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showHudInView:(UIView *)view hint:(NSString *)hint{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.label.text = hint;
    [view addSubview:HUD];
    [HUD showAnimated:YES];
    [self setHUD:HUD];
}

- (void)showHint:(NSString *)hint {

    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
    hud.margin = 10.f;

    //     hud.offset = (CGPoint){hud.offset.x,IS_IPHONE_5?200.f:150.f};
    hud.offset = (CGPoint){hud.offset.x, kScreenHeight / 3};
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
    [self setHUD:hud];
}

- (void)showHint:(NSString *)hint yOffset:(float)yOffset {
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
    hud.margin = 10.f;


    //    hud.offset = (CGPoint){hud.offset.x,IS_IPHONE_5?200.f:150.f};
    hud.offset = (CGPoint){hud.offset.x, kScreenHeight / 3};

    CGFloat y = hud.offset.y;

    y += yOffset;

    hud.offset = (CGPoint){hud.offset.x,y};

    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
    [self setHUD:hud];
}

- (void)hideHud{


    [self.FJHUD removeSubLayer];
    [self.FJHUD removeFromSuperview];
    for (UIView * v  in [[UIApplication sharedApplication].delegate window].subviews) {
        if ([v isKindOfClass:[FJProgressHUD class]]){
            [v removeFromSuperview];
        }
    }

    [[self HUD] hideAnimated:YES];
}

- (void)showFJHint:(NSString *)hint yOffset:(float)yOffset {
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
    hud.label.textColor = [UIColor whiteColor];
    hud.label.font = [UIFont systemFontOfSize:15.0];
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.bezelView.alpha = 0.9;
    hud.bezelView.layer.cornerRadius = 10;
    hud.margin = 10.f;
    hud.bezelView.height += 10;
    hud.bezelView.width += 20;
    //    hud.yOffset = IS_IPHONE_5?200.f:150.f;
    hud.offset = (CGPoint){hud.offset.x,yOffset};
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
    [self setHUD:hud];
}

- (void)showFJAnimationHint:(NSString *)hit withAnimate:(BOOL)animate {
    UIView *view = [[UIApplication sharedApplication].delegate window];


    FJProgressHUD * hud = [self FJHUD];
    if (!hud) {
        hud = [[FJProgressHUD alloc] init];
    }

    if (hit) {
        hud.hintTextFont = 12;
        [hud showAnimationWithHint:hit];
        hud.frame = CGRectMake((view.width - 80)/2, (view.height - 80)/2, 80, 80);
    } else {
        [hud showAnimationAtView:nil];
        hud.frame = CGRectMake((view.width - 100)/2, (view.height - 100)/2, 100, 100);
    }

    [view addSubview:hud];


    [self setFJHUD:hud];
}


- (void)showFJAnimationHint:(NSString *)hit withAnimate:(BOOL)animate withColor:(UIColor *)color {
    UIView *view = [[UIApplication sharedApplication].delegate window];


    FJProgressHUD * hud = [self FJHUD];
    if (!hud) {
        hud = [[FJProgressHUD alloc] init];
        //hud.defaultBackGroundColor = color;
    }

    if (hit) {
        hud.hintTextFont = 12;
        [hud showAnimationWithHint:hit];
        hud.frame = CGRectMake((view.width - 80)/2, (view.height - 80)/2, 80, 80);
    } else {
        [hud showAnimationAtView:nil];
        hud.frame = CGRectMake((view.width - 100)/2, (view.height - 100)/2, 100, 100);
    }

    [view addSubview:hud];

    hud.foregroundColor = color;

    [self setFJHUD:hud];
}



@end
