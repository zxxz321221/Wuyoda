//
//  HelperViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/14.
//

#import "HelperViewController.h"
#import "HelperHeaderView.h"
#import "HelperTableViewCell.h"
#import "FJWebViewController.h"

@interface HelperViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)NSArray *titleArr;

@end

@implementation HelperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"获取帮助"];
    nav.backgroundColor = [ColorManager ColorF2F2F2];
    [self.view addSubview:nav];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[HelperTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HelperTableViewCell class])];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager ColorF2F2F2];
    
    HelperHeaderView *headerV = [[HelperHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(157))];
    self.tableView.tableHeaderView = headerV;
    
    [self.view addSubview:self.tableView];
    
    self.titleArr = [[NSArray alloc]initWithObjects:@"购物指南",@"配送说明",@"售后服务", nil];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HelperTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HelperTableViewCell class])];
    if (!cell) {
        cell = [[HelperTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([HelperTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *titleStr = [self.titleArr objectAtIndex:indexPath.row];
    
    [cell.imgV setImage:kGetImage(titleStr)];
    cell.titleLab.text = titleStr;
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

    return kWidth(46);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(46))];
    headerV.backgroundColor = [ColorManager ColorF2F2F2];
    
    UIView *bgV = [[UIView alloc]initWithFrame:CGRectMake(kWidth(10), 0, kWidth(355), kWidth(46))];
    bgV.backgroundColor = [ColorManager WhiteColor];
    [headerV addSubview:bgV];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bgV.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(kWidth(10), kWidth(10))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame =  bgV.bounds;
    maskLayer.path = maskPath.CGPath;
    bgV.layer.mask = maskLayer;
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"常见问题";
    titleLab.textColor = [ColorManager BlackColor];
    titleLab.font = kFont(16);
    [bgV addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(10));
        make.top.mas_offset(kWidth(20));
    }];
    
    return headerV;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FJWebViewController *vc = [[FJWebViewController alloc]init];
    if (indexPath.row == 0) {
        vc.type = 1;
    }
    if (indexPath.row == 1) {
        vc.type = 2;
    }
    if (indexPath.row == 2) {
        vc.type = 3;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
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
