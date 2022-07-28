//
//  SettingViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/29.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
#import "RemoveAccountViewController.h"
#import "BankCardTypeViewController.h"
#import "AccountListViewController.h"
#import "AboutViewController.h"
#import "VersionViewController.h"
#import "MessageViewController.h"
#import "AccountListViewController.h"
#import "AddressListViewController.h"

@interface SettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)NSArray *titleArr;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"设置"];
    nav.backgroundColor = [ColorManager ColorF2F2F2];
    [self.view addSubview:nav];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[SettingTableViewCell class] forCellReuseIdentifier:NSStringFromClass([SettingTableViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager ColorF2F2F2];
    
    UIView *footerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(66))];
    footerV.backgroundColor = [ColorManager ColorF2F2F2];
    UIView *footerBgV = [[UIView alloc]initWithFrame:CGRectMake(0, kWidth(10), kScreenWidth, kWidth(56))];
    footerBgV.backgroundColor = [ColorManager WhiteColor];
    footerBgV.layer.cornerRadius = kWidth(10);
    [footerV addSubview:footerBgV];
    UIButton *logoutBtn = [[UIButton alloc]initWithFrame:CGRectMake(kWidth(10), 0, kWidth(355), kWidth(56))];
    [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [logoutBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
    logoutBtn.titleLabel.font = kFont(16);
    [logoutBtn addTarget:self action:@selector(showLogoutView) forControlEvents:UIControlEventTouchUpInside];
    [footerBgV addSubview:logoutBtn];

    self.tableView.tableFooterView = footerV;
    
    [self.view addSubview:self.tableView];
    
    self.titleArr = @[@[@"账号管理",@"通知"],@[@"收货地址"],@[[NSString stringWithFormat:@"关于%@",[[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleDisplayName"]],[NSString stringWithFormat:@"%@版本",[[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"]],@"账号注销"]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SettingTableViewCell class])];
    if (!cell) {
        cell = [[SettingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([SettingTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleLab.text = [[self.titleArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.isLast = NO;
            cell.isFirst = YES;
        }else if (indexPath.row == 1) {
            cell.isFirst = NO;
            cell.isLast = YES;
        }
    }else if (indexPath.section == 1) {
        cell.isFirst = YES;
        cell.isLast = YES;
    }else{
        if (indexPath.row == 0) {
            cell.isLast = NO;
            cell.isFirst = YES;
        }else if (indexPath.row == 2) {
            cell.isFirst = NO;
            cell.isLast = YES;
        }else{
            cell.isFirst = NO;
            cell.isLast = NO;
        }
    }
    
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titleArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.titleArr objectAtIndex:section] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return kWidth(56);
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
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (![CommonManager isLogin:self isPush:YES]) {
                return;
            }
            AccountListViewController *vc = [[AccountListViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 1) {
            MessageViewController *vc = [[MessageViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if (indexPath.section == 1){
        AddressListViewController *vc = [[AddressListViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            AboutViewController *vc = [[AboutViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 1) {
            VersionViewController *vc = [[VersionViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 2) {
            if (![CommonManager isLogin:self isPush:YES]) {
                return;
            }
            RemoveAccountViewController *vc = [[RemoveAccountViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
//    if (indexPath.row == 2) {
//        [self.view showHUDWithText:@"敬请期待" withYOffSet:0];
//    }
//    if (indexPath.row == 3) {
////        BankCardTypeViewController *vc = [[BankCardTypeViewController alloc]init];
////        [self.navigationController pushViewController:vc animated:YES];
//        [self.view showHUDWithText:@"敬请期待" withYOffSet:0];
//    }
//    if (indexPath.row == 4) {
//        [self.view showHUDWithText:@"敬请期待" withYOffSet:0];
//    }
    
}

-(void)showLogoutView{
    if (![CommonManager isLogin:self isPush:YES]) {
        return;
    }
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"您可以选择以下操作" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //NSMutableAttributedString * str1 = [[NSMutableAttributedString alloc]initWithString:@"换个账号登录"];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"换个账号登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AccountListViewController *vc = [[AccountListViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [action1 setValue:[ColorManager ColorFA8B18] forKey:@"_titleTextColor"];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"退出当前账号" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [UserInfoModel clearUserInfo];
        [[NSUserDefaults standardUserDefaults] setValue:@"logout" forKey:@"firstOpen"];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }];
    [action2 setValue:[ColorManager MainColor] forKey:@"_titleTextColor"];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [cancelAction setValue:[ColorManager Color333333] forKey:@"_titleTextColor"];
    [alertC addAction:action1];
    [alertC addAction:action2];
    [alertC addAction:cancelAction];
    [self presentViewController:alertC animated:YES completion:nil];
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
