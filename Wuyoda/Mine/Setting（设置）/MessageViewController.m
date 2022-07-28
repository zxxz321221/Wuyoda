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

@property (nonatomic , retain)UIView *bgView;

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)NSMutableArray *messagesArr;

@property (nonatomic , assign)NSInteger page;

@property (nonatomic , retain)UILabel *subLab;

@property (nonatomic , retain)UIView *noLoginV;

@property (nonatomic , retain)UIView *noDataView;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"消息通知"];
    [self.view addSubview:nav];
    
    
    nav.backgroundColor = [ColorManager ColorF2F2F2];
    [self.view addSubview:nav];
    
    self.view.backgroundColor = [ColorManager ColorF2F2F2];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar+kWidth(20), kScreenWidth, kScreenHeight-kHeight_NavBar-kWidth(20))];
    bgView.backgroundColor = [ColorManager WhiteColor];
    self.bgView = bgView;
    [self.view addSubview:bgView];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(kWidth(10), kWidth(10))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame =  bgView.bounds;
    maskLayer.path = maskPath.CGPath;
    bgView.layer.mask = maskLayer;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kWidth(10), kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea-kWidth(30)) style:UITableViewStyleGrouped];
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
    
    [bgView addSubview:self.tableView];
    
    if ([CommonManager isLogin:self isPush:NO]) {
        [self noDataUI];
        [self getDataFromServer:YES];
    }else{
        self.tableView .hidden = YES;
        self.subLab.hidden = YES;
        [self noLoginUI];
    }
    
    
}

-(void)noLoginUI{
    self.noLoginV = [[UIView alloc]init];
    self.noLoginV.backgroundColor = [ColorManager WhiteColor];
    [self.bgView addSubview:self.noLoginV];
    [self.noLoginV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).mas_offset(kWidth(10));
        make.left.width.bottom.equalTo(self.view);
    }];
    
    UIImageView *iconImageV = [[UIImageView alloc]initWithImage:kGetImage(@"msg_login")];
    [self.noLoginV addSubview:iconImageV];
    [iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.noLoginV);
        make.top.mas_offset(kWidth(50));
        make.width.height.mas_offset(kWidth(110));
    }];
    
    UIButton *loginBtn = [[UIButton alloc]init];
    [loginBtn setTitle:@"请登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[ColorManager Color333333] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = kFont(14);
    loginBtn.layer.cornerRadius = kWidth(20);
    loginBtn.layer.borderColor = [ColorManager Color999999].CGColor;
    loginBtn.layer.borderWidth = kWidth(1);
    [loginBtn addTarget:self action:@selector(loginClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.noLoginV addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.noLoginV);
        make.top.equalTo(iconImageV.mas_bottom).mas_offset(kWidth(30));
        make.width.mas_offset(kWidth(110));
        make.height.mas_offset(kWidth(40));
    }];
}

-(void)noDataUI{
    self.noDataView = [[UIView alloc]init];
    self.noDataView.backgroundColor = [ColorManager WhiteColor];
    [self.view addSubview:self.noDataView];
    [self.noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).mas_offset(kWidth(10));
        make.left.width.bottom.equalTo(self.bgView);
    }];
    
    UIImageView *noDataImgV = [[UIImageView alloc]initWithImage:kGetImage(@"msg_noData")];
    [self.noDataView addSubview:noDataImgV];
    [noDataImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.noDataView);
        make.top.mas_offset(kWidth(59));
        make.width.mas_offset(kWidth(230));
        make.width.mas_offset(kWidth(197));
    }];
    
    UILabel *noDataLab = [[UILabel alloc]init];
    noDataLab.text = @"还没有消息哦～";
    noDataLab.textColor = [ColorManager Color999999];
    noDataLab.font = kFont(16);
    [self.noDataView addSubview:noDataLab];
    [noDataLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.noDataView);
        make.top.equalTo(noDataImgV.mas_bottom).mas_offset(kWidth(20));
    }];
}

-(void)loginClicked:(id)sender{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messageLogin:) name:@"messageLogin" object:nil];
    [CommonManager isLogin:self isPush:YES];
}

-(void)messageLogin:(NSNotification *)notification{
    [self.noLoginV removeFromSuperview];
    [self getDataFromServer:YES];
}

-(void)getDataFromServer:(BOOL)isRefresh{
    if (isRefresh) {
        self.page = 1;
    }
    
    NSDictionary *dic = @{@"page":[NSString stringWithFormat:@"%ld",self.page],@"limit":@"10"};
    
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
            
            if (self.messagesArr.count) {
                self.tableView.hidden = NO;
                self.subLab.hidden = NO;
                self.noDataView.hidden = YES;
            }else{
                
            }
            self.tableView.hidden = YES;
            self.subLab.hidden = YES;
            self.noDataView.hidden = NO;
            
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
