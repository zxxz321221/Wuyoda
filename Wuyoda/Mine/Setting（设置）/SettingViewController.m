//
//  SettingViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/29.
//

#import "SettingViewController.h"
#import "MineTableViewCell.h"
#import "RemoveAccountViewController.h"
#import "BankCardTypeViewController.h"
#import "AccountListViewController.h"
#import "AboutViewController.h"
#import "VersionViewController.h"
#import "MessageViewController.h"

@interface SettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)NSArray *titleArr;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@""];
    [self.view addSubview:nav];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MineTableViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager WhiteColor];
    
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(68))];
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"设置";
    titleLab.textColor = [ColorManager BlackColor];
    titleLab.font = kFont(28);
    [headerV addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kWidth(10));
        make.left.mas_offset(kWidth(20));
    }];
    
    self.tableView.tableHeaderView = headerV;
    
    [self.view addSubview:self.tableView];
    
    self.titleArr = @[@"账号管理",@"通知",@"货币",@"收款方式",@"发票信息管理",@"关于无忧达",@"1.0.0版本",@"账号注销",@"退出登录"];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MineTableViewCell class])];
    if (!cell) {
        cell = [[MineTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([MineTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleLab.text = [self.titleArr objectAtIndex:indexPath.row];
    
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return kWidth(64);
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        AccountListViewController *vc = [[AccountListViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 1) {
        MessageViewController *vc = [[MessageViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 2) {
        
    }
    if (indexPath.row == 3) {
        BankCardTypeViewController *vc = [[BankCardTypeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 4) {
        
    }
    if (indexPath.row == 5) {
        AboutViewController *vc = [[AboutViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 6) {
        VersionViewController *vc = [[VersionViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 7) {
        RemoveAccountViewController *vc = [[RemoveAccountViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 8) {
        [self showLogoutView];
    }
}

-(void)showLogoutView{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"您可以选择以下操作" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //NSMutableAttributedString * str1 = [[NSMutableAttributedString alloc]initWithString:@"换个账号登录"];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"换个账号登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [action1 setValue:[ColorManager Color008A70] forKey:@"_titleTextColor"];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"退出当前账号" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [action2 setValue:[ColorManager Color008A70] forKey:@"_titleTextColor"];
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
