//
//  PreferentialGoodListViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/17.
//

#import "PreferentialGoodListViewController.h"
#import "HomeSpecialCollectionViewCell.h"
#import "ProductDetailViewController.h"
#import "HomeModel.h"
#import "HomeSpecialNewCollectionViewCell.h"
#import "SearchViewController.h"

@interface PreferentialGoodListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , retain)UICollectionView *collectionV;

@property (nonatomic , retain)NSMutableArray *goodsArr;

@property (nonatomic , assign)NSInteger page;

@end

@implementation PreferentialGoodListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"特惠商品"];
    if (self.cityStr) {
        [nav changeTitle:self.cityStr];
    }
    nav.backgroundColor = [ColorManager ColorF2F2F2];
    [self.view addSubview:nav];
    
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
    
    self.view.backgroundColor = [ColorManager ColorF2F2F2];
    
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
    //赵祥
    
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kWidth(10), kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea-kWidth(30)) collectionViewLayout:fl];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    self.collectionV.backgroundColor = [ColorManager WhiteColor];
    [self.collectionV registerClass:[HomeSpecialNewCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([HomeSpecialNewCollectionViewCell class])];
    __weak typeof (self) weakSelf = self;
    self.collectionV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getDataFromServer:YES];
    }];
    self.collectionV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf getDataFromServer:NO];
    }];
    [self getDataFromServer:YES];
    [bgView addSubview:self.collectionV];
}

-(void)getDataFromServer:(BOOL)isRefresh{
    if (isRefresh) {
        self.page = 1;
    }
    NSString *urlStr = Store_thsp;
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:[NSString stringWithFormat:@"%ld",self.page] forKey:@"page"];
    [dic setObject:@"10" forKey:@"limit"];
    //[dic setObject:[RegisterModel getUserInfoModel].user_token forKey:@"api_token"];
    if (self.cityStr) {
        [dic setObject:self.cityStr forKey:@"belong_city"];
        urlStr = Store_getProductList;
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

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeSpecialCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomeSpecialNewCollectionViewCell class]) forIndexPath:indexPath];
    cell.model = [self.goodsArr objectAtIndex:indexPath.row];
    //cell.imgName = @"home_special_good1";
    
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
