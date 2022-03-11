//
//  FinishOrderViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/11.
//

#import "FinishOrderViewController.h"
#import "OrderListTableViewCell.h"
#import "OrderInfoViewController.h"
#import "EvaluateViewController.h"
#import "OrderListModel.h"

@interface FinishOrderViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)NSMutableArray *ordersArr;

@property (nonatomic , assign)NSInteger page;


@end

@implementation FinishOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kHeight_NavBar-kWidth(50)) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[OrderListTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderListTableViewCell class])];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager ColorF2F2F2];
    
    __weak typeof (self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getDataFromServer:YES];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf getDataFromServer:NO];
    }];
    
    [self getDataFromServer:YES];
    
    [self.view addSubview:self.tableView];
}

-(void)getDataFromServer:(BOOL)isRefresh{
    if (isRefresh) {
        self.page = 1;
    }
    
    NSDictionary *dic = @{@"m_id":[UserInfoModel getUserInfoModel].member_id,@"status":@"5",@"page":[NSString stringWithFormat:@"%ld",self.page],@"limit":@"10",@"api_token":[RegisterModel getUserInfoModel].user_token};
    
    [FJNetTool postWithParams:dic url:Special_orders loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            self.page++;

            NSArray *arr = [OrderListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
          
            if (isRefresh) {
                self.ordersArr = arr.mutableCopy;
                
            }else {
                [self.ordersArr addObjectsFromArray:arr];
            }
            
            if (isRefresh) {
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];

            }else {
                if (arr.count == 0) {
                    [self.tableView.mj_footer setState:MJRefreshStateNoMoreData];
                }else {
                    [self.tableView.mj_footer endRefreshing];
                }
            }
            [self.tableView reloadData];
        }else {
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

-(void)evaluateClicked:(UIButton *)sender{
    EvaluateViewController *vc = [[EvaluateViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)buyAgainClicked:(UIButton *)sender{
    OrderListModel *model = [self.ordersArr objectAtIndex:sender.tag];
    NSDictionary *dic = @{@"m_id":[UserInfoModel getUserInfoModel].member_id,@"order_id":model.uid,@"addressid":model.addressid,@"api_token":[RegisterModel getUserInfoModel].user_token};
    
    [FJNetTool postWithParams:dic url:Special_buy_again loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        [self.view showHUDWithText:baseModel.msg withYOffSet:0];
        if ([baseModel.code isEqualToString:CODE0]) {
            [self.tabBarController setSelectedIndex:2];
            [self.navigationController popToViewController:self.navigationController.viewControllers.firstObject animated:NO];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderListTableViewCell class])];
    if (!cell) {
        cell = [[OrderListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([OrderListTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    OrderListModel *model = [self.ordersArr objectAtIndex:indexPath.row];
    
    cell.listModel = model;
    
    cell.type = @"3";
    
    cell.finishEvaluateBtn.tag = indexPath.row;
    [cell.finishEvaluateBtn addTarget:self action:@selector(evaluateClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.buyAgainBtn.tag = indexPath.row;
    [cell.buyAgainBtn addTarget:self action:@selector(buyAgainClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.ordersArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    OrderListModel *listModel = [self.ordersArr objectAtIndex:indexPath.row];
    NSDictionary *orderGoodDic = listModel.order_goods;
    NSArray *allKey = orderGoodDic.allKeys;
    
    return kWidth(117)+kWidth(89)*allKey.count;
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
    OrderListModel *model = [self.ordersArr objectAtIndex:indexPath.row];
    OrderInfoViewController *vc = [[OrderInfoViewController alloc]init];
    vc.type = @"3";
    vc.ordersn = model.ordersn;
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
