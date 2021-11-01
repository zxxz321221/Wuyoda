//
//  ForgetPasswordViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/10.
//

#import "ForgetPasswordViewController.h"

@interface ForgetPasswordViewController ()

@property (nonatomic , retain)UITextField *phoneField;

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@""];
    [self.view addSubview:nav];
    
    UILabel *titleLab = [[UILabel  alloc]init];
    titleLab.text = @"忘记密码？";
    titleLab.textColor = [ColorManager BlackColor];
    titleLab.font = kFont(28);
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.equalTo(nav.mas_bottom).mas_offset(kWidth(35));
    }];
    
    UILabel *tipLab = [[UILabel alloc]init];
    tipLab.text = @"请输入手机号码以获取登录帮助";
    tipLab.textColor = [ColorManager Color7F7F7F];
    tipLab.font = kFont(16);
    [self.view addSubview:tipLab];
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.equalTo(titleLab.mas_bottom).mas_offset(kWidth(8));
    }];
    
    UILabel *phoneLab = [[UILabel alloc]init];
    phoneLab.text = @"手机号码";
    phoneLab.textColor = [ColorManager BlackColor];
    phoneLab.font = kFont(14);
    [self.view addSubview:phoneLab];
    [phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.equalTo(tipLab.mas_bottom).mas_offset(kWidth(90));
    }];
    
    UILabel *phoneTypeLab = [[UILabel alloc]init];
    phoneTypeLab.text = @"+86";
    phoneTypeLab.textColor = [ColorManager BlackColor];
    phoneTypeLab.textAlignment = NSTextAlignmentCenter;
    phoneTypeLab.font = kFont(14);
    phoneTypeLab.layer.borderColor = [UIColor colorWithRed:119.0/255 green:119.0/255 blue:119.0/255 alpha:0.34].CGColor;
    phoneTypeLab.layer.borderWidth = 0.5;
    [self.view addSubview:phoneTypeLab];
    [phoneTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.equalTo(phoneLab.mas_bottom).mas_offset(kWidth(18));
        make.width.mas_offset(kWidth(48));
        make.height.mas_offset(kWidth(32));
    }];
    
    self.phoneField = [[UITextField alloc]init];
    self.phoneField.textColor = [ColorManager BlackColor];
    self.phoneField.font = kFont(14);
    self.phoneField.placeholder = @"请输入手机号码";
    [self.view addSubview:self.phoneField];
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneTypeLab.mas_right).mas_offset(kWidth(8));
        make.centerY.height.equalTo(phoneTypeLab);
        make.right.mas_offset(kWidth(-20));
    }];
    
    UIView *lineV = [[UIView alloc]init];
    lineV.backgroundColor = [ColorManager ColorF7F7F7];
    [self.view addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneTypeLab.mas_bottom).mas_offset(kWidth(5));
        make.left.mas_offset(kWidth(20));
        make.right.mas_offset(kWidth(-20));
        make.height.mas_offset(kWidth(1));
    }];
    
    UIButton *sendCodeBtn = [[UIButton alloc]init];
    [sendCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [sendCodeBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    sendCodeBtn.titleLabel.font = kFont(14);
    sendCodeBtn.backgroundColor = [ColorManager MainColor];
    sendCodeBtn.layer.cornerRadius = kWidth(5);
    [sendCodeBtn addTarget:self action:@selector(sendCodeClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendCodeBtn];
    [sendCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineV.mas_bottom).mas_offset(kWidth(24));
        make.left.mas_offset(kWidth(20));
        make.right.mas_offset(kWidth(-20));
        make.height.mas_offset(kWidth(42));
    }];
}


-(void)sendCodeClicked:(UIButton *)sender{
    
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
