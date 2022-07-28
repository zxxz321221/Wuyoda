//
//  RegisterViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2022/5/19.
//

#import "RegisterViewController.h"
#import <AuthenticationServices/AuthenticationServices.h>
#import "ChangePhoneViewController.h"
#import "ChangePassWordViewController.h"
#import "AgreementAlertView.h"
#import "LoginNavigationView.h"
#import "NewLoginViewController.h"
#import "GraphCodeView.h"//图形验证码
#import "NSString+random.h"

@interface RegisterViewController ()<ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding,GraphCodeViewDelegate>

@property (nonatomic , retain)UIButton *phoneBtn;
@property (nonatomic , retain)UIButton *emailBtn;

@property (nonatomic , retain)UIImageView *imgV1;
@property (nonatomic , retain)UIImageView *imgV2;
@property (nonatomic , retain)UIImageView *imgV3;

@property (nonatomic , retain)UIButton *codeBtn;

@property (nonatomic , retain)UITextField *phoneTextF;
@property (nonatomic , retain)UITextField *codeTextF;

@property (nonatomic , retain)UITextField *emailTextF;
@property (nonatomic , retain)UITextField *passwordTextF;
@property (nonatomic , retain)UIButton *disAppearBtn;
@property (nonatomic , retain)UITextField *accountCodeTextF;
@property (nonatomic , retain)GraphCodeView *accountCodeImgV;
@property (nonatomic , copy)NSString *imgCodeStr;
@property (nonatomic , retain)UIView *line2;
@property (nonatomic , retain)UIView *line3;

@property (nonatomic , retain)UIButton *loginBtn;

@property (nonatomic , copy)NSString *loginType;

@property (nonatomic , retain)UIButton *agreementBtn;

@property (nonatomic , retain)AgreementAlertView *agreementAlertV;
@property (nonatomic , copy)NSString *agreemType;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *topBGV = [[UIView alloc]initWithFrame:CGRectMake(-kScreenWidth/10, 0, kScreenWidth*1.2, kWidth(210))];
    topBGV.backgroundColor = [ColorManager ColorFA8B18];
    [self.view addSubview:topBGV];
    UIBezierPath *maskPath0 = [UIBezierPath bezierPathWithRoundedRect:topBGV.bounds byRoundingCorners:UIRectCornerBottomRight | UIRectCornerBottomLeft cornerRadii:CGSizeMake(kScreenWidth/2, kScreenWidth/2)];
    CAShapeLayer *maskLayer0 = [[CAShapeLayer alloc] init];
    maskLayer0.frame =  topBGV.bounds;
    maskLayer0.path = maskPath0.CGPath;
    topBGV.layer.mask = maskLayer0;
    
    LoginNavigationView *nav = [[LoginNavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar)];
    nav.backgroundColor = [ColorManager ColorFA8B18];
    nav.titleLab.text = @"注册";
//    if ([self.type isEqualToString:@"login"]) {
//        nav.backBtn.hidden = YES;
//    }else{
//        nav.backBtn.hidden = YES;
//    }
    [self.view addSubview:nav];
    
    self.loginType = @"phone";
    self.imgCodeStr = [NSString randomStringWithLength:4];
    
    
    UIView *loginBGV = [[UIView alloc]initWithFrame:CGRectMake(kWidth(20), kHeight_NavBar+kWidth(75), kWidth(336), kWidth(354))];
    if (!kHeight_SafeArea) {
        loginBGV.frame = CGRectMake(kWidth(20), kHeight_NavBar+kWidth(30), kWidth(336), kWidth(354));
    }
    loginBGV.backgroundColor = [ColorManager WhiteColor];
    loginBGV.layer.cornerRadius = kWidth(20);
    //定义view的阴影颜色
    loginBGV.layer.shadowColor = [ColorManager BlackColor].CGColor;
    //阴影偏移量
    loginBGV.layer.shadowOffset = CGSizeMake(0, 4);
    //定义view的阴影宽度，模糊计算的半径
    loginBGV.layer.shadowRadius = 6;
    //定义view的阴影透明度，注意:如果view没有设置背景色阴影也是不会显示的
    loginBGV.layer.shadowOpacity = 0.15;
    [self.view addSubview:loginBGV];

    
    
    self.phoneBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kWidth(168), kWidth(40))];
    [self.phoneBtn setTitle:@"手机注册" forState:UIControlStateNormal];
    [self.phoneBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
    self.phoneBtn.titleLabel.font = kFont(14);
    self.phoneBtn.backgroundColor = [ColorManager WhiteColor];
    [self.phoneBtn addTarget:self action:@selector(changeLoginTypeClicked:) forControlEvents:UIControlEventTouchUpInside];
    [loginBGV addSubview:self.phoneBtn];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.phoneBtn.bounds byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(kWidth(15), kWidth(15))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame =  self.phoneBtn.bounds;
    maskLayer.path = maskPath.CGPath;
    self.phoneBtn.layer.mask = maskLayer;
    
    self.emailBtn = [[UIButton alloc]initWithFrame:CGRectMake(kWidth(168), 0, kWidth(168), kWidth(40))];
    [self.emailBtn setTitle:@"邮箱注册" forState:UIControlStateNormal];
    [self.emailBtn setTitleColor:[ColorManager Color7F7F7F] forState:UIControlStateNormal];
    self.emailBtn.titleLabel.font = kFont(14);
    self.emailBtn.backgroundColor = [ColorManager ColorF2F2F2];
    [self.emailBtn addTarget:self action:@selector(changeLoginTypeClicked:) forControlEvents:UIControlEventTouchUpInside];
    [loginBGV addSubview:self.emailBtn];
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:self.emailBtn.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomLeft cornerRadii:CGSizeMake(kWidth(15), kWidth(15))];
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame =  self.emailBtn.bounds;
    maskLayer1.path = maskPath1.CGPath;
    self.emailBtn.layer.mask = maskLayer1;
    
    self.imgV1 = [[UIImageView alloc]initWithImage:kGetImage(@"login_手机")];
    self.imgV1.contentMode = UIViewContentModeScaleAspectFit;
    [loginBGV addSubview:self.imgV1];
    [self.imgV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.mas_offset(70);
        make.width.height.mas_offset(kWidth(20));
    }];
    
    self.phoneTextF = [[UITextField alloc]init];
    self.phoneTextF.placeholder = @"请输入手机号码";
    self.phoneTextF.textColor = [ColorManager Color333333];
    self.phoneTextF.font = kFont(14);
    [self.phoneTextF addTarget:self action:@selector(inputChanged:) forControlEvents:UIControlEventEditingChanged];
    [loginBGV addSubview:self.phoneTextF];
    [self.phoneTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgV1.mas_right).mas_offset(kWidth(20));
        make.centerY.equalTo(self.imgV1);
        make.right.mas_offset(kWidth(-20));
        make.height.mas_offset(kWidth(35));
    }];
    
    self.emailTextF = [[UITextField alloc]init];
    self.emailTextF.placeholder = @"请输入电子邮箱";
    self.emailTextF.textColor = [ColorManager Color333333];
    self.emailTextF.font = kFont(14);
    self.emailTextF.hidden = YES;
    [loginBGV addSubview:self.emailTextF];
    [self.emailTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgV1.mas_right).mas_offset(kWidth(20));
        make.centerY.equalTo(self.imgV1);
        make.right.mas_offset(kWidth(-20));
        make.height.mas_offset(kWidth(35));
    }];
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = [ColorManager ColorF2F2F2];
    [loginBGV addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.right.mas_offset(kWidth(-20));
        make.top.equalTo(self.imgV1.mas_bottom).mas_offset(kWidth(20));
        make.height.mas_offset(kWidth(0.5));
    }];
    
    
    self.imgV2 = [[UIImageView alloc]initWithImage:kGetImage(@"login_验证码")];
    self.imgV2.contentMode = UIViewContentModeScaleAspectFit;
    [loginBGV addSubview:self.imgV2];
    [self.imgV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.equalTo(self.imgV1.mas_bottom).mas_offset(50);
        make.width.height.mas_offset(kWidth(20));
    }];
    
    self.codeTextF = [[UITextField alloc]init];
    self.codeTextF.placeholder = @"请输入验证码";
    self.codeTextF.textColor = [ColorManager Color333333];
    self.codeTextF.font = kFont(14);
    [loginBGV addSubview:self.codeTextF];
    [self.codeTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgV2.mas_right).mas_offset(kWidth(20));
        make.centerY.equalTo(self.imgV2);
        make.right.mas_offset(kWidth(-150));
        make.height.mas_offset(kWidth(35));
    }];
    
    self.codeBtn = [[UIButton alloc]init];
    [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.codeBtn setTitleColor:[ColorManager ColorFA8B18] forState:UIControlStateNormal];
    self.codeBtn.titleLabel.font = kFont(12);
    self.codeBtn.backgroundColor = [ColorManager ColorF2F2F2];
    self.codeBtn.layer.cornerRadius = kWidth(12);
    [self.codeBtn addTarget:self action:@selector(sendCodeClicked:) forControlEvents:UIControlEventTouchUpInside];
    [loginBGV addSubview:self.codeBtn];
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imgV2);
        make.right.mas_offset(kWidth(-20));
        make.width.mas_offset(kWidth(85));
        make.height.mas_offset(kWidth(24));
    }];
    
    self.passwordTextF = [[UITextField alloc]init];
    self.passwordTextF.placeholder = @"6-20位数字或字母";
    self.passwordTextF.textColor = [ColorManager Color333333];
    self.passwordTextF.font = kFont(14);
    self.passwordTextF.secureTextEntry = YES;
    self.passwordTextF.hidden = YES;
    [loginBGV addSubview:self.passwordTextF];
    [self.passwordTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgV2.mas_right).mas_offset(kWidth(20));
        make.centerY.equalTo(self.imgV2);
        make.right.mas_offset(kWidth(-45));
        make.height.mas_offset(kWidth(35));
    }];
    
    self.disAppearBtn = [[UIButton alloc]init];
    [self.disAppearBtn setImage:kGetImage(@"不可见") forState:UIControlStateNormal];
    [self.disAppearBtn setImage:kGetImage(@"可见") forState:UIControlStateSelected];
    [self.disAppearBtn addTarget:self action:@selector(disAppearPasswordClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.disAppearBtn.hidden = YES;
    [loginBGV addSubview:self.disAppearBtn];
    [self.disAppearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.passwordTextF);
        make.right.mas_offset(kWidth(-25));
        make.width.height.mas_offset(kWidth(15));
    }];
    
    self.line2 = [[UIView alloc]init];
    self.line2.backgroundColor = [ColorManager ColorF2F2F2];
    [loginBGV addSubview:self.line2];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.right.mas_offset(kWidth(-20));
        make.top.equalTo(self.imgV2.mas_bottom).mas_offset(kWidth(20));
        make.height.mas_offset(kWidth(0.5));
    }];
    
    self.imgV3 = [[UIImageView alloc]initWithImage:kGetImage(@"login_验证码")];
    self.imgV3.contentMode = UIViewContentModeScaleAspectFit;
    self.imgV3.hidden = YES;
    [loginBGV addSubview:self.imgV3];
    [self.imgV3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.equalTo(self.imgV2.mas_bottom).mas_offset(50);
        make.width.height.mas_offset(kWidth(20));
    }];
    
    self.accountCodeTextF = [[UITextField alloc]init];
    self.accountCodeTextF.placeholder = @"请输入验证码";
    self.accountCodeTextF.textColor = [ColorManager Color333333];
    self.accountCodeTextF.font = kFont(14);
    self.accountCodeTextF.hidden = YES;
    [loginBGV addSubview:self.accountCodeTextF];
    [self.accountCodeTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgV3.mas_right).mas_offset(kWidth(20));
        make.centerY.equalTo(self.imgV3);
        make.right.mas_offset(kWidth(-20));
        make.height.mas_offset(kWidth(35));
    }];
    
    self.accountCodeImgV = [[GraphCodeView alloc]initWithFrame:CGRectMake(kWidth(100), kWidth(200), kWidth(80), kWidth(30))];
    //self.accountCodeImgV.backgroundColor = [ColorManager BlackColor];
    self.accountCodeImgV.hidden = YES;
    [loginBGV addSubview:self.accountCodeImgV];
    [self.accountCodeImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imgV3);
        make.right.mas_offset(kWidth(-20));
        make.height.mas_offset(kWidth(30));
        make.width.mas_offset(kWidth(80));
    }];
    [self.accountCodeImgV setCodeStr:self.imgCodeStr];
    self.accountCodeImgV.delegate = self;
    
    self.line3 = [[UIView alloc]init];
    self.line3.backgroundColor = [ColorManager ColorF2F2F2];
    self.line3.hidden = YES;
    [loginBGV addSubview:self.line3];
    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.right.mas_offset(kWidth(-20));
        make.top.equalTo(self.imgV3.mas_bottom).mas_offset(kWidth(20));
        make.height.mas_offset(kWidth(0.5));
    }];
    
    self.loginBtn = [[UIButton alloc]init];
    [self.loginBtn setTitle:@"已有账号，登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[ColorManager MainColor] forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = kFont(14);
    [self.loginBtn addTarget:self action:@selector(loginClicked) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [loginBGV addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line2);
        make.top.equalTo(self.line3.mas_bottom).mas_offset(kWidth(0));
        make.width.mas_offset(kWidth(150));
        make.height.mas_offset(kWidth(40));
    }];
    
    UIButton *registerBtn = [[UIButton alloc]init];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    registerBtn.titleLabel.font = kFont(14);
    [registerBtn setBackgroundImage:kGetImage(@"login_按钮") forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerCkicked:) forControlEvents:UIControlEventTouchUpInside];
    [loginBGV addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(loginBGV);
        make.bottom.mas_offset(kWidth(-20));
        make.width.mas_offset(kWidth(295));
        make.height.mas_offset(kWidth(40));
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
    
    if (![WXApi isWXAppInstalled]) {
        wxBtn.hidden = YES;
        
        [appleBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(otherLoginLab.mas_bottom).mas_offset(kWidth(24));
            make.width.height.mas_offset(kWidth(47));
        }];
    }
    
    self.agreementBtn = [[UIButton alloc]init];
    [self.agreementBtn setImage:kGetImage(@"未选中") forState:UIControlStateNormal];
    [self.agreementBtn setImage:kGetImage(@"选中") forState:UIControlStateSelected];
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkWeiXinAccount:) name:@"weixinLoginSuccess" object:nil];
    
    NSInteger appleStatus = [[[NSUserDefaults standardUserDefaults] objectForKey:@"appleLogin"] integerValue];
    if (appleStatus == 1) {
        appleBtn.hidden = NO;
    }else{
        appleBtn.hidden = YES;
        [wxBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(otherLoginLab.mas_bottom).mas_offset(kWidth(24));
            make.width.height.mas_offset(kWidth(47));
        }];
    }
    
    if (appleBtn.isHidden && wxBtn.isHidden) {
        otherLoginLab.hidden = YES;
    }else{
        otherLoginLab.hidden = NO;
    }
    
}

-(void)disAppearPasswordClicked:(UIButton *)sender{
    sender.selected = !sender.isSelected;
    self.passwordTextF.secureTextEntry = !sender.isSelected;
    
}

-(void)didTapGraphCodeView:(GraphCodeView *)graphCodeView{
    self.imgCodeStr =[NSString randomStringWithLength:4];
    NSLog(@"imgCode:%@",self.imgCodeStr);
    [self.accountCodeImgV setCodeStr:self.imgCodeStr];
    [self.accountCodeImgV setNeedsDisplay];
}

//-(void)getAccountCodeFromServer{
//
//    NSDictionary *dic = [KeyChain load:KEY_USERNAME_PASSWORD];
//    NSLog(@"%@",[dic objectForKey:KEY_PASSWORD]);
//}

- (void)inputChanged:(UITextField *)textfield{
    if (textfield.text.length>11) {
        textfield.text = [textfield.text substringToIndex:11];
    }
}

-(void)loginClicked{
    if ([self.type isEqualToString:@"login"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        NewLoginViewController *vc = [[NewLoginViewController alloc]init];
        vc.type = @"register";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)changeLoginTypeClicked:(UIButton *)sender{
    if (sender == self.phoneBtn) {
        self.loginType = @"phone";
        
        [self.emailBtn setTitleColor:[ColorManager Color7F7F7F] forState:UIControlStateNormal];
        self.emailBtn.backgroundColor = [ColorManager ColorF2F2F2];
        [self.phoneBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
        self.phoneBtn.backgroundColor = [ColorManager WhiteColor];
        [self.imgV1 setImage:kGetImage(@"login_手机")];
        [self.imgV2 setImage:kGetImage(@"login_验证码")];
        self.phoneTextF.hidden = NO;
        self.codeTextF.hidden = NO;
        self.codeBtn.hidden = NO;
        self.emailTextF.hidden = YES;
        self.passwordTextF.hidden = YES;
        self.disAppearBtn.hidden = YES;
        
        self.imgV3.hidden = YES;
        self.line3.hidden = YES;
        self.accountCodeTextF.hidden = YES;
        self.accountCodeImgV.hidden = YES;
//        [self.loginBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.line2.mas_bottom).mas_offset(kWidth(10));
//        }];
    }else{
        self.loginType = @"email";
        
        [self.phoneBtn setTitleColor:[ColorManager Color7F7F7F] forState:UIControlStateNormal];
        self.phoneBtn.backgroundColor = [ColorManager ColorF2F2F2];
        [self.emailBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
        self.emailBtn.backgroundColor = [ColorManager WhiteColor];
        [self.imgV1 setImage:kGetImage(@"login_邮箱")];
        [self.imgV2 setImage:kGetImage(@"login_密码")];
        self.phoneTextF.hidden = YES;
        self.codeTextF.hidden = YES;
        self.codeBtn.hidden = YES;
        self.emailTextF.hidden = NO;
        self.passwordTextF.hidden = NO;
        self.disAppearBtn.hidden = NO;
        
        self.imgV3.hidden = NO;
        self.line3.hidden = NO;
        self.accountCodeTextF.hidden = NO;
        self.accountCodeImgV.hidden = NO;
//        [self.loginBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.line3.mas_bottom).mas_offset(kWidth(10));
//        }];
        
    }
}

-(void)registerCkicked:(UIButton *)sender{
    if ([self.loginType isEqualToString:@"phone"]) {
        self.agreemType = @"phone";
        
        if (self.agreementBtn.isSelected) {
            [self phoneLogin];
        }else{
            self.agreementAlertV = [[AgreementAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
            [self.agreementAlertV.agreementBtn addTarget:self action:@selector(agreementTypeClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:self.agreementAlertV];
        }
        
    }else{
        self.agreemType = @"email";
        
        if (self.agreementBtn.isSelected) {
            [self passwordLogin];
        }else{
            self.agreementAlertV = [[AgreementAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
            [self.agreementAlertV.agreementBtn addTarget:self action:@selector(agreementTypeClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:self.agreementAlertV];
        }
    }
}

-(void)sendCodeClicked:(UIButton *)sender{
    
    if (self.phoneTextF.text.length) {
        
        NSDictionary *dic = @{@"phone":self.phoneTextF.text,@"prefix":@"86",@"sign":@"register_finish"};
        
        [FJNetTool postWithParams:dic url:Login_sendVerify loading:YES success:^(id responseObject) {
            BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
            if ([baseModel.code isEqualToString:CODE0]) {
                [self startTime];
            }else{
                [self.view showHUDWithText:baseModel.msg withYOffSet:0];
            }
        } failure:^(NSError *error) {
            
        }];
        
    }else{
        [self.view showHUDWithText:@"请输入手机号码" withYOffSet:0];
    }
    
}

-(void)startTime{
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置（倒计时结束后调用）
                [self.codeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                //设置不可点击
                self.codeBtn.userInteractionEnabled = YES;
                
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.codeBtn setTitle:[NSString stringWithFormat:@"重新发送(%@s)",strTime] forState:UIControlStateNormal];
                //设置可点击
                self.codeBtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    
    dispatch_resume(_timer);
}

//-(void)accountLoginClicked:(UIButton *)sender{
//    AccountLoginViewController *vc = [[AccountLoginViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
//}
-(void)wxLoginClicked{
    self.agreemType = @"wechat";
    if (!self.agreementBtn.isSelected) {
        self.agreementAlertV = [[AgreementAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [self.agreementAlertV.agreementBtn addTarget:self action:@selector(agreementTypeClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.agreementAlertV];
    }else{
        [self wxLogin];
    }
    
    
}
-(void)wxLogin{
    SendAuthReq *req =[[SendAuthReq alloc ] init];
    req.scope = @"snsapi_userinfo";
    req.state = @"none" ;
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req completion:^(BOOL success) {
        
    }];
}

-(void)checkWeiXinAccount:(NSNotification *)notification{
    NSDictionary *responseDic = notification.object;
    NSString *unionid = responseDic[@"unionid"];
    
    NSDictionary *dic = @{@"unionid":unionid};
    
    [FJNetTool postWithParams:dic url:Login_weixinLogin loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            UserInfoModel *userModel = [UserInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
            if (userModel.member_pass.length) {
                [UserInfoModel saveUserInfoModel:userModel];
                RegisterModel *registerModel = [[RegisterModel alloc]init];
                registerModel.user_id = userModel.member_id;
                registerModel.user_token = userModel.token;
                [RegisterModel saveUserInfoModel:registerModel];
                [LoginUsersModel saveLoginUsers:userModel];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"messageLogin" object:nil];
                [[NSUserDefaults standardUserDefaults] setValue:@"none" forKey:@"firstOpen"];
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                ChangePassWordViewController *vc = [[ChangePassWordViewController alloc]init];
                vc.type = @"register";
                vc.userInfo = userModel;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else{
            //未绑定手机号
            ChangePhoneViewController *vc = [[ChangePhoneViewController alloc]init];
            vc.type = @"2";
            vc.unionid = unionid;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } failure:^(NSError *error) {
        
    }];
}


-(void)appleLoginClicked{
    self.agreemType = @"apple";
    if (!self.agreementBtn.isSelected) {
        self.agreementAlertV = [[AgreementAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [self.agreementAlertV.agreementBtn addTarget:self action:@selector(agreementTypeClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.agreementAlertV];
    }else{
        [self appleLogin];
    }
    
    
}

-(void)appleLogin{
    if (@available(iOS 13.0, *)) {
            
            ASAuthorizationAppleIDProvider *appleIDProvider = [[ASAuthorizationAppleIDProvider alloc] init];
            ASAuthorizationAppleIDRequest *appleIDRequest = [appleIDProvider createRequest];
            // 用户授权请求的联系信息
            appleIDRequest.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
            ASAuthorizationController *authorizationController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[appleIDRequest]];
            // 设置授权控制器通知授权请求的成功与失败的代理
            authorizationController.delegate = self;
            // 设置提供 展示上下文的代理，在这个上下文中 系统可以展示授权界面给用户
            authorizationController.presentationContextProvider = self;
            // 在控制器初始化期间启动授权流
            [authorizationController performRequests];
        } else {
            NSLog(@"该系统版本不可用Apple登录");
            [self.view showHUDWithText:@"该系统版本不可用Apple登录" withYOffSet:0];
        }
}

-(void)agreementClicked:(UIButton *)sender{
    sender.selected = !sender.isSelected;
}

-(void)appleLoginWithServer:(NSString *)appleUser{
    NSDictionary *dic = @{@"appleid":appleUser};
    
    [FJNetTool postWithParams:dic url:Login_appleLogin loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            UserInfoModel *userModel = [UserInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
            if (userModel.member_pass.length) {
                [UserInfoModel saveUserInfoModel:userModel];
                RegisterModel *registerModel = [[RegisterModel alloc]init];
                registerModel.user_id = userModel.member_id;
                registerModel.user_token = userModel.token;
                [RegisterModel saveUserInfoModel:registerModel];
                [LoginUsersModel saveLoginUsers:userModel];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"messageLogin" object:nil];
                [[NSUserDefaults standardUserDefaults] setValue:@"none" forKey:@"firstOpen"];
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                ChangePassWordViewController *vc = [[ChangePassWordViewController alloc]init];
                vc.type = @"register";
                vc.userInfo = userModel;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else{
            [self.view showHUDWithText:baseModel.msg withYOffSet:0];
            //未绑定手机号
            ChangePhoneViewController *vc = [[ChangePhoneViewController alloc]init];
            vc.type = @"3";
            vc.appleCode = appleUser;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } failure:^(NSError *error) {
        
    }];
    
}

///代理主要用于展示在哪里
-(ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller API_AVAILABLE(ios(13.0)){
    return self.view.window;
}


-(void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0)){
        if([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]){
            ASAuthorizationAppleIDCredential *apple = authorization.credential;
            ///将返回得到的user 存储起来
            NSString *userIdentifier = apple.user;
            NSPersonNameComponents *fullName = apple.fullName;
            NSString *email = apple.email;
            //用于后台像苹果服务器验证身份信息
            NSData *identityToken = apple.identityToken;
            [self appleLoginWithServer:apple.user];
            
            NSLog(@"%@\n--%@\n--%@\n--%@",userIdentifier,fullName,email,identityToken);
        }else if ([authorization.credential isKindOfClass:[ASPasswordCredential class]]){
            
            //// Sign in using an existing iCloud Keychain credential.
            ASPasswordCredential *pass = authorization.credential;
            NSString *username = pass.user;
            NSString *passw = pass.password;
            
        }
    
}

///回调失败
-(void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0)){
    NSLog(@"%@",error);
    [self.view showHUDWithText:@"苹果账号登录失败" withYOffSet:0];
}


-(void)phoneLogin{
    if (self.codeTextF.text.length >= 6 && self.phoneTextF.text.length >=11) {
        
        NSDictionary *dic = @{@"code":self.codeTextF.text,@"phone":self.phoneTextF.text};
        
        [FJNetTool postWithParams:dic url:Login_phone_register loading:YES success:^(id responseObject) {
            BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
            if ([baseModel.code isEqualToString:CODE0]) {
                UserInfoModel *userModel = [UserInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
                
                RegisterModel *registerModel = [[RegisterModel alloc]init];
                registerModel.user_id = userModel.member_id;
                registerModel.user_token = userModel.token;
                [RegisterModel saveUserInfoModel:registerModel];
                if (!userModel.member_pass.length) {
                    ChangePassWordViewController *vc = [[ChangePassWordViewController alloc]init];
                    vc.type = @"register";
                    vc.userInfo = userModel;
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    [LoginUsersModel saveLoginUsers:userModel];
                    [UserInfoModel saveUserInfoModel:userModel];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"messageLogin" object:nil];
                    [[NSUserDefaults standardUserDefaults] setValue:@"none" forKey:@"firstOpen"];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
                
            }else{
                [self.view showHUDWithText:baseModel.msg withYOffSet:0];
            }
        } failure:^(NSError *error) {
            
        }];
        
    }
}

-(void)passwordLogin{
    if (!self.emailTextF.text.length) {
        [self.view showHUDWithText:@"请输入电子邮箱" withYOffSet:0];
        return;
    }
    if (!self.passwordTextF.text.length) {
        [self.view showHUDWithText:@"请输入密码" withYOffSet:0];
        return;
    }
    
    BOOL result = [self.imgCodeStr compare:self.accountCodeTextF.text
                             options:NSCaseInsensitiveSearch |NSNumericSearch] == NSOrderedSame;
    // 区分大小写
 //   BOOL result2 = [_str isEqualToString:_codeTextField.text];
    if (!result) {
        [self.view showHUDWithText:@"验证码错误" withYOffSet:0];
        return;

    }
    
    NSDictionary *keyDic = [KeyChain load:KEY_USERNAME_PASSWORD];
    
    NSString *md5Str = [NSString md5EncryptStr:[NSString stringWithFormat:@"%@%@",self.imgCodeStr,[keyDic objectForKey:KEY_PASSWORD]] bateNum:32 isLowercaseStr:YES];
    NSLog(@"md5555Str:%@",md5Str);
    
    //NSDictionary *dic =@{@"phone":self.emailTextF.text,@"pwd":self.passwordTextF.text};
    NSDictionary *dic =@{@"email":self.emailTextF.text,@"pass":self.passwordTextF.text,@"verify":self.imgCodeStr,@"code_id":[keyDic objectForKey:KEY_PASSWORD],@"encry":md5Str};
    
    [FJNetTool postWithParams:dic url:Login_email_register loading:YES success:^(id responseObject) {
        BaseModel *model = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([model.code isEqualToString:CODE0]) {
            UserInfoModel *userModel = [UserInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
            [UserInfoModel saveUserInfoModel:userModel];
            RegisterModel *registerModel = [[RegisterModel alloc]init];
            registerModel.user_id = userModel.member_id;
            registerModel.user_token = userModel.token;
            [RegisterModel saveUserInfoModel:registerModel];
            [LoginUsersModel saveLoginUsers:userModel];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"messageLogin" object:nil];
            [[NSUserDefaults standardUserDefaults] setValue:@"none" forKey:@"firstOpen"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [self.view showHUDWithText:model.msg withYOffSet:0];
        }
            
    } failure:^(NSError *error) {
        
    }];
}

-(void)agreementTypeClicked:(id)sender{
    [self.agreementAlertV removeFromSuperview];
//    if ([self.agreemType isEqualToString:@"phone"]) {
//        [self phoneLogin];
//    }else if ([self.agreemType isEqualToString:@"email"]){
//        [self passwordLogin];
//    }
//    else if ([self.agreemType isEqualToString:@"wechat"]){
//        [self wxLogin];
//    }
//    else if ([self.agreemType isEqualToString:@"apple"]){
//        [self appleLogin];
//    }
    self.agreementBtn.selected = YES;
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
