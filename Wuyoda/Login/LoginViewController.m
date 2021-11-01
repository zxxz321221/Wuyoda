//
//  LoginViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/9.
//

#import "LoginViewController.h"
#import "AccountLoginViewController.h"
#import "CodeViewController.h"

@interface LoginViewController ()

@property (nonatomic , retain)UITextField *phoneField;
@property (nonatomic , retain)UIButton *agreementBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@""];
    [self.view addSubview:nav];
    
    UILabel *titleLab = [[UILabel  alloc]init];
    titleLab.text = @"手机动态密码登录";
    titleLab.textColor = [ColorManager BlackColor];
    titleLab.font = kFont(28);
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.equalTo(nav.mas_bottom).mas_offset(kWidth(35));
    }];
    
    UILabel *tipLab = [[UILabel alloc]init];
    tipLab.text = @"未注册的手机号验证后将自动创建新账号";
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
    [self.phoneField addTarget:self action:@selector(inputChanged:) forControlEvents:UIControlEventEditingChanged];
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
    
    UIButton *accountLoginBtn = [[UIButton alloc]init];
    [accountLoginBtn setTitle:@"使用账号密码登录" forState:UIControlStateNormal];
    [accountLoginBtn setTitleColor:[ColorManager MainColor] forState:UIControlStateNormal];
    accountLoginBtn.titleLabel.font = kFont(14);
    [accountLoginBtn addTarget:self action:@selector(accountLoginClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:accountLoginBtn];
    [accountLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.equalTo(sendCodeBtn.mas_bottom).mas_offset(kWidth(24));
        make.width.mas_offset(kWidth(115));
        make.height.mas_offset(kWidth(20));
    }];
    
    UILabel *otherLoginLab = [[UILabel alloc]init];
    otherLoginLab.text = @"使用其它方式登录";
    otherLoginLab.textColor = [ColorManager BlackColor];
    otherLoginLab.font = kFont(14);
    [self.view addSubview:otherLoginLab];
    [otherLoginLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.mas_offset(-kHeight_SafeArea-kWidth(180));
    }];
    
    UIButton *wxBtn = [[UIButton alloc]init];
    [wxBtn setImage:kGetImage(@"weixin") forState:UIControlStateNormal];
    [wxBtn addTarget:self action:@selector(wxLoginClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wxBtn];
    [wxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_centerX).mas_offset(kWidth(-16));
        make.top.equalTo(otherLoginLab.mas_bottom).mas_offset(kWidth(24));
        make.width.height.mas_offset(kWidth(47));
    }];
    
    UIButton *appleBtn = [[UIButton alloc]init];
    [appleBtn setImage:kGetImage(@"苹果登录") forState:UIControlStateNormal];
    [appleBtn addTarget:self action:@selector(appleLoginClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:appleBtn];
    [appleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_centerX).mas_offset(kWidth(16));
        make.top.equalTo(otherLoginLab.mas_bottom).mas_offset(kWidth(24));
        make.width.height.mas_offset(kWidth(47));
    }];
    
    self.agreementBtn = [[UIButton alloc]init];
    [self.agreementBtn setImage:kGetImage(@"登录页-未选中") forState:UIControlStateNormal];
    [self.agreementBtn setImage:kGetImage(@"登录页-选中") forState:UIControlStateSelected];
    [self.agreementBtn addTarget:self action:@selector(agreementClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.agreementBtn];
    [self.agreementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(47));
        make.top.equalTo(wxBtn.mas_bottom).mas_offset(kWidth(27));
        make.width.height.mas_offset(kWidth(14));
    }];
    
    //协议
    UILabel *agreementLabel = [[UILabel alloc] init];
    NSString * showText = @"注册/登录即代表您年满18岁，已认真阅读并同意接受wuyoda《服务条款》、《隐私政策》";
    agreementLabel.attributedText = [NSString getAttributeWith:@[@"《服务条款》",@"《隐私政策》"] string:showText orginFont:kFont(13) orginColor:[ColorManager Color7F7F7F] attributeFont:kBoldFont(13) attributeColor:[ColorManager MainColor]];
    [self.view addSubview:agreementLabel];
    agreementLabel.numberOfLines = 2;
    [agreementLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.agreementBtn.mas_right).mas_offset(kWidth(10));
        make.right.mas_offset(kWidth(-20));
        make.top.equalTo(wxBtn.mas_bottom).mas_offset(kWidth(24));
    }];
    
    [agreementLabel yb_addAttributeTapActionWithStrings:@[@"《服务条款》",@"《隐私政策》"] tapClicked:^(UILabel *label, NSString *string, NSRange range, NSInteger index) {

        NSLog(@"%@",string);

    }];
}

- (void)inputChanged:(UITextField *)textfield{
    if (textfield.text.length>11) {
        textfield.text = [textfield.text substringToIndex:11];
    }
}

-(void)sendCodeClicked:(UIButton *)sender{
    if (self.agreementBtn.isSelected) {
        CodeViewController *vc = [[CodeViewController alloc]init];
        vc.phone =self.phoneField.text;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self.view showHUDWithText:@"请同意用户协议" withYOffSet:0];
    }
    
}
-(void)accountLoginClicked:(UIButton *)sender{
    AccountLoginViewController *vc = [[AccountLoginViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)wxLoginClicked{
    
}
-(void)appleLoginClicked{
    
}

-(void)agreementClicked:(UIButton *)sender{
    sender.selected = !sender.isSelected;
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