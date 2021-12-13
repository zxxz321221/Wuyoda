//
//  MessageViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/14.
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"
#import "MessageModel.h"
#import "FJWebViewController.h"

@interface MessageViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)NSMutableArray *messagesArr;

@property (nonatomic , assign)NSInteger page;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@""];
    [self.view addSubview:nav];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"收件箱";
    titleLab.textColor = [ColorManager BlackColor];
    titleLab.font = kFont(28);
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.equalTo(nav.mas_bottom).mas_offset(kWidth(15));
    }];
    
    UILabel *subLab = [[UILabel alloc]init];
    subLab.text = @"您没有未读消息";
    subLab.textColor = [ColorManager Color7F7F7F];
    subLab.font = kFont(16);
    [self.view addSubview:subLab];
    [subLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.equalTo(titleLab.mas_bottom).mas_offset(kWidth(15));
    }];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar+kWidth(110), kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea-kWidth(110)) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[MessageTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MessageTableViewCell class])];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager WhiteColor];
    
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
    
    NSDictionary *dic = @{@"page":[NSString stringWithFormat:@"%ld",self.page],@"limit":@"10",@"api_token":[RegisterModel getUserInfoModel].user_token};
    
    [FJNetTool postWithParams:dic url:Store_notice loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            self.page++;

            NSArray *arr = [MessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
          
            if (isRefresh) {
                self.messagesArr = arr.mutableCopy;
                
            }else {
                [self.messagesArr addObjectsFromArray:arr];
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MessageTableViewCell class])];
    if (!cell) {
        cell = [[MessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([MessageTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = [self.messagesArr objectAtIndex:indexPath.row];
    
    return cell;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.messagesArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return kWidth(122);
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
    MessageModel *model = [self.messagesArr objectAtIndex:indexPath.row];
    FJWebViewController *vc = [[FJWebViewController alloc]init];
    vc.type = 0;
    vc.uid = model.uid;
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
