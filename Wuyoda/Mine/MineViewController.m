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
        self.headerV.signLab.text = [NSString stringWithFormat:@"今天是Wuyoda陪伴你的第%@天",userInfo.days];
        self.headerV.isLogin = YES;
    }else{
        [self.headerV.iconImgV sd_setImageWithURL:[NSURL URLWithString:@""]];
        self.headerV.nameLab.text = @"请登录";
        self.headerV.isLogin = NO;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@""];
    [nav leftBtnHidden:YES];
    nav.backgroundColor = [ColorManager ColorF2F2F2];
    [self.view addSubview:nav];
    
    self.view.backgroundColor = [ColorManager ColorF2F2F2];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_TabBar) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[MineOrderTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MineOrderTableViewCell class])];
    [self.tableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MineTableViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager ColorF2F2F2];
    
    self.headerV = [[MineHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(139))];
    self.tableView.tableHeaderView = self.headerV;
    
    [self.view addSubview:self.tableView];
    
    self.titleArr = @[@"批发商申请",@"分享APP"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timeoutLogin) name:@"changeAccountLoginTimeOut" object:nil];
}

-(void)timeoutLogin{
    [CommonManager isLogin:self isPush:YES];
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
    return 1;
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

    return 0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return [UIView new];
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
