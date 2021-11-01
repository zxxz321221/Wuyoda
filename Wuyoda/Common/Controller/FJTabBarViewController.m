//
//  FJTabBarViewController.m
//  FJFramework
//
//  Created by 樊静 on 2017/6/30.
//  Copyright © 2017年 樊静. All rights reserved.
//

#import "FJTabBarViewController.h"
#import "FJBaseNavigationController.h"
#import "HomeViewController.h"
#import "WishViewController.h"
#import "ShoppingCarViewController.h"
#import "MineViewController.h"

@interface FJTabBarViewController () <UITabBarControllerDelegate>
@end

@implementation FJTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    [self setTabBarVC];
   
    self.tabBar.translucent = NO;
    self.tabBar.barTintColor = [ColorManager WhiteColor];
   [self.tabBar insertSubview:[self drawTabbarBgImageView] atIndex:0];
    
}

// 画背景的方法，返回 Tabbar的背景
- (UIImageView *)drawTabbarBgImageView
{

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth , kHeight_TabBar)];//
    imageView.backgroundColor = [UIColor whiteColor];

    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(25, 25)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = imageView.bounds;
    maskLayer.path = maskPath.CGPath;
    imageView.layer.mask = maskLayer;
    imageView.layer.shadowColor = [UIColor blackColor].CGColor;

    imageView.layer.shadowOffset = CGSizeMake(0,-2);
    imageView.layer.shadowOpacity = 1;
    imageView.layer.shadowRadius = 5;
    return imageView;
}


// 初始化所有子控制器
- (void)setTabBarVC {
    
    HomeViewController *mainVC = [[HomeViewController alloc] init];
    [self setTabBarChildController:mainVC title:@"首页" image:@"首页" selectImage:@"首页拷贝"];

    WishViewController *wishVC = [[WishViewController alloc] init];
    [self setTabBarChildController:wishVC title:@"心愿单" image:@"心愿单" selectImage:@"心愿单拷贝"];

    ShoppingCarViewController *shoppingCarVC = [[ShoppingCarViewController alloc] init];
    [self setTabBarChildController:shoppingCarVC title:@"购车" image:@"购物车" selectImage:@"购物车拷贝"];

    MineViewController *mineVC = [[MineViewController alloc] init];
    [self setTabBarChildController:mineVC title:@"我的" image:@"我的" selectImage:@"我的拷贝"];

}

//添加tabbar的子viewcontroller
- (FJBaseNavigationController *)setTabBarChildController:(UIViewController*)controller title:(NSString*)title image:(NSString*)imageStr selectImage:(NSString*)selectImageStr{
    
    FJBaseNavigationController *baseNav = [[FJBaseNavigationController alloc] initWithRootViewController:controller];
    baseNav.tabBarItem.title = title;
    
    baseNav.tabBarItem.image = [[UIImage imageNamed:imageStr]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    baseNav.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageStr]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //改变中间按钮的位置
//    if ([title isEqualToString:@"会员中心"]) {
//        baseNav.tabBarItem.imageInsets = UIEdgeInsetsMake(-13, 0, 0, 0);
//    }
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:kFont(11),NSForegroundColorAttributeName:[ColorManager BlackColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:kBoldFont(11),NSForegroundColorAttributeName:[ColorManager BlackColor]} forState:UIControlStateSelected];

    [self addChildViewController:baseNav];
    return baseNav;
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
