//
//  ChangePassWordViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/9.
//

#import "ChangePassWordViewController.h"
#import "ChangePasswordTableViewCell.h"
#import "PasswordSettingAlertView.h"

@interface ChangePassWordViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)UIButton *codeBtn;

@property (nonatomic , retain)UITextField *codeField;
@property (nonatomic , retain)UITextField *passwordField;
@property (nonatomic , retain)UITextField *passwordField2;

@property (nonatomic , retain)PasswordSettingAlertView *settingAlertV;

@end

@implementation ChangePassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"修改登录密码"];
    nav.backgroundColor = [ColorManager ColorF2F2F2];
    [self.view addSubview:nav];
    
    if ([self.type isEqualToString:@"register"] || [self.type isEqualToString:@"login"]) {
        UIButton *passBtn = [[UIButton alloc]init];
        [passBtn setTitle:@"跳过" forState:UIControlStateNormal];
        [passBtn setTitleColor:[ColorManager ColorFB9A3A] forState:UIControlStateNormal];
        passBtn.titleLabel.font = kFont(14);
        [passBtn addTarget:self action:@selector(passClicked) forControlEvents:UIControlEventTouchUpInside];
        [nav addSubview:passBtn];
        [passBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(kWidth(-20));
            make.bottom.mas_offset(kWidth(0));
            make.width.mas_offset(kWidth(32));
            make.height.mas_offset(kHeight_NavBar-kHeight_StatusBar);
        }];
    }
    
    self.view.backgroundColor = [ColorManager ColorF2F2F2];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar+kWidth(10), kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[ChangePasswordTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ChangePasswordTableViewCell class])];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager ColorF2F2F2];
    
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(101))];
    headerV.backgroundColor= [ColorManager WhiteColor];
    
    UILabel *headerLab =[[UILabel alloc]init];
    UserInfoModel *userInfo = [UserInfoModel getUserInfoModel];
    if (self.userInfo) {
        userInfo = self.userInfo;
    }
    if (userInfo.member_tel2.length && ![self.type isEqualToString:@"register"] && ![self.type isEqualToString:@"login"]) {
        NSString *phoneStr = userInfo.member_tel2;
        phoneStr = [phoneStr stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        headerLab.text = [NSString stringWithFormat:@"账号已与%@绑定请输入验证码，确认身份",phoneStr];
    }else{
        headerLab.text = [NSString stringWithFormat:@"请设置登录密码"];
    }
    
    if (!userInfo.member_pass.length) {
        [nav changeTitle:@"设置登录密码"];
    }
    
    headerLab.textColor = [ColorManager Color333333];
    headerLab.font = kFont(16);
    headerLab.numberOfLines = 0;
    headerLab.lineBreakMode = NSLineBreakByCharWrapping;
    headerLab.textAlignment = NSTextAlignmentCenter;
    [headerV addSubview:headerLab];
    
    [headerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(headerV);
        make.width.mas_offset(kWidth(200));
    }];
    self.tableView.tableHeaderView = headerV;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:headerV.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(kWidth(10), kWidth(10))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame =  headerV.bounds;
    maskLayer.path = maskPath.CGPath;
    headerV.layer.mask = maskLayer;
    
    
    UIView *footerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(88))];
    UIButton *saveBtn = [[UIButton alloc]init];
    [saveBtn setTitle:@"确认" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    saveBtn .titleLabel.font = kFont(14);
    [saveBtn setBackgroundImage:kGetImage(@"login_按钮") forState:UIControlStateNormal];
    saveBtn.layer.cornerRadius = kWidth(24);
    [saveBtn addTarget:self action:@selector(savePasswordClicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerV addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.equalTo(footerV);
        make.width.mas_offset(kWidth(321));
        make.height.mas_offset(kWidth(48));
    }];
    self.tableView.tableFooterView = footerV;
    
    [self.view addSubview:self.tableView];
    
}

-(void)passClicked{
    
    if ([self.type isEqualToString:@"register"]) {
        [self saveUserInfo];
    }else{
        [self showSettingAlert];
    }
    
}

-(void)showSettingAlert{
    
    self.settingAlertV = [[PasswordSettingAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.settingAlertV.passBtn addTarget:self action:@selector(passAlertClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.settingAlertV.settingBtn addTarget:self action:@selector(saveSettingClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.settingAlertV];
}

-(void)passAlertClicked{
    NSLog(@"userinfo:%@",self.userInfo.token);
    [self saveUserInfo];
}

-(void)saveSettingClicked{
    [self.settingAlertV removeFromSuperview];
    [LoginUsersModel savePasswordSetting:self.userInfo];
    [self saveUserInfo];
}

-(void)saveUserInfo{
    [UserInfoModel saveUserInfoModel:self.userInfo];
    RegisterModel *registerModel = [[RegisterModel alloc]init];
    registerModel.user_id = self.userInfo.member_id;
    registerModel.user_token = self.userInfo.token;
    [RegisterModel saveUserInfoModel:registerModel];
    [LoginUsersModel saveLoginUsers:self.userInfo];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"messageLogin" object:nil];
    [[NSUserDefaults standardUserDefaults] setValue:@"none" forKey:@"firstOpen"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)sendCodeClicked:(id)sender{
    NSDictionary *dic = @{};
    
    if (self.userInfo) {
        dic = @{@"phone":self.userInfo.member_tel2,@"prefix":@"86",@"api_token":[RegisterModel getUserInfoModel].user_token,@"sign":@"password_modifying"};
    }else{
        dic = @{@"phone":[UserInfoModel getUserInfoModel].member_tel2,@"prefix":@"86",@"api_token":[RegisterModel getUserInfoModel].user_token,@"sign":@"password_modifying"};
    }
    
    [FJNetTool postWithParams:dic url:Login_sendVerify loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            [self startTime];
            [self.view showHUDWithText:@"验证码发送成功" withYOffSet:0];
            [self.codeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
        }else{
            [self.view showHUDWithText:baseModel.msg withYOffSet:0];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)savePasswordClicked:(id)sender{
    if ([self.type isEqualToString:@"register"] || [self.type isEqualToString:@"login"]) {
        if (!self.passwordField.text.length || !self.passwordField2.text.length) {
            [self.view showHUDWithText:@"请填写完整信息" withYOffSet:0];
            return;
        }
    }else{
        if (!self.codeField.text.length || !self.passwordField.text.length || !self.passwordField2.text.length) {
            [self.view showHUDWithText:@"请填写完整信息" withYOffSet:0];
            return;
        }
    }
    
    if ([self.passwordField.text isEqualToString:self.passwordField2.text]) {
        NSDictionary *dic = @{};
        if (self.userInfo) {
            dic = @{@"m_uid":self.userInfo.uid,@"pwd":self.passwordField.text,@"api_token":[RegisterModel getUserInfoModel].user_token,@"type":@"2"};
        }else{
            dic = @{@"m_uid":[UserInfoModel getUserInfoModel].uid,@"pwd":self.passwordField.text,@"code":self.codeField.text,@"api_token":[RegisterModel getUserInfoModel].user_token,@"type":@"1"};
        }
        
        [FJNetTool postWithParams:dic url:Login_pass_save loading:YES success:^(id responseObject) {
            BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
            if ([baseModel.code isEqualToString:CODE0]) {
                if (self.userInfo) {
                    [self.view showHUDWithText:@"设置密码成功" withYOffSet:0];
                    self.userInfo.member_pass = self.passwordField.text;
                    [UserInfoModel saveUserInfoModel:self.userInfo];
                    [LoginUsersModel saveLoginUsers:self.userInfo];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"messageLogin" object:nil];
                    [[NSUserDefaults standardUserDefaults] setValue:@"none" forKey:@"firstOpen"];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }else{
                    [self.view showHUDWithText:@"修改密码成功" withYOffSet:0];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                
            }else{
                [self.view showHUDWithText:baseModel.msg withYOffSet:0];
            }
        } failure:^(NSError *error) {
            
        }];
    }else{
        [self.view showHUDWithText:@"两次密码不一致" withYOffSet:0];
    }
    
}

-(void)passwordHiddenClicked:(UIButton *)sender{
    sender.selected = !sender.isSelected;
    if ([self.type isEqualToString:@"register"] || [self.type isEqualToString:@"login"]){
        if (sender.tag == 0) {
            self.passwordField.secureTextEntry = !self.passwordField.isSecureTextEntry;
        }else{
            self.passwordField2.secureTextEntry = !self.passwordField2.isSecureTextEntry;
        }
    }else{
        if (sender.tag == 1) {
            self.passwordField.secureTextEntry = !self.passwordField.isSecureTextEntry;
        }else{
            self.passwordField2.secureTextEntry = !self.passwordField2.isSecureTextEntry;
        }
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChangePasswordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ChangePasswordTableViewCell class])];
    if (!cell) {
        cell = [[ChangePasswordTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ChangePasswordTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([self.type isEqualToString:@"register"] || [self.type isEqualToString:@"login"]) {
       
        if (indexPath.row == 0) {
            cell.titleLab.text = @"新密码";
            cell.infoTextField.placeholder = @"6-20位数字或字母";
            cell.getCodeBtn.hidden = YES;
            cell.disAppearBtn.hidden = NO;
            cell.disAppearBtn.tag = indexPath.row;
            [cell.disAppearBtn addTarget:self action:@selector(passwordHiddenClicked:) forControlEvents:UIControlEventTouchUpInside];
            self.passwordField = cell.infoTextField;
            self.passwordField.secureTextEntry = YES;
            cell.isLast = NO;
        }
        if (indexPath.row == 1) {
            cell.titleLab.text = @"确认密码";
            cell.infoTextField.placeholder = @"请再次输入新密码";
            cell.getCodeBtn.hidden = YES;
            cell.disAppearBtn.hidden = NO;
            cell.disAppearBtn.tag = indexPath.row;
            [cell.disAppearBtn addTarget:self action:@selector(passwordHiddenClicked:) forControlEvents:UIControlEventTouchUpInside];
            self.passwordField2 = cell.infoTextField;
            self.passwordField2.secureTextEntry = YES;
            cell.isLast = YES;
        }
    }else{
        if (indexPath.row == 0) {
            cell.titleLab.text = @"验证码";
            cell.infoTextField.placeholder = @"请输入验证码";
            cell.getCodeBtn.hidden = NO;
            cell.disAppearBtn.hidden = YES;
            self.codeBtn = cell.getCodeBtn;
            self.codeField = cell.infoTextField;
            [self.codeBtn addTarget:self action:@selector(sendCodeClicked:) forControlEvents:UIControlEventTouchUpInside];
            cell.isLast = NO;
        }
        if (indexPath.row == 1) {
            cell.titleLab.text = @"新密码";
            cell.infoTextField.placeholder = @"6-20位数字或字母";
            cell.getCodeBtn.hidden = YES;
            cell.disAppearBtn.hidden = NO;
            cell.disAppearBtn.tag = indexPath.row;
            [cell.disAppearBtn addTarget:self action:@selector(passwordHiddenClicked:) forControlEvents:UIControlEventTouchUpInside];
            self.passwordField = cell.infoTextField;
            self.passwordField.secureTextEntry = YES;
            cell.isLast = NO;
        }
        if (indexPath.row == 2) {
            cell.titleLab.text = @"确认密码";
            cell.infoTextField.placeholder = @"请再次输入新密码";
            cell.getCodeBtn.hidden = YES;
            cell.disAppearBtn.hidden = NO;
            cell.disAppearBtn.tag = indexPath.row;
            [cell.disAppearBtn addTarget:self action:@selector(passwordHiddenClicked:) forControlEvents:UIControlEventTouchUpInside];
            self.passwordField2 = cell.infoTextField;
            self.passwordField2.secureTextEntry = YES;
            cell.isLast = YES;
        }
    }
    
    
    return cell;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if ([self.type isEqualToString:@"register"] || [self.type isEqualToString:@"login"]) {
        return 2;
    }
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return kWidth(56);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return [UIView new];
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
                [self.codeBtn setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                //设置可点击
                self.codeBtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    
    dispatch_resume(_timer);
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
