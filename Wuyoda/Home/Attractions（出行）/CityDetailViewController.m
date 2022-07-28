//
//  CityDetailViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/22.
//

#import "CityDetailViewController.h"
#import "CityDetailHeaderView.h"
#import "CityAttractionTableViewCell.h"
#import "CityHistoryTableViewCell.h"
#import "CityLineRecommendTableViewCell.h"
#import "CityDetailFoodTableViewCell.h"
#import "CityPresentTableViewCell.h"
#import "AttractionsListViewController.h"
#import "AttractionDetailViewController.h"
#import "CityDetailModel.h"
#import "AttractionModel.h"
#import "HomeModel.h"
#import "SearchViewController.h"

@interface CityDetailViewController ()<UITableViewDelegate,UITableViewDataSource ,updateCityHeaderHeightDelegate>

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)CityDetailHeaderView *headerV;

@property (nonatomic , retain)NSArray *sectionArr;

@property (nonatomic , retain)NSArray *customArr;

@property (nonatomic , retain)NSArray *eventArr;

@property (nonatomic , retain)NSArray *tripArr;

@property (nonatomic , retain)NSArray *goodsArr;

@property (nonatomic , retain)NSArray *attractionArr;

@property (nonatomic , retain)CityDetailModel *cityModel;

@end

@implementation CityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:self.title];
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
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kWidth(0), kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea-kWidth(20)) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[CityAttractionTableViewCell class] forCellReuseIdentifier:NSStringFromClass([CityAttractionTableViewCell class])];
    [self.tableView registerClass:[CityHistoryTableViewCell class] forCellReuseIdentifier:NSStringFromClass([CityHistoryTableViewCell class])];
    [self.tableView registerClass:[CityLineRecommendTableViewCell class] forCellReuseIdentifier:NSStringFromClass([CityLineRecommendTableViewCell class])];
    [self.tableView registerClass:[CityDetailFoodTableViewCell class] forCellReuseIdentifier:NSStringFromClass([CityDetailFoodTableViewCell class])];
    [self.tableView registerClass:[CityPresentTableViewCell class] forCellReuseIdentifier:NSStringFromClass([CityPresentTableViewCell class])];
    self.tableView.backgroundColor = [ColorManager WhiteColor];
    
    self.headerV = [[CityDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(560))];
    self.headerV.delegate = self;
    self.tableView.tableHeaderView = self.headerV;
    
    [bgView addSubview:self.tableView];
    
    self.sectionArr = [[NSArray alloc]initWithObjects:@"著名景点",@"历史事件",@"推荐行程",@"民俗美食",@"手办·礼品", nil];
    [self getDataFromServer];
}

-(void)getDataFromServer{
    NSDictionary *dic = @{@"city_id":self.cityID};
    
    [FJNetTool postWithParams:dic url:Store_city_list loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            NSLog(@"cityDetail:%@",responseObject);
            self.cityModel = [CityDetailModel mj_objectWithKeyValues:responseObject[@"data"]];
            self.customArr = [CityCustomModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"custom"]];
            self.eventArr = [CityEventModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"event"]];
            self.tripArr = [CityTripModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"trip"]];
            self.goodsArr = [HomeShopModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"goods_table"]];
            self.attractionArr = [AttractionModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"scenic"]];
            self.headerV.model = self.cityModel;
            
//            CGFloat textH = [UILabel getHeightByWidth:kWidth(335) title:self.cityModel.city_content font:kFont(16)];
//            self.headerV.frame = CGRectMake(0, 0, kScreenWidth, textH+kWidth(195));
            
            [self.tableView reloadData];
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

-(void)updateCityHeaderHeight:(CGFloat)height{
    self.headerV.frame = CGRectMake(0, 0, kScreenWidth, kWidth(208)+height);
    [self.tableView reloadData];
}

-(void)pushAttractionsVC{
    AttractionsListViewController *vc = [[AttractionsListViewController alloc]init];
    vc.cityID = self.cityID;
    [self.navigationController pushViewController:vc animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CityAttractionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CityAttractionTableViewCell class]) forIndexPath:indexPath];
        if (!cell) {
            cell = [[CityAttractionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CityAttractionTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //cell.imgName = [NSString stringWithFormat:@"景点%ld",indexPath.row+1];
        cell.model = [self.attractionArr objectAtIndex:indexPath.row];
        if (indexPath.row == self.attractionArr.count-1) {
            cell.isLast = YES;
        }else{
            cell.isLast = NO;
        }
        
        return cell;
    }else if (indexPath.section == 1){
        CityHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CityHistoryTableViewCell class]) forIndexPath:indexPath];
        if (!cell) {
            cell = [[CityHistoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CityHistoryTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.model = [self.eventArr objectAtIndex:indexPath.row];
        if (indexPath.row == self.eventArr.count-1) {
            cell.isLast = YES;
        }else{
            cell.isLast = NO;
        }
        
        return cell;
    }else if (indexPath.section == 2){
        CityLineRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CityLineRecommendTableViewCell class]) forIndexPath:indexPath];
        if (!cell) {
            cell = [[CityLineRecommendTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CityLineRecommendTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.model = [self.tripArr objectAtIndex:indexPath.row];
        
        if (indexPath.row == self.tripArr.count-1) {
            cell.isLast = YES;
        }else{
            cell.isLast = NO;
        }
        
        return cell;
    }else if (indexPath.section == 3){
        CityDetailFoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CityDetailFoodTableViewCell class]) forIndexPath:indexPath];
        if (!cell) {
            cell = [[CityDetailFoodTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CityDetailFoodTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.model = [self.customArr objectAtIndex:indexPath.row];
        
        if (indexPath.row == self.customArr.count-1) {
            cell.isLast = YES;
        }else{
            cell.isLast = NO;
        }
        
        return cell;
    }else{
        CityPresentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CityPresentTableViewCell class]) forIndexPath:indexPath];
        if (!cell) {
            cell = [[CityPresentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CityPresentTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.goodsArr = self.goodsArr;
        
        return cell;
    }
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.attractionArr.count;
    }else if (section == 1){
        return self.eventArr.count;
    }else if (section == 2){
        return self.tripArr.count;
    }else if (section == 3){
        return self.customArr.count;
    }else{
        return 1;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (!self.attractionArr.count) {
            return 0.001;
        }
        return kWidth(102);
    }else if (indexPath.section == 1){
        if (!self.eventArr.count) {
            return 0.001;
        }
        return kWidth(36);
    }else if (indexPath.section == 2){
        if (!self.tripArr.count) {
            return 0.001;
        }
        CityTripModel *model = [self.tripArr objectAtIndex:indexPath.row];
        CGFloat textH = [UILabel getHeightByWidth:kWidth(343) title:model.trip_content font:kFont(14)];
        return kWidth(50) + textH;
    }else if (indexPath.section == 3){
        if (!self.customArr.count) {
            return 0.001;
        }
        return kWidth(140);
    }else{
        if (!self.goodsArr.count) {
            return 0.001;
        }
        return kWidth(170);
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        if (!self.attractionArr.count) {
            return 0.001;
        }
    }else if (section == 1){
        if (!self.eventArr.count) {
            return 0.001;
        }
    }else if (section == 2){
        if (!self.tripArr.count) {
            return 0.001;
        }
    }else if (section == 3){
        if (!self.customArr.count) {
            return 0.001;
        }
    }else{
        if (!self.goodsArr.count) {
            return 0.001;
        }
    }
    return kWidth(58);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(58))];
    headerV.backgroundColor = [ColorManager ColorF7F7F7];
    UIView *bgV = [[UIView alloc]initWithFrame:CGRectMake(0, kWidth(8), kScreenWidth, kWidth(50))];
    bgV.backgroundColor = [ColorManager WhiteColor];
    [headerV addSubview:bgV];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bgV.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(kWidth(10), kWidth(10))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame =  bgV.bounds;
    maskLayer.path = maskPath.CGPath;
    bgV.layer.mask = maskLayer;
    
    UILabel *titleLab = [[UILabel alloc]init];
    if (section == 0) {
        if (!self.attractionArr.count) {
            return [UIView new];
        }else{
            titleLab.text = [self.sectionArr objectAtIndex:section];
        }
    }else if (section == 1){
        if (!self.eventArr.count) {
            return [UIView new];
        }else{
            titleLab.text = [self.sectionArr objectAtIndex:section];
        }
    }else if (section == 2){
        if (!self.tripArr.count) {
            return [UIView new];
        }else{
            titleLab.text = [self.sectionArr objectAtIndex:section];
        }
    }else if (section == 3){
        if (!self.customArr.count) {
            return [UIView new];
        }else{
            titleLab.text = [self.sectionArr objectAtIndex:section];
        }
    }else{
        if (!self.goodsArr.count) {
            return [UIView new];
        }else{
            titleLab.text = [self.sectionArr objectAtIndex:section];
        }
    }
    
    titleLab.textColor = [ColorManager Color333333];
    titleLab.font = kBoldFont(16);
    [bgV addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kWidth(20));
        make.left.mas_offset(kWidth(16));
    }];
    
    if (section == 0) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushAttractionsVC)];
        [headerV addGestureRecognizer:tap];
        
        UIImageView *moreImgView = [[UIImageView alloc]initWithImage:kGetImage(@"更多")];
        [headerV addSubview:moreImgView];
        [moreImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(kWidth(-15));
            make.centerY.equalTo(titleLab);
            make.width.height.mas_offset(kWidth(16));
        }];
    }
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, kWidth(55), kScreenWidth, kWidth(1))];
    line.backgroundColor = [ColorManager ColorF7F7F7];
    [bgV addSubview:line];
    
    return headerV;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        AttractionDetailViewController *vc = [[AttractionDetailViewController alloc]init];
        AttractionModel *model = [self.attractionArr objectAtIndex:indexPath.row];
        vc.scenic_id = model.uid;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 3) {
//        AttractionDetailViewController *vc = [[AttractionDetailViewController alloc]init];
//        vc.scenic_id = @"";
//        [self.navigationController pushViewController:vc animated:YES];
    }
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
