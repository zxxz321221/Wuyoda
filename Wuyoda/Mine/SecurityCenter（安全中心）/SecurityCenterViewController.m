//
//  SecurityCenterViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/8.
//

#import "SecurityCenterViewController.h"
#import "SecurityCenterTableViewCell.h"
#import "SecurityPhoneViewController.h"
#import "ChangePassWordViewController.h"
#import "ChangePhoneViewController.h"

@interface SecurityCenterViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)NSArray *titleArr;

@end

@implementation SecurityCenterViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"安全中心"];
    nav.backgroundColor = [ColorManager ColorF2F2F2];
    [self.view addSubview:nav];

    self.view.backgroundColor = [ColorManager ColorF2F2F2];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar+10, kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[SecurityCenterTableViewCell class] forCellReuseIdentifier:NSStringFromClass([SecurityCenterTableViewCell class])];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager ColorF2F2F2];
    
    [self.view addSubview:self.tableView];
    
    self.titleArr = [[NSArray alloc]initWithObjects:@"修改登录密码",@"手机号",@"邮箱", nil];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SecurityCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SecurityCenterTableViewCell class])];
    if (!cell) {
        cell = [[SecurityCenterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([SecurityCenterTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *titleStr = [self.titleArr objectAtIndex:indexPath.row];
    [cell.imgV setImage:kGetImage(titleStr)];
    cell.titleLab.text = titleStr;
    
    UserInfoModel *userInfo = [UserInfoModel getUserInfoModel];
    if (indexPath.row == 0) {
        cell.isLast = NO;
        cell.isFirst = YES;
    }
    
    if (indexPath.row == 1) {
        NSString *phoneStr = userInfo.member_tel2;
        if (phoneStr.length) {
            phoneStr = [phoneStr stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        }else{
            phoneStr = @"未绑定";
        }
        
        cell.infoLab.text = phoneStr;
        cell.isLast = NO;
        cell.isFirst = NO;
    }
    if (indexPath.row == 2) {
        NSString *emailStr = userInfo.member_email;
        if (!emailStr.length) {
            emailStr = @"未绑定";
        }
        cell.infoLab.text = emailStr;
        cell.isFirst = NO;
        cell.isLast = YES;
    }
    
    return cell;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.titleArr.count;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        if ([UserInfoModel getUserInfoModel].member_tel2.length) {
            ChangePassWordViewController *vc = [[ChangePassWordViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [self.view showHUDWithText:@"请先绑定手机号" withYOffSet:0];
            ChangePhoneViewController *vc = [[ChangePhoneViewController alloc]init];
            vc.type = @"1";
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    if (indexPath.row == 1) {
        SecurityPhoneViewController *vc = [[SecurityPhoneViewController alloc]init];
        vc.type = @"1";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 2) {
        SecurityPhoneViewController *vc = [[SecurityPhoneViewController alloc]init];
        vc.type = @"2";
        [self.navigationController pushViewController:vc animated:YES];
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
