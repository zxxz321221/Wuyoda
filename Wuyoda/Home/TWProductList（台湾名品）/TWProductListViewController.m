//
//  TWProductListViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/17.
//

#import "TWProductListViewController.h"
#import "TWProductListSearchNavView.h"
#import "TWProductListHeaderView.h"
#import "TWProductListTableViewCell.h"
#import "HomeModel.h"
#import "ProductDetailViewController.h"
#import "TWProductConditionView.h"


@interface TWProductListViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate,selectTWProductConditionDelegate>

@property (nonatomic , retain)UITableView *tableView;
@property (nonatomic , retain)TWProductListHeaderView *tableHeaderV;
@property (nonatomic , retain)TWProductListSearchNavView *searchNav;

@property (nonatomic , retain)NSMutableArray *goodsArr;

@property (nonatomic , assign)NSInteger page;

@property (nonatomic , copy)NSString *cityStr;

@property (nonatomic , copy)NSString *typeStr;

@property (nonatomic , copy)NSString *priceStr;

@property (nonatomic , copy)NSString *selectType;

@property (nonatomic , retain)TWProductConditionView *conditionView;

@end

@implementation TWProductListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createNav];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea) style:UITableViewStyleGrouped];
    if ([self.type isEqualToString:@"1"]) {
        self.tableView.frame = CGRectMake(0, kHeight_StatusBar+kWidth(78), kScreenWidth, kScreenHeight-kHeight_StatusBar-kWidth(78-kHeight_SafeArea));
    }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[TWProductListTableViewCell class] forCellReuseIdentifier:NSStringFromClass([TWProductListTableViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager WhiteColor];
    
    //self.tableHeaderV = [[TWProductListHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(120))];
    self.tableHeaderV = [[TWProductListHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(60))];
    [self.tableHeaderV.addressBtn addTarget:self action:@selector(selectTypeClicekd:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableHeaderV.typeBtn addTarget:self action:@selector(selectTypeClicekd:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableHeaderV.priceBtn addTarget:self action:@selector(selectTypeClicekd:) forControlEvents:UIControlEventTouchUpInside];
//    self.tableHeaderV.allCityArr = self.allCityArr;
//    self.tableHeaderV.delegate = self;
    self.tableHeaderV.type = self.type;
    self.tableView.tableHeaderView = self.tableHeaderV;
    
    __weak typeof (self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getDataFromServer:YES];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf getDataFromServer:NO];
    }];
    
    
    [self.view addSubview:self.tableView];
    
    self.conditionView = [[TWProductConditionView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar)];
    if ([self.type isEqualToString:@"1"]) {
        self.conditionView.frame = CGRectMake(0, kHeight_NavBar+kWidth(36), kScreenWidth, kScreenHeight-kHeight_NavBar-kWidth(36));
    }
    self.conditionView.delegate = self;
    self.conditionView.hidden = YES;
    [self.view addSubview:self.conditionView];
    
    //[self.view addSubview:self.tableHeaderV.tableView];
    
}

-(void)selectTypeClicekd:(UIButton *)sender{
//    sender.selected = !sender.isSelected;
    if (sender == self.tableHeaderV.addressBtn) {
        self.selectType = @"0";
        self.conditionView.dataArr = self.allCityArr;
    }
    if (sender == self.tableHeaderV.typeBtn) {
        self.selectType = @"1";
        self.conditionView.dataArr = @[@"台湾名品",@"宝岛礼盒",@"特惠商品"];

    }
    if (sender == self.tableHeaderV.priceBtn) {
        self.selectType = @"2";
        self.conditionView.dataArr = @[@"由低到高",@"由高到低"];

    }
    
    [self.conditionView show];
    //self.tableView.hidden = !sender.isSelected;
}

-(void)selectCondition:(NSString *)condition{
    if ([self.selectType isEqualToString:@"0"]) {
        self.cityStr = condition;
        [self.tableHeaderV.addressBtn setTitle:condition forState:UIControlStateNormal];
    }else if ([self.selectType isEqualToString:@"1"]){
        self.typeStr = condition;
        [self.tableHeaderV.typeBtn setTitle:condition forState:UIControlStateNormal];
    }
    else if ([self.selectType isEqualToString:@"2"]){
        [self.tableHeaderV.priceBtn setTitle:condition forState:UIControlStateNormal];
        if ([condition isEqualToString:@"由低到高"]) {
            self.priceStr = @"1";
        }else{
            self.priceStr = @"0";
        }
    }
    [self.conditionView close];
    [self getDataFromServer:YES];
}


-(void)createNav{
    if ([self.type isEqualToString:@"1"]) {
        self.searchNav = [[TWProductListSearchNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_StatusBar+kWidth(78))];
        self.searchNav.searField.text = self.searchStr;
        self.searchNav.searField.delegate = self;
        [self.searchNav.addressBtn setTitle:self.currentCity forState:UIControlStateNormal];
        [self getDataFromServer:YES];
        [self.view addSubview:self.searchNav];
    }else if ([self.type isEqualToString:@"2"]){
        FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"台湾名品"];
        [self getDataFromServer:YES];
        [self.view addSubview:nav];
    }else{
        FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"宝岛礼盒"];
        [self getDataFromServer:YES];
        [self.view addSubview:nav];
    }
}

//-(void)changeSearchCity:(NSString *)city{
//    self.cityStr = city;
//    [self getDataFromServer:YES];
//}
//-(void)changeSearchTitle:(NSString *)title{
//    self.typeStr = title;
//    [self getDataFromServer:YES];
//}
//-(void)changeSearchPrice:(NSString *)price{
//    self.priceStr = price;
//    [self getDataFromServer:YES];
//}

-(void)getDataFromServer:(BOOL)isRefresh{
    if (isRefresh) {
        self.page = 1;
    }
    NSString *urlStr = @"";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[NSString stringWithFormat:@"%ld",self.page] forKey:@"page"];
    [dic setValue:@"10" forKey:@"limit"];
    [dic setValue:[RegisterModel getUserInfoModel].user_token forKey:@"api_token"];
    if ([self.type isEqualToString:@"1"]) {
        [dic setValue:self.searchNav.searField.text forKey:@"goods_name"];
        urlStr = Store_search;
        if (self.cityStr.length || self.typeStr.length || self.priceStr.length) {
            urlStr = Store_search_list;
            [dic setValue:self.cityStr forKey:@"city"];
            [dic setValue:self.typeStr forKey:@"title"];
            [dic setValue:self.priceStr forKey:@"price"];
        }
    }
    else if ([self.type isEqualToString:@"2"]) {
        urlStr = Store_twmp;
    }else if ([self.type isEqualToString:@"3"]){
        urlStr = Store_bdlh;
    }
    
    
    [FJNetTool postWithParams:dic url:urlStr loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            self.page++;

            NSArray *arr = [HomeShopModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
          
            if (isRefresh) {
                self.goodsArr = arr.mutableCopy;
                
            }else {
                [self.goodsArr addObjectsFromArray:arr];
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.conditionView.origin.y < kScreenHeight) {
        [self.conditionView close];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TWProductListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TWProductListTableViewCell class]) forIndexPath:indexPath];
    if (!cell) {
        cell = [[TWProductListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TWProductListTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = [self.goodsArr objectAtIndex:indexPath.row];
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.goodsArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kWidth(308);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kWidth(46);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(46))];
    headerV.backgroundColor = [ColorManager WhiteColor];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"300优质推荐商品";
    titleLab.textColor = [ColorManager BlackColor];
    titleLab.font = kFont(24);
    [headerV addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.mas_offset(0);
    }];
    
    return headerV;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeShopModel *model = [self.goodsArr objectAtIndex:indexPath.row];
    ProductDetailViewController *vc = [[ProductDetailViewController alloc]init];
    vc.uid = model.uid;
    vc.supplier_id = model.supplier_id;
    [self.navigationController pushViewController:vc animated:YES];
    [self.conditionView close];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self getDataFromServer:YES];
    return YES;
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
