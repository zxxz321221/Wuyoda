//
//  SecurityPhoneViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/9.
//

#import "SecurityPhoneViewController.h"
#import "ChangePhoneViewController.h"
#import "ChangeEmailViewController.h"

@interface SecurityPhoneViewController ()

@property (nonatomic , retain)UILabel *phoneLab;
@property (nonatomic , retain)UILabel *titleLab;

@end

@implementation SecurityPhoneViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UserInfoModel *userInfo = [UserInfoModel getUserInfoModel];
    if (![self.type isEqualToString:@"2"]) {
        if (userInfo.member_tel2.length) {
            NSString *phoneStr = userInfo.member_tel2;
            phoneStr = [phoneStr stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            self.phoneLab.text = phoneStr;
        }
    }else{
        if (userInfo.member_email.length) {
            self.titleLab.text = @"当前绑定邮箱";
            self.phoneLab.text =userInfo.member_email;
        }else{
            self.titleLab.text = @"当前未绑定邮箱";
            self.phoneLab.text = @"";
        }
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"手机号"];
    nav.backgroundColor = [ColorManager ColorF2F2F2];
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
    
    UserInfoModel *userInfo = [UserInfoModel getUserInfoModel];
    
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"当前绑定手机号";
    titleLab.textColor = [ColorManager Color333333];
    titleLab.font = kFont(14);
    self.titleLab = titleLab;
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(bgView).mas_offset(kWidth(40));
    }];
    
    UILabel *phoneLab = [[UILabel alloc]init];
    NSString *phoneStr = userInfo.member_tel2;
    if (userInfo.member_tel2.length) {
        phoneStr = [phoneStr stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }
    phoneLab.text = phoneStr;
    phoneLab.textColor = [ColorManager Color333333];
    phoneLab.font = kBoldFont(20);
    self.phoneLab = phoneLab;
    [self.view addSubview:phoneLab];
    [phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(titleLab.mas_bottom).mas_offset(kWidth(18));
    }];
    
    UIButton *changeBtn = [[UIButton alloc]init];
    [changeBtn setTitle:@"修改手机号" forState:UIControlStateNormal];
    [changeBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    changeBtn.titleLabel.font = kFont(14);
    [changeBtn setBackgroundImage:kGetImage(@"login_按钮") forState:UIControlStateNormal];
    changeBtn.layer.cornerRadius = kWidth(24);
    [changeBtn addTarget:self action:@selector(changePhoneClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeBtn];
    [changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(phoneLab.mas_bottom).mas_offset(kWidth(50));
        make.width.mas_offset(kWidth(321));
        make.height.mas_offset(kWidth(48));
    }];
    
    UIButton *backBtn = [[UIButton alloc]init];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
    backBtn.titleLabel.font = kFont(14);
    backBtn.backgroundColor = [ColorManager ColorD7D7D7];
    backBtn.layer.cornerRadius = kWidth(24);
    [backBtn addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(changeBtn.mas_bottom).mas_offset(kWidth(10));
        make.width.mas_offset(kWidth(321));
        make.height.mas_offset(kWidth(48));
    }];
    
    if ([self.type isEqualToString:@"2"]) {
        [nav changeTitle:@"邮箱"];
        if (userInfo.member_email.length) {
            titleLab.text = @"当前绑定邮箱";
            phoneLab.text =userInfo.member_email;
        }else{
            titleLab.text = @"当前未绑定邮箱";
            phoneLab.text = @"";
        }
        
        [changeBtn setTitle:@"修改邮箱" forState:UIControlStateNormal];
    }
}

-(void)changePhoneClicked{
    if ([self.type isEqualToString:@"1"]) {
        ChangePhoneViewController *vc = [[ChangePhoneViewController alloc]init];
        vc.type = @"1";
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        ChangeEmailViewController *vc = [[ChangeEmailViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

-(void)backClicked{
    [self.navigationController popViewControllerAnimated:YES];
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
