//
//  ChangePassWordViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/9.
//

#import "ChangePassWordViewController.h"
#import "ChangePasswordTableViewCell.h"

@interface ChangePassWordViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)UIButton *codeBtn;

@property (nonatomic , retain)UITextField *codeField;
@property (nonatomic , retain)UITextField *passwordField;
@property (nonatomic , retain)UITextField *passwordField2;

@end

@implementation ChangePassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"修改登录密码"];
    [self.view addSubview:nav];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[ChangePasswordTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ChangePasswordTableViewCell class])];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager WhiteColor];
    
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(101))];
    headerV.backgroundColor= [ColorManager ColorF2F2F2];
    UILabel *headerLab =[[UILabel alloc]init];
    headerLab.text = @"账号已与157****7485绑定请输入验证码，确认身份";
    headerLab.textColor = [ColorManager Color333333];
    headerLab.font = kFont(16);
    headerLab.numberOfLines = 0;
    headerLab.lineBreakMode = NSLineBreakByCharWrapping;
    headerLab.textAlignment = NSTextAlignmentCenter;
    [headerV addSubview:headerLab];
    [headerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(headerV);
        make.width.mas_offset(kWidth(191));
    }];
    self.tableView.tableHeaderView = headerV;
    
    
    UIView *footerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(88))];
    UIButton *saveBtn = [[UIButton alloc]init];
    [saveBtn setTitle:@"确认" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    saveBtn .titleLabel.font = kFont(14);
    saveBtn.backgroundColor= [ColorManager MainColor];
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

-(void)sendCodeClicked:(id)sender{
    
    NSDictionary *dic = @{@"phone":[UserInfoModel getUserInfoModel].member_tel2,@"prefix":@"86",@"api_token":[RegisterModel getUserInfoModel].user_token};
    
    [FJNetTool postWithParams:dic url:Login_sendVerify loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            [self.view showHUDWithText:@"验证码发送成功" withYOffSet:0];
            [self.codeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
        }else{
            [self.view showHUDWithText:baseModel.msg withYOffSet:0];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)savePasswordClicked:(id)sender{
    if (!self.codeField.text.length || !self.passwordField.text.length || !self.passwordField2.text.length) {
        [self.view showHUDWithText:@"请填写完整信息" withYOffSet:0];
    }else{
        if ([self.passwordField.text isEqualToString:self.passwordField2.text]) {
            NSDictionary *dic = @{@"m_uid":[UserInfoModel getUserInfoModel].member_id,@"pwd":self.passwordField.text,@"code":self.codeField.text,@"api_token":[RegisterModel getUserInfoModel].user_token};
            
            [FJNetTool postWithParams:dic url:Login_pass_save loading:YES success:^(id responseObject) {
                BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
                if ([baseModel.code isEqualToString:CODE0]) {
                    [self.view showHUDWithText:@"修改密码成功" withYOffSet:0];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [self.view showHUDWithText:baseModel.msg withYOffSet:0];
                }
            } failure:^(NSError *error) {
                
            }];
        }else{
            [self.view showHUDWithText:@"两次密码不一致" withYOffSet:0];
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChangePasswordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ChangePasswordTableViewCell class])];
    if (!cell) {
        cell = [[ChangePasswordTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ChangePasswordTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if (indexPath.row == 0) {
        cell.titleLab.text = @"验证码";
        cell.infoTextField.placeholder = @"请输入验证码";
        cell.getCodeBtn.hidden = NO;
        cell.disAppearBtn.hidden = YES;
        self.codeBtn = cell.getCodeBtn;
        self.codeField = cell.infoTextField;
        [self.codeBtn addTarget:self action:@selector(sendCodeClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (indexPath.row == 1) {
        cell.titleLab.text = @"新密码";
        cell.infoTextField.placeholder = @"8-20位大小写字母/数字/符号";
        cell.getCodeBtn.hidden = YES;
        cell.disAppearBtn.hidden = NO;
        self.passwordField = cell.infoTextField;
    }
    if (indexPath.row == 2) {
        cell.titleLab.text = @"确认密码";
        cell.infoTextField.placeholder = @"请再次输入新密码";
        cell.getCodeBtn.hidden = YES;
        cell.disAppearBtn.hidden = NO;
        self.passwordField2 = cell.infoTextField;
    }
    
    return cell;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 3;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
