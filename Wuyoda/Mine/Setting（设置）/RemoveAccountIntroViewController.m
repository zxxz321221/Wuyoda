//
//  RemoveAccountIntroViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2022/3/8.
//

#import "RemoveAccountIntroViewController.h"
#import "LogoffDoneView.h"
#import "RemoveAccountCodeViewController.h"

@interface RemoveAccountIntroViewController ()

@property (nonatomic , retain)UIScrollView *scrollV;

@property (nonatomic , retain)UILabel *introLab;

@property (nonatomic , retain)UIButton *agreenBtn;

@property (nonatomic , retain)LogoffDoneView *logoffDoneV;

@end

@implementation RemoveAccountIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"账号注销"];
    [self.view addSubview:nav];
    
    self.scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(kWidth(10), kHeight_NavBar+kWidth(15), kScreenWidth-kWidth(20), kScreenHeight-kHeight_SafeArea-kHeight_NavBar-kWidth(100))];
    self.scrollV.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollV];
    
    self.introLab = [[UILabel alloc]init];
    self.introLab.font = [UIFont systemFontOfSize:14];
    self.introLab.textColor = [UIColor blackColor];
    self.introLab.numberOfLines = 0;
    self.introLab.lineBreakMode = NSLineBreakByCharWrapping;
    self.introLab.attributedText = [self getLogoffInfo];
    [self.scrollV addSubview:self.introLab];
    [self.introLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(0);
        make.width.mas_offset(kScreenWidth-kWidth(20));
    }];
    [self.introLab layoutIfNeeded];
    self.scrollV.contentSize = CGSizeMake(0, self.introLab.bounds.size.height);
    
    self.agreenBtn = [[UIButton alloc]init];
    [self.agreenBtn setTitle:@"同意并注销" forState:UIControlStateNormal];
    [self.agreenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.agreenBtn.layer.cornerRadius = kWidth(25);
    self.agreenBtn.backgroundColor = [ColorManager MainColor];
    [self.agreenBtn addTarget:self action:@selector(agreenClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.agreenBtn];
    [self.agreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.mas_offset(-kHeight_SafeArea);
        make.width.mas_offset(kScreenWidth-kWidth(30));
        make.height.mas_offset(kWidth(50));
    }];
}

-(void)agreenClicked:(UIButton *)sender{
    
    self.logoffDoneV = [[LogoffDoneView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.logoffDoneV.doneBtn addTarget:self action:@selector(logoffDoneClicekd:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.view addSubview:self.logoffDoneV];
    
}

-(void)logoffDoneClicekd:(UIButton *)sender{
    sender.enabled = NO;
//    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
//
//    [GZMrequest postWithURLString:[GZMUrl get_accountCancel_url] parameters:@{@"customer":[userInfo valueForKey:@"member_id"]} success:^(NSDictionary *data) {
//        sender.enabled = YES;
//        if ([data[@"code"] isEqualToString:@"success"]) {
//            [self.logoffDoneV removeFromSuperview];
//            LongoffCodeViewController *vc = [[LongoffCodeViewController alloc]init];
//            vc.phone = data[@"msg"];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//
//
//    } failure:^(NSError *error) {
//        sender.enabled = YES;
//    }];
    [self.logoffDoneV removeFromSuperview];
    RemoveAccountCodeViewController *vc = [[RemoveAccountCodeViewController alloc]init];
    vc.reason = self.reason;
    vc.phone = @"18640820718";
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSMutableAttributedString *)getLogoffInfo{
    
    NSString *infoStr = @"捎东西平台用户注销规则\n\n捎东西CNApp提醒您，账户一旦注销，您在平台所有的权益（包括但并不限于回馈金、账户冻结金额等）都一并失效，如果您执意放弃账户，需同时满足以下条件：\n1. 您的帐户在捎东西CNApp上没有未完结的订单(完结订单：已收货、已取消、已关闭的订单），并且您购买的完结订单都超过90天。（因为可能存在退运、物流延迟的特殊情况，为了保护您的权益，须在订单完结90天以后方可申请账户注销）\n2. 您的账户在捎东西CNApp上没有现金未提取（包括但不限于账户保证金，账户余额等）。\n3. 您的账户没有未解决的纠纷记录，纠纷记录包括但不限于投诉举报。\n\n温馨提示\n\n1. 在捎东西CNApp账户不满足以上任意一项或多项条件的账户将无法注销，请等待上述情况消失的时候再提交账户注销申请。\n2. 符合注销条件，将会在一个工作日完成账号注销，后续有任何问题可随时联系在线客服咨询。";
    
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:infoStr];
    [attStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[infoStr rangeOfString:@"捎东西平台用户注销规则"]];
    [attStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[infoStr rangeOfString:@"温馨提示"]];
    
    return attStr;
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
