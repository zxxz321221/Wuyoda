//
//  MineViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/9.
//

#import "MineViewController.h"
#import "View/MineHeaderView.h"
#import "View/MineOrderTableViewCell.h"
#import "View/MineTableViewCell.h"
#import "SettingViewController.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)MineHeaderView *headerV;

@property (nonatomic , retain)NSArray *titleArr;

@end

@implementation MineViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([CommonManager isLogin:self isPush:NO]) {
        UserInfoModel *userInfo = [UserInfoModel getUserInfoModel];
        [self.headerV.iconImgV sd_setImageWithURL:[NSURL URLWithString:userInfo.member_image] placeholderImage:kGetImage(@"normal_icon")];
        self.headerV.nameLab.text = userInfo.member_name;
        self.headerV.isLogin = YES;
    }else{
        [self.headerV.iconImgV sd_setImageWithURL:[NSURL URLWithString:@""]];
        self.headerV.nameLab.text = @"未登录";
        self.headerV.isLogin = NO;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"我的"];
    [nav leftBtnHidden:YES];
    [self.view addSubview:nav];
    
    UIButton *settingBtn = [[UIButton alloc]init];
    [settingBtn setImage:kGetImage(@"设置") forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(settingClicked) forControlEvents:UIControlEventTouchUpInside];
    [nav addSubview:settingBtn];
    [settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-24));
        make.bottom.mas_offset(kWidth(0));
        make.width.mas_offset(kWidth(16));
        make.height.mas_offset(kHeight_NavBar-kHeight_StatusBar);
    }];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_TabBar) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[MineOrderTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MineOrderTableViewCell class])];
    [self.tableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MineTableViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager WhiteColor];
    
    self.headerV = [[MineHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(146))];
    self.tableView.tableHeaderView = self.headerV;
    
    [self.view addSubview:self.tableView];
    
    self.titleArr = @[@"批发商申请",@"分享APP"];
}

-(void)settingClicked{
    SettingViewController *vc = [[SettingViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MineOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MineOrderTableViewCell class])];
        if (!cell) {
            cell = [[MineOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([MineOrderTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MineTableViewCell class])];
        if (!cell) {
            cell = [[MineTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([MineTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.titleLab.text = [self.titleArr objectAtIndex:indexPath.row];
        
        return cell;
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return self.titleArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return kWidth(235);
    }
    return kWidth(64);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return kWidth(62);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(62))];
    headerV.backgroundColor = [ColorManager WhiteColor];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.textColor = [ColorManager BlackColor];
    titleLab.font = kFont(16);
    if (section == 0) {
        titleLab.text = @"我的订单";
    }else{
        titleLab.text = @"批发/分享";
    }
    [headerV addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.mas_offset(kWidth(24));
    }];
    
    return headerV;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        [self.view showHUDWithText:@"敬请期待" withYOffSet:0];
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
