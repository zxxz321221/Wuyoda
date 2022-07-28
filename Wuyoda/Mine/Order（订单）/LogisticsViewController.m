//
//  LogisticsViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/14.
//

#import "LogisticsViewController.h"
#import "LogisticeHeaderView.h"
#import "LogisticsTableViewCell.h"
#import "LogisticsModel.h"
#import "LogisticsNewModel.h"
#import "LogisticsStateMessageHandle.h"

@interface LogisticsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)LogisticeHeaderView *headerV;

@property (nonatomic , retain)NSArray *logisticeArr;
//1.普通 2.中华邮政
@property (nonatomic , copy)NSString *expressType;

@end

@implementation LogisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"查看物流"];
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
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kWidth(10), kScreenWidth, kScreenHeight-kHeight_NavBar-kWidth(30)) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[LogisticsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([LogisticsTableViewCell class])];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager WhiteColor];
    
    __weak typeof (self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getDataFromServer];
    }];
    
    self.headerV = [[LogisticeHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(126))];
    self.tableView.tableHeaderView = self.headerV;
    
    [bgView addSubview:self.tableView];
    
    [self getDataFromServer];
    
}

-(void)getDataFromServer{
    
    [FJNetTool postWithParams:@{@"ordersn":self.orderNum,@"api_token":[RegisterModel getUserInfoModel].user_token} url:website_getOrderInfo loading:YES success:^(id responseObject) {
        [self.tableView.mj_header endRefreshing];
        NSLog(@"respoooo:%@",responseObject);
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            
            if ([baseModel.msg isEqualToString:@"zhyz"]) {
                self.expressType = @"2";
                LogisticsNewModel *model = [LogisticsNewModel mj_objectWithKeyValues:responseObject[@"data"]];
                if (![model.result isEqualToString:@"0"]) {
                    NSString *infoStr = [LogisticsStateMessageHandle getStateMessage:model.state];
                   
                    CGFloat infoH = [UILabel getHeightByWidth:kWidth(295) title:infoStr font:kFont(16)];
                    self.headerV.model2 = model;
                    self.headerV.frame = CGRectMake(0, 0, kScreenWidth, kWidth(110)+infoH);
                    self.logisticeArr = [LogisticsSubModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
                }else{
                    [self.view showHUDWithText:model.message withYOffSet:0];
                }

            }else{
                self.expressType = @"1";
                LogisticsModel *model = [LogisticsModel mj_objectWithKeyValues:responseObject[@"data"]];
                
                if ([model.success isEqualToString:@"1"]) {
                    NSString *infoStr = model.status;
                   
                    CGFloat infoH = [UILabel getHeightByWidth:kWidth(295) title:infoStr font:kFont(16)];
                   
                    self.headerV.model = model;
                    self.headerV.frame = CGRectMake(0, 0, kScreenWidth, kWidth(110)+infoH);
                    self.logisticeArr = [LogisticsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"trackingList"]];
                }else{
                    [self.view showHUDWithText:model.message withYOffSet:0];
                }
                
                
            }
            self.headerV.expressType = self.expressType;
            [self.tableView reloadData];
        }else{
            [self.view showHUDWithText:baseModel.msg withYOffSet:0];
        }
        
        
        } failure:^(NSError *error) {
            [self.tableView.mj_header endRefreshing];
        }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LogisticsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LogisticsTableViewCell class])];
    if (!cell) {
        cell = [[LogisticsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([LogisticsTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([self.expressType isEqualToString:@"2"]) {
        cell.model2 = [self.logisticeArr objectAtIndex:indexPath.row];
    }else{
        cell.model = [self.logisticeArr objectAtIndex:indexPath.row];
    }
    
    return cell;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.logisticeArr.count) {
        return 1;
    }else{
        return 0;
    }
   
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.logisticeArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([self.expressType isEqualToString:@"2"]) {
        LogisticsSubModel *model = [self.logisticeArr objectAtIndex:indexPath.row];
        NSString *infoStr = model.context;
        
        CGFloat infoH = [UILabel getHeightByWidth:kScreenWidth-kWidth(90) title:infoStr font:kFont(12)];
        
        return kWidth(47)+infoH;
    }else{
        LogisticsModel *model = [self.logisticeArr objectAtIndex:indexPath.row];
        NSString *infoStr = model.action;
        
        CGFloat infoH = [UILabel getHeightByWidth:kScreenWidth-kWidth(90) title:infoStr font:kFont(12)];
        
        return kWidth(47)+infoH;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return kWidth(55);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(55))];
    headerV.backgroundColor = [ColorManager WhiteColor];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"物流跟踪";
    titleLab.textColor = [ColorManager Color333333];
    titleLab.font = kFont(16);
    [headerV addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.mas_offset(kWidth(10));
    }];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, kWidth(35), kScreenWidth, kWidth(0.5))];
    line.backgroundColor = [ColorManager ColorF2F2F2];
    [headerV addSubview:line];

    return headerV;
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
