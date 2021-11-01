//
//  FJBaseNavigationController.m
//  FJFramework
//
//  Created by 樊静 on 2017/6/30.
//  Copyright © 2017年 樊静. All rights reserved.
//

#import "FJBaseNavigationController.h"

@interface FJBaseNavigationController ()

@end

@implementation FJBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIImage *bgImage = [UIImage imageWithColor:WHITE];
//     bgImage = [bgImage resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
//     [self.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.hidden = YES;
  //   [self.navigationBar setShadowImage:[UIImage new]];

 //    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : KText33Color,NSFontAttributeName:kFont(18)}];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    
    [super pushViewController:viewController animated:animated];
}
- (NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    if (self.viewControllers.count > 1) {
        self.topViewController.hidesBottomBarWhenPushed = NO;
    }
    NSArray<__kindof UIViewController *> *viewControllers = [super popToRootViewControllerAnimated:animated];
    // self.viewControllers has two items here on iOS14
    return viewControllers;
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
