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
    [self.view addSubview:nav];
    
    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
    fl.itemSize = CGSizeMake(kWidth(161), kWidth(210));
    fl.sectionInset = UIEdgeInsetsMake(kWidth(23), kWidth(20), kWidth(24), kWidth(20));
    fl.minimumLineSpacing = kWidth(24);
    //赵祥
    
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea) collectionViewLayout:fl];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    self.collectionV.backgroundColor = [ColorManager WhiteColor];
    [self.collectionV registerClass:[HomeSpecialCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([HomeSpecialCollectionViewCell class])];
    __weak typeof (self) weakSelf = self;
    self.collectionV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getDataFromServer:YES];
    }];
    self.collectionV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf getDataFromServer:NO];
    }];
    [self getDataFromServer:YES];
    [self.view addSubview:self.collectionV];
}

-(void)getDataFromServer:(BOOL)isRefresh{
    if (isRefresh) {
        self.page = 1;
    }
    NSString *urlStr = Store_thsp;
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:[NSString stringWithFormat:@"%ld",self.page] forKey:@"page"];
    [dic setObject:@"10" forKey:@"limit"];
    [dic setObject:[RegisterModel getUserInfoModel].user_token forKey:@"api_token"];
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

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeSpecialCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomeSpecialCollectionViewCell class]) forIndexPath:indexPath];
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
