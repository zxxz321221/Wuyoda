//
//  VersionViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/8.
//

#import "VersionViewController.h"
#import "VersionTableViewCell.h"
#import "FJWebViewController.h"

@interface VersionViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)NSArray *titleArr;

@end

@implementation VersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"版本"];
    nav.backgroundColor = [ColorManager ColorF2F2F2];
    [self.view addSubview:nav];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[VersionTableViewCell class] forCellReuseIdentifier:NSStringFromClass([VersionTableViewCell class])];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager ColorF2F2F2];
    
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(179))];
    headerV.backgroundColor = [ColorManager WhiteColor];
    UIImageView *logoImgV = [[UIImageView alloc]initWithImage:kGetImage(@"appLogo")];
    [headerV addSubview:logoImgV];
    [logoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(headerV);
        make.width.height.mas_offset(kWidth(100));
    }];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:headerV.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(kWidth(10), kWidth(10))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame =  headerV.bounds;
    maskLayer.path = maskPath.CGPath;
    headerV.layer.mask = maskLayer;
    
    self.tableView.tableHeaderView = headerV;
    [self.view addSubview:self.tableView];
    
    self.titleArr = [[NSArray alloc]initWithObjects:@"版本号",@"隐私政策",@"清除缓存", nil];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VersionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VersionTableViewCell class])];
    if (!cell) {
        cell = [[VersionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([VersionTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleLab.text = [self.titleArr objectAtIndex:indexPath.row];
    if (indexPath.row == 0) {
        cell.versionLab.text = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    }else{
        cell.versionLab.text = @"";
    }
    
    if (indexPath.row == 2) {
        cell.isLast = YES;
    }else{
        cell.isLast = NO;
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
    if (indexPath.row == 1) {
        FJWebViewController *vc = [[FJWebViewController alloc]init];
        vc.url = @"http://www.wuyoda.com.cn/page.php?action=Privacypolicy";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 2) {
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            [self.view showHUDWithText:@"清除缓存成功" withYOffSet:0];
        }];

        [[SDImageCache sharedImageCache] clearMemory];//可有可无
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
