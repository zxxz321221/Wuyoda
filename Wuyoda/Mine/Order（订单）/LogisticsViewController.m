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

@interface LogisticsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)LogisticeHeaderView *headerV;

@property (nonatomic , retain)NSArray *logisticeArr;

@end

@implementation LogisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"查看物流"];
    [self.view addSubview:nav];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[LogisticsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([LogisticsTableViewCell class])];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager WhiteColor];
    
    self.headerV = [[LogisticeHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(126))];
    self.tableView.tableHeaderView = self.headerV;
    
    [self.view addSubview:self.tableView];
    
    [self getDataFromServer];
    
}

-(void)getDataFromServer{
    
//    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
//    sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
//    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
//
//    [sessionManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil]];
//    [sessionManager POST:website_getOrderInfo parameters:@{@"orderNum":self.orderNum} headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        }];
    
    [FJNetTool getWithParams:@{@"orderNum":self.orderNum} url:website_getOrderInfo loading:YES success:^(id responseObject) {
        
        LogisticsModel *model = [LogisticsModel mj_objectWithKeyValues:responseObject];
        if ([model.success isEqualToString:@"1"]) {
            self.headerV.model = model;
            self.logisticeArr = [LogisticsModel mj_objectArrayWithKeyValuesArray:responseObject[@"trackingList"]];
            [self.tableView reloadData];
        }
            
        } failure:^(NSError *error) {
            
        }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LogisticsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LogisticsTableViewCell class])];
    if (!cell) {
        cell = [[LogisticsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([LogisticsTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = [self.logisticeArr objectAtIndex:indexPath.row];
    
    return cell;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.logisticeArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return kWidth(60);
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
