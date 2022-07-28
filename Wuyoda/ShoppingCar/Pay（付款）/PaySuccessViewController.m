//
//  PaySuccessViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/28.
//

#import "PaySuccessViewController.h"
#import "OrderInfoViewController.h"

@interface PaySuccessViewController ()

@end

@implementation PaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@""];
    nav.backgroundColor = [ColorManager ColorF2F2F2];
    nav.isInitBackBtn = YES;
    nav.block = ^{
        [self.navigationController popToRootViewControllerAnimated:YES];
    };
    [self.view addSubview:nav];
    
    self.view.backgroundColor = [ColorManager ColorF2F2F2];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar+kWidth(20), kScreenWidth, kScreenHeight-kHeight_NavBar-kWidth(20))];
    bgView.backgroundColor = [ColorManager WhiteColor];
    [self.view addSubview:bgView];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(kWidth(10), kWidth(10))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame =  bgView.bounds;
    maskLayer.path = maskPath.CGPath;
    bgView.layer.mask = maskLayer;
    
    UIImageView *imgV = [[UIImageView alloc]initWithImage:kGetImage(@"选中")];
    [bgView addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(115));
        make.top.mas_offset(kWidth(32));
        make.width.height.mas_offset(kWidth(24));
    }];
    
    UILabel *successLab = [[UILabel alloc]init];
    successLab.text = @"支付成功";
    successLab.textColor = [ColorManager BlackColor];
    successLab.font = kBoldFont(28);
    [bgView addSubview:successLab];
    [successLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgV.mas_right).mas_offset(kWidth(8));
        make.centerY.equalTo(imgV);
    }];
    
    UIButton *backBtn = [[UIButton alloc]init];
    [backBtn setTitle:@"返回首页" forState:UIControlStateNormal];
    [backBtn setTitleColor:[ColorManager Color666666] forState:UIControlStateNormal];
    backBtn.titleLabel.font = kFont(12);
    backBtn.layer.cornerRadius = kWidth(15);
    backBtn.layer.borderColor = [ColorManager Color666666].CGColor;
    backBtn.layer.borderWidth = kWidth(1);
    [backBtn addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(64));
        make.top.equalTo(imgV.mas_bottom).mas_offset(kWidth(36));
        make.width.mas_offset(kWidth(100));
        make.height.mas_offset(kWidth(30));
    }];
    
    UIButton *orderBtn = [[UIButton alloc]init];
    [orderBtn setTitle:@"查看订单" forState:UIControlStateNormal];
    [orderBtn setTitleColor:[ColorManager Color666666] forState:UIControlStateNormal];
    orderBtn.titleLabel.font = kFont(12);
    orderBtn.layer.cornerRadius = kWidth(15);
    orderBtn.layer.borderColor = [ColorManager Color666666].CGColor;
    orderBtn.layer.borderWidth = kWidth(1);
    [orderBtn addTarget:self action:@selector(orderClicked) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:orderBtn];
    [orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-64));
        make.top.equalTo(imgV.mas_bottom).mas_offset(kWidth(36));
        make.width.mas_offset(kWidth(100));
        make.height.mas_offset(kWidth(30));
    }];
    if ([self.type isEqualToString:@"2"]) {
        successLab.text = @"收货成功";
        [orderBtn setTitle:@"立即评价" forState:UIControlStateNormal];
    }else if ([self.type isEqualToString:@"3"]){
        successLab.text = @"评价成功";
        backBtn.hidden = YES;
        orderBtn.hidden = YES;
    }
}

-(void)backClicked{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)orderClicked{
    if ([self.type isEqualToString: @"1"]) {
        OrderInfoViewController *vc = [[OrderInfoViewController alloc]init];
        vc.type = @"3";
        vc.ordersn = self.ordersn;
        [self.navigationController pushViewController:vc animated:YES];
    }
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
