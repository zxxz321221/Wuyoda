//
//  FJNewFeatureViewController.m
//  NewHotel
//
//  Created by 樊静 on 2018/9/27.
//  Copyright © 2018年 樊静. All rights reserved.
//

#import "FJNewFeatureViewController.h"
#import "WOPageControl.h"
#define NewfeatureCount 4

@interface FJNewFeatureViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) WOPageControl *pageControl;

@end

@implementation FJNewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   [self setupScrollView];
   // [self createSkipBt];
}
//创建UIScrollView并添加图片
- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:scrollView];

    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(NewfeatureCount*kScreenWidth, 0);
    scrollView.delegate = self;

    for (NSInteger i = 0; i < NewfeatureCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.left = i * kScreenWidth;
        imageView.top = 0;
        imageView.width = kScreenWidth;
        imageView.height = kScreenHeight;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        NSString *name = [NSString stringWithFormat:@"引导页%ld",i+1];
        imageView.image = [UIImage imageNamed:name];
        [scrollView addSubview:imageView];
        if (i == NewfeatureCount - 1) {
            [self setupStartBtn:imageView];
        }
    }
    
//    //小圆点
//    self.pageControl = [[WOPageControl alloc] initWithFrame:CGRectMake(0, kScreenHeight - kWidth(85), kScreenWidth, kWidth(20))];
//    self.pageControl.cornerRadius = kWidth(5);
//    self.pageControl.dotHeight = kWidth(10);
//    self.pageControl.dotSpace = kWidth(10);
//    self.pageControl.currentDotWidth = kWidth(10);
//    self.pageControl.otherDotWidth = kWidth(10);
//    self.pageControl.otherDotColor = [UIColor colorWithHexString:@"#DEDEDE"];
//    self.pageControl.currentDotColor = [UIColor colorWithHexString:@"#65C2BE"];
//    self.pageControl.numberOfPages = 4;
//    [self.view addSubview:_pageControl];
}

//左上角的灰色跳过按钮
//-(void)createSkipBt
//{
//    UIButton *skipBt = [UIButton buttonWithType:UIButtonTypeCustom];
//    skipBt.backgroundColor = [UIColor colorWithHexString:@"#523B87"];
//    [skipBt setTitle:@"跳过" forState:UIControlStateNormal];
//    skipBt.titleLabel.font = kBoldFont(20);
//    [skipBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    skipBt.layer.cornerRadius = kWidth(21);
//    skipBt.clipsToBounds = YES;
//    skipBt.tag = 10;
//    [skipBt addTarget:self action:@selector(BtnDidClicked) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:skipBt];
//    skipBt.sd_layout.widthIs(kWidth(120)).heightIs(kWidth(42)).rightSpaceToView(self.view, kWidth(36)).bottomSpaceToView(self.view, kWidth(50)+kHeight_SafeArea);
//
//
//
//}
//手动拖拽结束时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    double page = scrollView.contentOffset.x / scrollView.width;
//    // 四舍五入计算出页码
//    int currentPage = (int)(page + 0.5);
//    DLog(@"当前页%d",currentPage);
//    if (currentPage == (NewfeatureCount-1)) {
//        self.pageControl.hidden = YES;
//    }else {
//        self.pageControl.hidden = NO;
//    }
//    self.pageControl.currentPage = currentPage;
    
    // 1.3四舍五入 1.3 + 0.5 = 1.8 强转为整数(int)1.8= 1
    // 1.5四舍五入 1.5 + 0.5 = 2.0 强转为整数(int)2.0= 2
    // 1.6四舍五入 1.6 + 0.5 = 2.1 强转为整数(int)2.1= 2
    // 0.7四舍五入 0.7 + 0.5 = 1.2 强转为整数(int)1.2= 1
}

//给最后一张图片添加 进入按钮
- (void)setupStartBtn:(UIImageView *)imgView
{
    imgView.userInteractionEnabled = YES;
    UIButton *skipBt = [UIButton buttonWithType:UIButtonTypeCustom];
    //skipBt.backgroundColor = [UIColor colorWithHexString:@"#523B87"];
    //[skipBt setTitle:@"跳过" forState:UIControlStateNormal];
    //skipBt.titleLabel.font = kBoldFont(20);
    //[skipBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   // skipBt.layer.cornerRadius = kWidth(21);
    //skipBt.clipsToBounds = YES;
    //[skipBt setBackgroundImage:kGetImage(@"引导页按钮") forState:UIControlStateNormal];
    skipBt.tag = 10;
    [skipBt addTarget:self action:@selector(BtnDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [imgView addSubview:skipBt];
    skipBt.sd_layout.widthIs(kScreenWidth).heightIs(kWidth(200)).centerXEqualToView(imgView).bottomSpaceToView(imgView, 0);

}

//进入按钮点击事件
- (void)BtnDidClicked {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([RegisterModel getUserInfoModel]) {//已登录
        [[EMClient sharedClient] loginWithUsername:[RegisterModel getUserInfoModel].uuid password:[RegisterModel getUserInfoModel].uuid_password completion:^(NSString *aUsername, EMError *aError) {
            if (!aError) {
             NSLog(@"环信登录成功");
                FJTabBarViewController *VC = [[FJTabBarViewController alloc] init];
                [window setRootViewController:VC];
            }
        }];
       
       
    }else {
        FirstViewController *rootVc = [[FirstViewController alloc]init];
        FJBaseNavigationController *loginNavi = [[FJBaseNavigationController alloc]initWithRootViewController:rootVc];
        [window setRootViewController:loginNavi];
    }
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
