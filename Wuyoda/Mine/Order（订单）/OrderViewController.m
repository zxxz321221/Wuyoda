//
//  OrderViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/11.
//

#import "OrderViewController.h"
#import "AllOrderListViewController.h"
#import "WillPayOrderViewController.h"
#import "WillTakeOrderViewController.h"
#import "FinishOrderViewController.h"
#import "WillEvaluateOrderViewController.h"


@interface OrderViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)NSMutableArray *controllers;

@property (nonatomic,strong)UIView *headerV;
@property (nonatomic,strong)NSArray *headerTitleArr;
@property (nonatomic,strong)UIView *headerLine;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"订单"];
    [self.view addSubview:nav];
    
    self.headerTitleArr = [[NSArray alloc]initWithObjects:@"全部订单",@"待付款",@"待收货",@"已完成", nil];
    
    [self loadUI];
    [self loadControllers];
    
    UIViewController *willShowVC = self.controllers[0];
    NSInteger tag = 0;
    // 添加控制器的 view 到 contentScrollerView 中
    willShowVC.view.frame = CGRectMake(tag*kScreenWidth, 0, kScreenWidth, kScreenHeight - kHeight_NavBar - kWidth(50));
    [self.scrollView addSubview:willShowVC.view];

  [self.scrollView setContentOffset:CGPointMake(tag*kScreenWidth, 0) animated:NO ];
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger tag = scrollView.contentOffset.x / kScreenWidth;
    
    for (int i = 0; i < self.headerTitleArr.count; i++) {
        UIButton *btn = [self.view viewWithTag:i+1000];
        btn.selected = NO;
        if (i == tag) {
            btn.selected = YES;
            self.headerLine.frame = CGRectMake(btn.center.x-kWidth(20), kWidth(36), kWidth(40), kWidth(4));
        }
    }
    
    //self.headView.smileCerX.constant = tag * 100;

    // 取出需要显示的控制器
      UIViewController *willShowVC = self.controllers[tag];
      // 如果当前位置的已经显示过了, 就直接返回
          if ([willShowVC isViewLoaded]) {
              return;
          }
      // 添加控制器的 view 到 contentScrollerView 中
      willShowVC.view.frame = CGRectMake(tag*kScreenWidth, 0, kScreenWidth, kScreenHeight - kHeight_NavBar - kWidth(50));
      [self.scrollView addSubview:willShowVC.view];

    [self.scrollView setContentOffset:CGPointMake(tag*kScreenWidth, 0) animated:NO ];
}

-(void)loadUI {
    
    self.headerV = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kWidth(50))];
    [self.view addSubview:self.headerV];
    for (int i = 0; i<4; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/4*i, 0, kScreenWidth/4, kWidth(40))];
        [btn setTitle:self.headerTitleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[ColorManager Color777777] forState:UIControlStateNormal];
        [btn setTitleColor:[ColorManager MainColor] forState:UIControlStateSelected];
        btn.titleLabel.font = kFont(14);
        btn.tag = 1000+i;
        [btn addTarget:self action:@selector(changeViewClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.headerV addSubview:btn];
        
    }
    self.headerLine = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/8-kWidth(20), kWidth(36), kWidth(40), kWidth(4))];
    self.headerLine.backgroundColor = [ColorManager MainColor];
    [self.headerV addSubview:self.headerLine];
    
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kHeight_NavBar+kWidth(50), kScreenWidth, kScreenHeight - kHeight_NavBar - kWidth(50))];
    [self.view addSubview:self.scrollView];
    [self.scrollView setContentSize:CGSizeMake(kScreenWidth * 4, 0)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled=YES;
    self.scrollView.bounces=NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    //self.headView = [[AdvancedHeadView alloc] initWithFrame:CGRectMake(0, kHeight_StatusBar, kScreenWidth, kWidth(64))];
    //[self.view addSubview:self.headView];
}

-(void)changeViewClicked:(UIButton *)sender{
    
    for (int i = 0; i < self.headerTitleArr.count; i++) {
        UIButton *btn = [self.view viewWithTag:i+1000];
        btn.selected = NO;
    }
    
    sender.selected = YES;
    self.headerLine.frame = CGRectMake(sender.center.x-kWidth(20), kWidth(36), kWidth(40), kWidth(4));
    [self.scrollView setContentOffset:CGPointMake((sender.tag-1000)*kScreenWidth, 0) animated:YES];
    // 取出需要显示的控制器
      UIViewController *willShowVC = self.controllers[sender.tag-1000];
      // 如果当前位置的已经显示过了, 就直接返回
          if ([willShowVC isViewLoaded]) {
              return;
          }
      // 添加控制器的 view 到 contentScrollerView 中
      willShowVC.view.frame = CGRectMake((sender.tag-1000)*kScreenWidth, 0, kScreenWidth, kScreenHeight - kHeight_NavBar - kWidth(50));
      [self.scrollView addSubview:willShowVC.view];
}

-(void)loadControllers {
    AllOrderListViewController *allOrderVC = [[AllOrderListViewController alloc] init];
    [self addChildViewController:allOrderVC];
    [allOrderVC didMoveToParentViewController:self];
    [self.controllers addObject:allOrderVC];
    
    WillPayOrderViewController *willPayVC = [[WillPayOrderViewController alloc] init];
    [self addChildViewController:willPayVC];
    [willPayVC didMoveToParentViewController:self];
    [self.controllers addObject:willPayVC];

    
    WillTakeOrderViewController *willTakeVC = [[WillTakeOrderViewController alloc] init];
    [self addChildViewController:willTakeVC];
    [willTakeVC didMoveToParentViewController:self];
    [self.controllers addObject:willTakeVC];

    FinishOrderViewController *finishOrderVC = [[FinishOrderViewController alloc] init];
    [self addChildViewController:finishOrderVC];
    [finishOrderVC didMoveToParentViewController:self];
    [self.controllers addObject:finishOrderVC];
    
//    WillEvaluateOrderViewController *willEvaluateVC = [[WillEvaluateOrderViewController alloc] init];
//    [self addChildViewController:willEvaluateVC];
//    [willEvaluateVC didMoveToParentViewController:self];
//    [self.controllers addObject:willEvaluateVC];

    
}
-(NSMutableArray *)controllers {
    if (!_controllers) {
        _controllers = [NSMutableArray array];
    }
    return _controllers;
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
