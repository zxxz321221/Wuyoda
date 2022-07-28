//
//  ClassicalProductListViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2022/6/15.
//

#import "ClassicalProductListViewController.h"
#import "SearchNavigationView.h"
#import "ClassicalProductListHeaderView.h"
#import "TWProductConditionView.h"
#import "HomeSpecialNewCollectionViewCell.h"
#import "ProductDetailViewController.h"

@interface ClassicalProductListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate    ,selectTWProductConditionDelegate>

@property (nonatomic , retain)SearchNavigationView *searchNav;

@property (nonatomic , retain)UIImageView *topImgV;

@property (nonatomic , retain)ClassicalProductListHeaderView *headerV;

@property (nonatomic , retain)UICollectionView *collectionV;

@property (nonatomic , retain)NSMutableArray *goodsArr;

@property (nonatomic , assign)NSInteger page;

@property (nonatomic , copy)NSString *cityStr;

@property (nonatomic , copy)NSString *priceStr;

@property (nonatomic , copy)NSString *selectType;

@property (nonatomic , retain)TWProductConditionView *conditionView;

@end

@implementation ClassicalProductListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.searchNav = [[SearchNavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar)];
    self.searchNav.type = @"2";
    //self.searchNav.searchField.text = self.searchStr;
    self.searchNav.searchField.delegate = self;
    [self.view addSubview:self.searchNav];
    
    self.view.backgroundColor = [ColorManager ColorF2F2F2];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar+kWidth(20), kScreenWidth, kScreenHeight-kHeight_NavBar-kWidth(20))];
    bgView.backgroundColor = [ColorManager WhiteColor];
    [self.view addSubview:bgView];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(kWidth(10), kWidth(10))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame =  bgView.bounds;
    maskLayer.path = maskPath.CGPath;
    bgView.layer.mask = maskLayer;
    
    
    self.topImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(125))];
    //[self.topImgV setImage:kGetImage(@"分类商品顶部")];
    self.topImgV.contentMode = UIViewContentModeScaleAspectFit;
    self.topImgV.layer.cornerRadius = kWidth(10);
    self.topImgV.layer.masksToBounds = YES;
    [bgView addSubview:self.topImgV];
    
    self.headerV = [[ClassicalProductListHeaderView alloc]initWithFrame:CGRectMake(0, kWidth(130), kScreenWidth, kWidth(66))];
    [self.headerV.addressBtn addTarget:self action:@selector(selectTypeClicekd:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerV.priceBtn addTarget:self action:@selector(selectTypeClicekd:) forControlEvents:UIControlEventTouchUpInside];
//    self.tableHeaderV.allCityArr = self.allCityArr;
//    self.tableHeaderV.delegate = self;
    [bgView addSubview:self.headerV];
    
    
    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
    fl.itemSize = CGSizeMake(kWidth(160), kWidth(240));
    fl.sectionInset = UIEdgeInsetsMake(kWidth(10), kWidth(20), kWidth(24), kWidth(20));
    fl.minimumLineSpacing = kWidth(24);
    
    
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kWidth(125)+kWidth(66)+kWidth(5), kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea-kWidth(66)-kWidth(125)-kWidth(5)) collectionViewLayout:fl];
    
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
    
    self.cityStr = @"";
    self.priceStr = @"";
    
    [self getTopImageFromServer];
    [self getDataFromServer:YES];
}

-(void)selectTypeClicekd:(UIButton *)sender{
//    sender.selected = !sender.isSelected;
    if (sender == self.headerV.addressBtn) {
        self.selectType = @"0";
        self.conditionView.dataArr = [[NSUserDefaults standardUserDefaults]objectForKey:@"allCity"];
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
    }else if ([self.selectType isEqualToString:@"2"]){
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

-(void)getTopImageFromServer{
    [FJNetTool postWithParams:@{@"uid":self.uid} url:Classify_cate_file loading:NO success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            NSString *imgUrl = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"category_file2"]];
            if (imgUrl.length && [imgUrl containsString:@"http"]) {
                [self.topImgV sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
            }else{
                self.topImgV.hidden = YES;
                self.headerV.frame = CGRectMake(0, 0, kScreenWidth, kWidth(66));
                self.collectionV.frame = CGRectMake(0, kWidth(66)+kWidth(5), kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea-kWidth(66)-kWidth(5));
            }
        }else{
            self.topImgV.hidden = YES;
            self.headerV.frame = CGRectMake(0, 0, kScreenWidth, kWidth(66));
            self.collectionV.frame = CGRectMake(0, kWidth(66)+kWidth(5), kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea-kWidth(66)-kWidth(5));
        }
        
    } failure:^(NSError *error) {
        self.topImgV.hidden = YES;
        self.headerV.frame = CGRectMake(0, 0, kScreenWidth, kWidth(66));
        self.collectionV.frame = CGRectMake(0, kWidth(66)+kWidth(5), kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea-kWidth(66)-kWidth(5));
    }];
}

-(void)getDataFromServer:(BOOL)isRefresh{
    if (isRefresh) {
        self.page = 1;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[NSString stringWithFormat:@"%ld",self.page] forKey:@"page"];
    [dic setValue:@"10" forKey:@"limit"];
    [dic setValue:self.searchNav.searchField.text forKey:@"goods_name"];
    if ([CommonManager isLogin:self isPush:NO]) {
        [dic setValue:[RegisterModel getUserInfoModel].user_token forKey:@"api_token"];
        [dic setValue:[UserInfoModel getUserInfoModel].uid forKey:@"m_uid"];
    }
    [dic setValue:self.uid forKey:@"uid"];
    [dic setValue:self.cityStr forKey:@"city"];
    [dic setValue:self.priceStr forKey:@"price"];
    
    NSLog(@"dic:%@",dic);
    [FJNetTool postWithParams:dic url:Classify_cat_product loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        NSLog(@"procudts:%@",responseObject);
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
