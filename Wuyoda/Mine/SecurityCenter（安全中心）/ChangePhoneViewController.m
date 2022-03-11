//
//  ChangePhoneViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/11.
//

#import "ChangePhoneViewController.h"
#import "ChangePasswordTableViewCell.h"
#import "ChangePassWordViewController.h"

@interface ChangePhoneViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)UIButton *codeBtn;

@property (nonatomic , retain)UITextField *codeField;
@property (nonatomic , retain)UITextField *phoneField;

@end

@implementation ChangePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"修改手机号"];
    if (![self.type isEqualToString:@"1"]) {
        [nav changeTitle:@"绑定手机号"];
    }
    [self.view addSubview:nav];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[ChangePasswordTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ChangePasswordTableViewCell class])];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager WhiteColor];
    
    
    UIView *footerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(102))];
    UIButton *saveBtn = [[UIButton alloc]init];
    [saveBtn setTitle:@"确认" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    saveBtn .titleLabel.font = kFont(14);
    saveBtn.backgroundColor= [ColorManager MainColor];
    saveBtn.layer.cornerRadius = kWidth(24);
    [saveBtn addTarget:self action:@selector(savePhoneClicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerV addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.equalTo(footerV);
        make.width.mas_offset(kWidth(321));
        make.height.mas_offset(kWidth(48));
    }];
    self.tableView.tableFooterView = footerV;
    
    [self.view addSubview:self.tableView];
}

-(void)sendCodeClicked:(id)sender{
    
    if (self.phoneField.text.length) {
        
        NSDictionary *dic = @{@"phone":self.phoneField.text,@"prefix":@"86",@"api_token":[RegisterModel getUserInfoModel].user_token};
        
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
        
    }else{
        [self.view showHUDWithText:@"请输入手机号码" withYOffSet:0];
    }
}

-(void)savePhoneClicked:(id)sender{
    if (!self.codeField.text.length || !self.phoneField.text.length) {
        [self.view showHUDWithText:@"请填写完整信息" withYOffSet:0];
    }else{
        if ([self.type isEqualToString:@"1"]) {
            [self changePhoneFromServer];
        }else{
            [self bindPhoneFromServer];
        }
    }
    
}

- (void)changePhoneFromServer{
    NSDictionary *dic = @{@"m_uid":[UserInfoModel getUserInfoModel].uid,@"phone":self.phoneField.text,@"code":self.codeField.text,@"api_token":[RegisterModel getUserInfoModel].user_token};
    
    [FJNetTool postWithParams:dic url:Login_phone_save loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            
            UserInfoModel*userInfo = [UserInfoModel getUserInfoModel];
            userInfo.member_tel2 = self.phoneField.text;
            [UserInfoModel saveUserInfoModel:userInfo];
            [self.view showHUDWithText:@"修改手机号码成功" withYOffSet:0];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self.view showHUDWithText:baseModel.msg withYOffSet:0];
        }
    } failure:^(NSError *error) {
        
    }];

}

-(void)bindPhoneFromServer{
    NSString *url;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:self.phoneField.text forKey:@"phone"];
    [dic setObject:self.codeField.text forKey:@"check"];
    [dic setObject:[RegisterModel getUserInfoModel].user_token forKey:@"api_token"];
    if ([self.type isEqualToString:@"2"]) {
        url = Login_weixinLogin;
        [dic setObject:self.unionid forKey:@"unionid"];
    }else{
        url = Login_appleLogin;
        [dic setObject:self.appleCode forKey:@"appleid"];
    }
    
    [FJNetTool postWithParams:dic url:url loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            
            UserInfoModel *userModel = [UserInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
            RegisterModel *registerModel = [RegisterModel getUserInfoModel];
            registerModel.user_id = userModel.member_id;
            registerModel.user_token = userModel.token;
            [RegisterModel saveUserInfoModel:registerModel];
            
            if (!userModel.member_pass.length) {
                ChangePassWordViewController *vc = [[ChangePassWordViewController alloc]init];
                vc.userInfo = userModel;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [LoginUsersModel saveLoginUsers:userModel];
                [UserInfoModel saveUserInfoModel:userModel];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChangePasswordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ChangePasswordTableViewCell class])];
    if (!cell) {
        cell = [[ChangePasswordTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ChangePasswordTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.disAppearBtn.hidden = YES;
    if (indexPath.row == 0) {
        
        cell.titleLab.text = @"手机号";
        cell.infoTextField.placeholder = @"请输入手机号";
        cell.getCodeBtn.hidden = NO;
        self.phoneField = cell.infoTextField;
        self.codeBtn = cell.getCodeBtn;
        [self.codeBtn addTarget:self action:@selector(sendCodeClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (indexPath.row == 1) {
        cell.titleLab.text = @"验证码";
        cell.infoTextField.placeholder = @"请输入验证码";
        cell.getCodeBtn.hidden = YES;
        self.codeField = cell.infoTextField;
    }
    
    return cell;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return kWidth(52);
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
