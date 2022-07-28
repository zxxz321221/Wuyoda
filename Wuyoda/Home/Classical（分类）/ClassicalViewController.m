//
//  ClassicalViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2022/5/24.
//

#import "ClassicalViewController.h"
#import "ClassicalTableViewCell.h"
#import "ClassicalCollectionHeaderView.h"
#import "ClassicalCollectionViewCell.h"
#import "ClassicalModel.h"
#import "ClassicalGoodsModel.h"
#import "SearchViewController.h"
#import "ClassicalProductListViewController.h"

@interface ClassicalViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , retain)UITableView *tableV;
@property (nonatomic , retain)UICollectionView *collectionV;

@property (nonatomic , retain)NSMutableArray *classifyArr;
@property (nonatomic , retain)NSMutableArray *goodsArr;

@end

@implementation ClassicalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"分类"];
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
    
    
    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, kWidth(10), kWidth(100), kScreenHeight-kHeight_NavBar-kWidth(30)) style:UITableViewStyleGrouped];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.backgroundColor = [ColorManager WhiteColor];
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableV.showsVerticalScrollIndicator = NO;
    [self.tableV registerClass:[ClassicalTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ClassicalTableViewCell class])];
    [bgView addSubview:self.tableV];
    
    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
    fl.itemSize = CGSizeMake(kWidth(50), kWidth(75));
    fl.sectionInset = UIEdgeInsetsMake(kWidth(20), kWidth(10), kWidth(20), kWidth(20));
    fl.minimumLineSpacing = kWidth(20);
    
    
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(kWidth(100), kWidth(10), kScreenWidth-kWidth(100), kScreenHeight-kHeight_NavBar-kWidth(30)) collectionViewLayout:fl];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    self.collectionV.backgroundColor = [ColorManager WhiteColor];
    self.collectionV.showsVerticalScrollIndicator = NO;
    [self.collectionV registerClass:[ClassicalCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ClassicalCollectionViewCell class])];
    [self.collectionV registerClass:[ClassicalCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"classicalCollectionHeader"];
    [bgView addSubview:self.collectionV];
    
    [self getClassifyFromServer];
    
}

-(void)getClassifyFromServer{
    [FJNetTool postWithParams:@{} url:Classify_index loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        NSLog(@"classify:%@",responseObject);
        if ([baseModel.code isEqualToString:CODE0]) {
            self.classifyArr = [ClassicalModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.tableV reloadData];
            [self.tableV selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
            [self getClassifyGoodsFromServer:self.classifyArr.firstObject];
            
        }
    } failure:^(NSError *error) {
            
    }];
}

-(void)getClassifyGoodsFromServer:(ClassicalModel *)model{
    NSDictionary *dic = @{@"uid":model.uid};
    
    [FJNetTool postWithParams:dic url:Classify_cat_goods loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        NSLog(@"classifyGoods:%@",responseObject);
        if ([baseModel.code isEqualToString:CODE0]) {
            self.goodsArr = [ClassicalGoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.collectionV reloadData];
        }
            
    } failure:^(NSError *error) {
        
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.classifyArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ClassicalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ClassicalTableViewCell class]) forIndexPath:indexPath];
    if (!cell) {
        cell = [[ClassicalTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ClassicalTableViewCell class])];
    }
    
    cell.model = [self.classifyArr objectAtIndex:indexPath.row];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kWidth(50);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self getClassifyGoodsFromServer:[self.classifyArr objectAtIndex:indexPath.row]];
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ClassicalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ClassicalCollectionViewCell class]) forIndexPath:indexPath];
    ClassicalGoodsModel *model = [self.goodsArr objectAtIndex:indexPath.section];
    
    NSArray *sectionGoodsArr = [ClassicalGoodsModel mj_objectArrayWithKeyValuesArray:model.category_list];
    cell.model = [sectionGoodsArr objectAtIndex:indexPath.row];
    
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.goodsArr.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    ClassicalGoodsModel *model = [self.goodsArr objectAtIndex:section];
    return model.category_list.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ClassicalGoodsModel *sectionModel = [self.goodsArr objectAtIndex:indexPath.section];
    
    NSArray *sectionGoodsArr = [ClassicalGoodsModel mj_objectArrayWithKeyValuesArray:sectionModel.category_list];
    ClassicalGoodsModel *model = [sectionGoodsArr objectAtIndex:indexPath.row];
    
    ClassicalProductListViewController *vc = [[ClassicalProductListViewController alloc]init];
    vc.uid = model.uid;
    [self.navigationController pushViewController:vc animated:YES];
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseIdentifier;
    // header
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        reuseIdentifier = @"classicalCollectionHeader";
        ClassicalCollectionHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        view.model = [self.goodsArr objectAtIndex:indexPath.section];

        return view;
        
    }
    return nil;
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kWidth(275), kWidth(36));
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
