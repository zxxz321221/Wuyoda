//
//  AccountListViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/30.
//

#import "AccountListViewController.h"
#import "AccountListTableViewCell.h"

@interface AccountListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)NSMutableArray *usersArr;

@property (nonatomic , retain)UIButton *editBtn;

@end

@implementation AccountListViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.usersArr = [LoginUsersModel getLoginUsers];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"账号管理"];
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
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kWidth(10), kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea-kWidth(30)-kWidth(65)) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[AccountListTableViewCell class] forCellReuseIdentifier:NSStringFromClass([AccountListTableViewCell class])];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager WhiteColor];
    
    [bgView addSubview:self.tableView];
    
    
    
    UIView *bottomV = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-kHeight_SafeArea-kWidth(65), kScreenWidth, kWidth(65)+kHeight_SafeArea)];
    bottomV.backgroundColor = [ColorManager WhiteColor];
    [self.view addSubview:bottomV];
    self.editBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(35))];
    [self.editBtn setTitle:@"删除此设备上的账户记录" forState:UIControlStateNormal];
    [self.editBtn setTitle:@"取消" forState:UIControlStateSelected];
    [self.editBtn setTitleColor:[ColorManager Color333333] forState:UIControlStateNormal];
    [self.editBtn addTarget:self action:@selector(editBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.editBtn.titleLabel.font = kFont(16);
    [bottomV addSubview:self.editBtn];
}

-(void)editBtnClicked:(UIButton *)sender{
    sender.selected = !sender.isSelected;
    [self.tableView reloadData];
}

-(void)deleteUserClicked:(UIButton *)sender{
    UserInfoModel *user = [self.usersArr objectAtIndex:sender.tag];
    UserInfoModel *currentUser = [UserInfoModel getUserInfoModel];
    if (![user.uid isEqualToString:currentUser.uid]) {
        [LoginUsersModel deleteLoginUsers:user];
        self.usersArr = [LoginUsersModel getLoginUsers];
        [self.tableView reloadData];
    }else{
        [self.view showHUDWithText:@"不可删除当前账号" withYOffSet:0];
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AccountListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AccountListTableViewCell class])];
    if (!cell) {
        cell = [[AccountListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([AccountListTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == self.usersArr.count) {
        cell.type = @"2";
    }else{
        cell.model = [self.usersArr objectAtIndex:indexPath.row];
        cell.type = @"1";
        cell.deleteBtn.tag = indexPath.row;
        [cell.deleteBtn addTarget:self action:@selector(deleteUserClicked:) forControlEvents:UIControlEventTouchUpInside];
        cell.isEdit = self.editBtn.isSelected;
    }
    
    
    
    return cell;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.usersArr.count+1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return kWidth(76);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return kWidth(10);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return [UIView new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.usersArr.count) {
        
        NewLoginViewController *VC = [[NewLoginViewController alloc] init];
        VC.modalPresentationStyle = UIModalPresentationFullScreen;
        //[viewCotroller.navigationController pushViewController:VC animated:YES];
        FJBaseNavigationController *nav = [[FJBaseNavigationController alloc]initWithRootViewController:VC];
        nav.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:nav animated:YES completion:nil];
    }else{
        UserInfoModel *currentUser = [UserInfoModel getUserInfoModel];
        UserInfoModel *user = [self.usersArr objectAtIndex:indexPath.row];
        if (![currentUser.member_id isEqualToString:user.member_id]) {
            
            NSDictionary *dic = @{@"api_token":user.token,@"uid":user.uid};
            
            [FJNetTool postWithParams:dic url:Login_login_status loading:YES success:^(id responseObject) {
                BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
                if ([baseModel.code isEqualToString:CODE0]) {
                    if ([baseModel.msg isEqualToString:@"有效"]) {
                        UserInfoModel *userModel = [UserInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
                        
                        RegisterModel *registerModel = [RegisterModel getUserInfoModel];
                        registerModel.user_id = userModel.member_id;
                        registerModel.user_token = userModel.token;
                        [RegisterModel saveUserInfoModel:registerModel];
                        [UserInfoModel saveUserInfoModel:userModel];
                        [self.navigationController popToRootViewControllerAnimated:YES];
                        
                    }
                }else{
                    [self.view showHUDWithText:@"登录状态已过期，请重新登录" withYOffSet:0];
                    [UserInfoModel clearUserInfo];
                    [[NSUserDefaults standardUserDefaults] setValue:@"logout" forKey:@"firstOpen"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeAccountLoginTimeOut" object:nil];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                   
                    
                }
                    
            } failure:^(NSError *error) {
                    
            }];
            
        }
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
