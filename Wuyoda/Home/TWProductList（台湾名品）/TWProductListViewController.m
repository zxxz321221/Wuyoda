//
//  TWProductListViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/17.
//

#import "TWProductListViewController.h"
#import "TWProductListSearchNavView.h"
#import "TWProductListHeaderView.h"
#import "TWProductListNormalTitleView.h"
#import "TWProductListTableViewCell.h"
#import "HomeModel.h"
#import "ProductDetailViewController.h"
#import "TWProductConditionView.h"
#import "SearchNavigationView.h"
#import "HomeSpecialNewCollectionViewCell.h"
#import "SearchViewController.h"

@interface TWProductListViewController ()<UITextFieldDelegate,UIScrollViewDelegate,selectTWProductConditionDelegate,UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic , retain)UICollectionView *collectionV;
@property (nonatomic , retain)TWProductListHeaderView *headerV;
@property (nonatomic , retain)SearchNavigationView *searchNav;

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
    
    self.view.backgroundColor = [ColorManager ColorF2F2F2];
    
//    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea) style:UITableViewStyleGrouped];
//    if ([self.type isEqualToString:@"1"]) {
//        self.tableView.frame = CGRectMake(0, kHeight_StatusBar+kWidth(78), kScreenWidth, kScreenHeight-kHeight_StatusBar-kWidth(78-kHeight_SafeArea));
//    }
//
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    [self.tableView registerClass:[TWProductListTableViewCell class] forCellReuseIdentifier:NSStringFromClass([TWProductListTableViewCell class])];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.backgroundColor = [ColorManager WhiteColor];
//
//    //self.tableHeaderV = [[TWProductListHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(120))];
//
//
////    __weak typeof (self) weakSelf = self;
////    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
////        [weakSelf getDataFromServer:YES];
////    }];
////    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
////        [weakSelf getDataFromServer:NO];
////    }];
//
//
//    [self.view addSubview:self.tableView];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar+kWidth(20), kScreenWidth, kScreenHeight-kHeight_NavBar-kWidth(20))];
    bgView.backgroundColor = [ColorManager WhiteColor];
    [self.view addSubview:bgView];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(kWidth(10), kWidth(10))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame =  bgView.bounds;
    maskLayer.path = maskPath.CGPath;
    bgView.layer.mask = maskLayer;
    
    
    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
    fl.itemSize = CGSizeMake(kWidth(160), kWidth(240));
    fl.sectionInset = UIEdgeInsetsMake(kWidth(10), kWidth(20), kWidth(24), kWidth(20));
    fl.minimumLineSpacing = kWidth(24);
    
    
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kWidth(60)+kWidth(10), kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea-kWidth(60)-kWidth(30)) collectionViewLayout:fl];
    if ([self.type isEqualToString:@"1"]) {
        self.headerV = [[TWProductListHeaderView alloc]initWithFrame:CGRectMake(0, kWidth(10), kScreenWidth, kWidth(60))];
        [self.headerV.addressBtn addTarget:self action:@selector(selectTypeClicekd:) forControlEvents:UIControlEventTouchUpInside];
        [self.headerV.typeBtn addTarget:self action:@selector(selectTypeClicekd:) forControlEvents:UIControlEventTouchUpInside];
        [self.headerV.priceBtn addTarget:self action:@selector(selectTypeClicekd:) forControlEvents:UIControlEventTouchUpInside];
    //    self.tableHeaderV.allCityArr = self.allCityArr;
    //    self.tableHeaderV.delegate = self;
        [bgView addSubview:self.headerV];
    }else{
        TWProductListNormalTitleView *titleV = [[TWProductListNormalTitleView alloc]initWithFrame:CGRectMake(0, kWidth(10), kScreenWidth, kWidth(60))];
        [bgView addSubview:titleV];
    }
    
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    self.collectionV.backgroundColor = [ColorManager WhiteColor];
    [self.collectionV registerClass:[HomeSpecialNewCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([HomeSpecialNewCollectionViewCell class])];
    [bgView addSubview:self.collectionV];
    
    __weak typeof (self) weakSelf = self;
    self.collectionV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getDataFromServer:YES];
    }];
    self.collectionV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf getDataFromServer:NO];
    }];
    
    
    self.conditionView = [[TWProductConditionView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar)];
//    if ([self.type isEqualToString:@"1"]) {
//        self.conditionView.frame = CGRectMake(0, kHeight_NavBar+kWidth(36), kScreenWidth, kScreenHeight-kHeight_NavBar-kWidth(36));
//    }
    self.conditionView.delegate = self;
    self.conditionView.hidden = YES;
    [self.view addSubview:self.conditionView];
    
    //[self.view addSubview:self.tableHeaderV.tableView];
    
}

-(void)selectTypeClicekd:(UIButton *)sender{
//    sender.selected = !sender.isSelected;
    if (sender == self.headerV.addressBtn) {
        self.selectType = @"0";
        self.conditionView.dataArr = [[NSUserDefaults standardUserDefaults]objectForKey:@"allCity"];
    }
    if (sender == self.headerV.typeBtn) {
        self.selectType = @"1";
        self.conditionView.dataArr = @[@"人气美食",@"特色商品",@"特惠商品"];

    }
    if (sender == self.headerV.priceBtn) {
        self.selectType = @"2";
        self.conditionView.dataArr = @[@"由低到高",@"由高到低"];

    }
    
    [self.conditionView show];
    //self.tableView.hidden = !sender.isSelected;
}

-(void)selectCondition:(NSString *)condition Index:(nonnull NSString *)index{
    if ([self.selectType isEqualToString:@"0"]) {
        self.cityStr = condition;
        [self.headerV.addressBtn setTitle:[NSString stringWithFormat:@"产地:%@",condition] forState:UIControlStateNormal];
    }else if ([self.selectType isEqualToString:@"1"]){
        self.typeStr = index;
        [self.headerV.typeBtn setTitle:condition forState:UIControlStateNormal];
    }
    else if ([self.selectType isEqualToString:@"2"]){
        [self.headerV.priceBtn setTitle:condition forState:UIControlStateNormal];
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
        self.searchNav = [[SearchNavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar)];
        self.searchNav.type = @"2";
        self.searchNav.searchField.text = self.searchStr;
        self.searchNav.searchField.delegate = self;
        [self getDataFromServer:YES];
        [self.view addSubview:self.searchNav];
    }else{
        FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"人气美食"];
        [self getDataFromServer:YES];
        [self.view addSubview:nav];
        nav.backgroundColor = [ColorManager ColorF2F2F2];
        if ([self.type isEqualToString:@"3"]){
            [nav changeTitle:@"特色商品"];
        }
        
        UIButton *searchBtn = [[UIButton alloc]init];
        [searchBtn setImage:kGetImage(@"首页搜索") forState:UIControlStateNormal];
        [searchBtn addTarget:self action:@selector(searchClicked) forControlEvents:UIControlEventTouchUpInside];
        [nav addSubview:searchBtn];
        [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(kWidth(-10));
            make.right.mas_offset(kWidth(-60));
            make.width.height.mas_offset(kWidth(18));
        }];
        
        UIButton *shopCartBtn = [[UIButton alloc]init];
        [shopCartBtn setImage:kGetImage(@"首页顶部购物车") forState:UIControlStateNormal];
        [shopCartBtn addTarget:self action:@selector(shopCartClicked) forControlEvents:UIControlEventTouchUpInside];
        [nav addSubview:shopCartBtn];
        [shopCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(searchBtn);
            make.right.mas_offset(kWidth(-20));
            make.width.height.mas_offset(kWidth(20));
        }];
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
    if ([self.type isEqualToString:@"1"]) {
        [dic setValue:self.searchNav.searchField.text forKey:@"goods_name"];
        if ([CommonManager isLogin:self isPush:NO]) {
            [dic setValue:[UserInfoModel getUserInfoModel].uid forKey:@"m_uid"];
            [dic setValue:[RegisterModel getUserInfoModel].user_token forKey:@"api_token"];
        }
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
    
    NSLog(@"dic:%@",dic);
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
                [self.collectionV.mj_header endRefreshing];
                [self.collectionV.mj_footer endRefreshing];

            }else {
                if (arr.count == 0) {
                    [self.collectionV.mj_footer setState:MJRefreshStateNoMoreData];
                }else {
                    [self.collectionV.mj_footer endRefreshing];
                }
            }
            [self.collectionV reloadData];
        }else {
            [self.collectionV reloadData];
            [self.collectionV.mj_header endRefreshing];
            [self.collectionV.mj_footer endRefreshing];
        }
    } failure:^(NSError *error) {
        [self.collectionV.mj_header endRefreshing];
        [self.collectionV.mj_footer endRefreshing];
    }];
}

-(void)searchClicked{
    SearchViewController *vc = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)shopCartClicked{
    if ([CommonManager isLogin:self isPush:YES]) {
        [self.tabBarController setSelectedIndex:2];
        [self.navigationController popToViewController:self.navigationController.viewControllers.firstObject animated:NO];
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.conditionView.origin.y < kScreenHeight) {
        [self.conditionView close];
    }
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeSpecialNewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomeSpecialNewCollectionViewCell class]) forIndexPath:indexPath];
    
    //cell.imgName = [NSString stringWithFormat:@"home_special_good%ld",indexPath.row+1];
    cell.model = [self.goodsArr objectAtIndex:indexPath.row];
    
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.goodsArr.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeShopModel *model = [self.goodsArr objectAtIndex:indexPath.row];
    ProductDetailViewController *vc = [[ProductDetailViewController alloc]init];
    vc.uid = model.uid;
    vc.supplier_id = model.supplier_id;
    [self.navigationController pushViewController:vc animated:YES];
    [self.conditionView close];
}

//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    TWProductListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TWProductListTableViewCell class]) forIndexPath:indexPath];
//    if (!cell) {
//        cell = [[TWProductListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TWProductListTableViewCell class])];
//    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//    cell.model = [self.goodsArr objectAtIndex:indexPath.row];
//
//    return cell;
//}
//
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.goodsArr.count;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return kWidth(308);
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return kWidth(46);
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.001;
//}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(46))];
//    headerV.backgroundColor = [ColorManager WhiteColor];
//
//    UILabel *titleLab = [[UILabel alloc]init];
//    titleLab.text = @"300优质推荐商品";
//    titleLab.textColor = [ColorManager BlackColor];
//    titleLab.font = kFont(24);
//    [headerV addSubview:titleLab];
//    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(kWidth(20));
//        make.top.mas_offset(0);
//    }];
//
//    return headerV;
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    return [UIView new];
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    HomeShopModel *model = [self.goodsArr objectAtIndex:indexPath.row];
//    ProductDetailViewController *vc = [[ProductDetailViewController alloc]init];
//    vc.uid = model.uid;
//    vc.supplier_id = model.supplier_id;
//    [self.navigationController pushViewController:vc animated:YES];
//    [self.conditionView close];
//}


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
