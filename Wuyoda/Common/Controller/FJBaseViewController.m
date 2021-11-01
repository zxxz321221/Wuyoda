//
//  FJBaseViewController.m
//  FJFramework
//
//  Created by 樊静 on 2017/6/30.
//  Copyright © 2017年 樊静. All rights reserved.
//

#import "FJBaseViewController.h"
#import <objc/runtime.h>

@interface FJBaseViewController () 
@property(nonatomic,strong)UIButton *backBtn;
@end

@implementation FJBaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    self.view.backgroundColor = [UIColor whiteColor];

 //   self.navigationController.navigationBar.hidden = YES;

//    [self hiddenNavigationBarSeparatorLine];
//
//    [self setUpLeftBackButton];

    
    //nav带阴影
    //  [self dropShadowWithOffset:CGSizeMake(0, 5)
    //                            radius:6
    //                             color:[UIColor colorWithWhite:0 alpha:0.35f]
    //                           opacity:0.5];

}

//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//    // 系统模态方法做方法交换
//    Method systemPresent = class_getInstanceMethod(self,@selector(presentViewController:animated:completion:));
//        Method custom_Method = class_getInstanceMethod(self,@selector(myPresentViewController:ToPresentanimated:completion:));
//    method_exchangeImplementations(systemPresent, custom_Method);
//
//    });
//}
//
//- (void)myPresentViewController:(UIViewController*)viewController ToPresentanimated:(BOOL)flag completion:(void(^)(void))completion {
//
//    //设置满屏，可以半透明
//    if(@available(iOS 13.0,*)) {
//
////        if([viewController isKindOfClass:[YourViewController class]]) {
////
////            viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
////
////        } else {//UIModalPresentationOverFullScreen 半透明 不走viewwilldisappear
//
//        viewController.modalPresentationStyle = UIModalPresentationFullScreen; //不透明 走viewwilldisappear
//
//       // }
//
//    }
//    [self myPresentViewController:viewController ToPresentanimated:flag completion:completion];
//}

- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity {

    // Creating shadow path for better performance
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL,  self.navigationController.navigationBar.bounds);
    self.navigationController.navigationBar.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);

     self.navigationController.navigationBar.layer.shadowColor = color.CGColor;
     self.navigationController.navigationBar.layer.shadowOffset = offset;
     self.navigationController.navigationBar.layer.shadowRadius = radius;
    self.navigationController.navigationBar.layer.shadowOpacity = opacity;


}
- (void)hiddenNavigationBarSeparatorLine {
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIView class]]) {
                UIView *imageView=(UIView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden = imageView2.bounds.size.height < 1;
                    }
                }
            }
        }
    }
}
#pragma mark - 左边返回按钮
- (void)setHideLeftButton:(BOOL)hideLeftButton
{
    _hideLeftButton = hideLeftButton;
    if (hideLeftButton) {
        self.navigationItem.leftBarButtonItem = nil;
    }
}
- (void)setUpLeftBackButton {
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBackButtonClick:)];
//    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];

        self.backBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
        self.backBtn.frame = CGRectMake(0, 0, 60, 40);
    [self.backBtn addTarget:self action:@selector(leftBackButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.backBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.backBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        [self.backBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateHighlighted];
        [self.backBtn setImage:[UIImage imageNamed:@"login_back"] forState:UIControlStateNormal];
        self.backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
}

- (void)leftBackButtonClick:(UIButton *)sender {
    if (self.presentingViewController)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }

  
}
- (void)updateBackColor {
     [self.backBtn setImage:[UIImage imageNamed:@"basc_whiteBack"] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
