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

@end

@implementation AccountListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"账号管理"];
    [self.view addSubview:nav];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[AccountListTableViewCell class] forCellReuseIdentifier:NSStringFromClass([AccountListTableViewCell class])];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager ColorF2F2F2];
    
    [self.view addSubview:self.tableView];
    
    self.usersArr = [LoginUsersModel getLoginUsers];
}

-(void)deleteUserClicked:(UIButton *)sender{
    UserInfoModel *user = [self.usersArr objectAtIndex:sender.tag];
    [LoginUsersModel deleteLoginUsers:user];
    self.usersArr = [LoginUsersModel getLoginUsers];
    [self.tableView reloadData];
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
        
        cell.deleteBtn.tag = indexPath.row;
        [cell.deleteBtn addTarget:self action:@selector(deleteUserClicked:) forControlEvents:UIControlEventTouchUpInside];
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
        
        LoginViewController *VC = [[LoginViewController alloc] init];
        VC.modalPresentationStyle = UIModalPresentationFullScreen;
        //[viewCotroller.navigationController pushViewController:VC animated:YES];
        FJBaseNavigationController *nav = [[FJBaseNavigationController alloc]initWithRootViewController:VC];
        nav.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:nav animated:YES completion:nil];
    }else{
        UserInfoModel *currentUser = [UserInfoModel getUserInfoModel];
        UserInfoModel *user = [self.usersArr objectAtIndex:indexPath.row];
        if (![currentUser.member_id isEqualToString:user.member_id]) {
            [UserInfoModel saveUserInfoModel:user];
            [self.navigationController popToRootViewControllerAnimated:YES];
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
