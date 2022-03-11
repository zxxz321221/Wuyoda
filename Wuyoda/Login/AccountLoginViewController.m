//
//  AccountLoginViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/9.
//

#import "AccountLoginViewController.h"
#import "ForgetPasswordViewController.h"
#import <AuthenticationServices/AuthenticationServices.h>
#import "ChangePhoneViewController.h"

@interface AccountLoginViewController ()

@property (nonatomic , retain)UITextField *accountField;

@property (nonatomic , retain)UITextField *passwordField;

@property (nonatomic , retain)UIButton *agreementBtn;

@end

@implementation AccountLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@""];
    [self.view addSubview:nav];
    
    UILabel *titleLab = [[UILabel  alloc]init];
    titleLab.text = @"使用账号密码登录";
    titleLab.textColor = [ColorManager BlackColor];
    titleLab.font = kFont(28);
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.equalTo(nav.mas_bottom).mas_offset(kWidth(35));
    }];
    
    UILabel *tipLab = [[UILabel alloc]init];
    tipLab.text = @"使用已注册手机号或邮箱登录";
    tipLab.textColor = [ColorManager Color7F7F7F];
    tipLab.font = kFont(16);
    [self.view addSubview:tipLab];
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.equalTo(titleLab.mas_bottom).mas_offset(kWidth(8));
    }];
    
    UILabel *phoneLab = [[UILabel alloc]init];
    phoneLab.text = @"手机号码/电子邮箱地址";
    phoneLab.textColor = [ColorManager BlackColor];
    phoneLab.font = kFont(14);
    [self.view addSubview:phoneLab];
    [phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.equalTo(tipLab.mas_bottom).mas_offset(kWidth(24));
    }];
    
    self.accountField = [[UITextField alloc]init];
    self.accountField.textColor = [ColorManager BlackColor];
    self.accountField.placeholder = @"请输入手机号码/电子邮箱地址";
    self.accountField.font = kFont(16);
    [self.view addSubview:self.accountField];
    [self.accountField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneLab.mas_bottom).mas_offset(kWidth(10));
        make.left.mas_offset(kWidth(20));
        make.right.mas_offset(kWidth(-20));
        make.height.mas_offset(kWidth(48));
    }];
    
    UIView *lineV1 = [[UIView alloc]init];
    lineV1.backgroundColor = [ColorManager ColorF7F7F7];
    [self.view addSubview:lineV1];
    [lineV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accountField.mas_bottom);
        make.left.mas_offset(kWidth(20));
        make.right.mas_offset(kWidth(-20));
        make.height.mas_offset(kWidth(1));
    }];
    
    UILabel *passwordLab = [[UILabel alloc]init];
    passwordLab.text = @"密码";
    passwordLab.textColor = [ColorManager BlackColor];
    passwordLab.font = kFont(14);
    [self.view addSubview:passwordLab];
    [passwordLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.equalTo(self.accountField.mas_bottom).mas_offset(kWidth(16));
    }];
    
    self.passwordField = [[UITextField alloc]init];
    self.passwordField.textColor = [ColorManager BlackColor];
    self.passwordField.placeholder = @"请输入密码";
    self.passwordField.font = kFont(16);
    [self.view addSubview:self.passwordField];
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordLab.mas_bottom).mas_offset(kWidth(10));
        make.left.mas_offset(kWidth(20));
        make.right.mas_offset(kWidth(-20));
        make.height.mas_offset(kWidth(48));
    }];
    UIView *lineV2 = [[UIView alloc]init];
    lineV2.backgroundColor = [ColorManager ColorF7F7F7];
    [self.view addSubview:lineV2];
    [lineV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordField.mas_bottom);
        make.left.mas_offset(kWidth(20));
        make.right.mas_offset(kWidth(-20));
        make.height.mas_offset(kWidth(1));
    }];
    
    
    UIButton *loginBtn = [[UIButton alloc]init];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = kFont(14);
    loginBtn.backgroundColor = [ColorManager MainColor];
    loginBtn.layer.cornerRadius = kWidth(5);
    [loginBtn addTarget:self action:@selector(loginClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineV2.mas_bottom).mas_offset(kWidth(24));
        make.left.mas_offset(kWidth(20));
        make.right.mas_offset(kWidth(-20));
        make.height.mas_offset(kWidth(42));
    }];
    
    UIButton *codeLoginBtn = [[UIButton alloc]init];
    [codeLoginBtn setTitle:@"验证码登录" forState:UIControlStateNormal];
    [codeLoginBtn setTitleColor:[ColorManager MainColor] forState:UIControlStateNormal];
    codeLoginBtn.titleLabel.font = kFont(14);
    [codeLoginBtn addTarget:self action:@selector(codeLoginClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:codeLoginBtn];
    [codeLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.equalTo(loginBtn.mas_bottom).mas_offset(kWidth(24));
        make.width.mas_offset(kWidth(80));
        make.height.mas_offset(kWidth(20));
    }];
    
    UIButton *forgetBtn = [[UIButton alloc]init];
    [forgetBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:[ColorManager Color7F7F7F] forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = kFont(14);
    [forgetBtn addTarget:self action:@selector(forgetPasswordClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(kWidth(-20));
            make.centerY.equalTo(codeLoginBtn);
            make.width.mas_offset(kWidth(80));
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkWeiXinAccount:) name:@"weixinLoginSuccess" object:nil];
    
}

-(void)loginClicked:(UIButton *)sender{
    if (!self.accountField.text.length) {
        [self.view showHUDWithText:@"请输入账号" withYOffSet:0];
        return;
    }
    if (!self.passwordField.text.length) {
        [self.view showHUDWithText:@"请输入密码" withYOffSet:0];
        return;
    }
    if (!self.agreementBtn.isSelected) {
        [self.view showHUDWithText:@"请同意用户协议" withYOffSet:0];
        return;
    }
    
    NSDictionary *dic =@{@"phone":self.accountField.text,@"pwd":self.passwordField.text,@"api_token":[RegisterModel getUserInfoModel].user_token};
    
    [FJNetTool postWithParams:dic url:Login_Login_index loading:YES success:^(id responseObject) {
        BaseModel *model = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([model.code isEqualToString:CODE0]) {
            UserInfoModel *userModel = [UserInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
            [UserInfoModel saveUserInfoModel:userModel];
            RegisterModel *registerModel = [RegisterModel getUserInfoModel];
            registerModel.user_id = userModel.member_id;
            registerModel.user_token = userModel.token;
            [RegisterModel saveUserInfoModel:registerModel];
            [LoginUsersModel saveLoginUsers:userModel];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [self.view showHUDWithText:model.msg withYOffSet:0];
        }
            
    } failure:^(NSError *error) {
        
    }];
}
-(void)codeLoginClicked:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)forgetPasswordClicked{
    ForgetPasswordViewController *vc = [[ForgetPasswordViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)wxLoginClicked{
    if (!self.agreementBtn.isSelected) {
        [self.view showHUDWithText:@"请同意用户协议" withYOffSet:0];
        return;
    }
    
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
    
    NSDictionary *dic = @{@"unionid":unionid,@"api_token":[RegisterModel getUserInfoModel].user_token};
    
    [FJNetTool postWithParams:dic url:Login_weixinLogin loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            UserInfoModel *userModel = [UserInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
            [UserInfoModel saveUserInfoModel:userModel];
            RegisterModel *registerModel = [RegisterModel getUserInfoModel];
            registerModel.user_id = userModel.member_id;
            registerModel.user_token = userModel.token;
            [RegisterModel saveUserInfoModel:registerModel];
            [LoginUsersModel saveLoginUsers:userModel];
            [self dismissViewControllerAnimated:YES completion:nil];
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
    NSDictionary *dic = @{@"appleid":appleUser,@"api_token":[RegisterModel getUserInfoModel].user_token};
    
    [FJNetTool postWithParams:dic url:Login_appleLogin loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            UserInfoModel *userModel = [UserInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
            [UserInfoModel saveUserInfoModel:userModel];
            RegisterModel *registerModel = [RegisterModel getUserInfoModel];
            registerModel.user_id = userModel.member_id;
            registerModel.user_token = userModel.token;
            [RegisterModel saveUserInfoModel:registerModel];
            [LoginUsersModel saveLoginUsers:userModel];
            [self dismissViewControllerAnimated:YES completion:nil];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
