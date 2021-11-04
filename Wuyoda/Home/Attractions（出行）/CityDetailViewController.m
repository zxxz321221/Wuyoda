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

@interface CityDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)CityDetailHeaderView *headerV;

@property (nonatomic , retain)NSArray *sectionArr;

@end

@implementation CityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@""];
    [self.view addSubview:nav];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea) style:UITableViewStyleGrouped];
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
    self.tableView.tableHeaderView = self.headerV;
    
    [self.view addSubview:self.tableView];
    
    self.sectionArr = [[NSArray alloc]initWithObjects:@"著名景点",@"历史事件",@"推荐行程",@"民俗美食",@"手办·礼品", nil];
}

-(void)pushAttractionsVC{
    AttractionsListViewController *vc = [[AttractionsListViewController alloc]init];
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
        if (indexPath.row == 0) {
            cell.attractionName = @"金獅湖風景區";
        }else{
            cell.attractionName = @"蓮池潭";
        }
        
        return cell;
    }else if (indexPath.section == 1){
        CityHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CityHistoryTableViewCell class]) forIndexPath:indexPath];
        if (!cell) {
            cell = [[CityHistoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CityHistoryTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if (indexPath.section == 2){
        CityLineRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CityLineRecommendTableViewCell class]) forIndexPath:indexPath];
        if (!cell) {
            cell = [[CityLineRecommendTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CityLineRecommendTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if (indexPath.section == 3){
        CityDetailFoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CityDetailFoodTableViewCell class]) forIndexPath:indexPath];
        if (!cell) {
            cell = [[CityDetailFoodTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CityDetailFoodTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row == 0) {
            cell.attractionName = @"夜市文化";
        }else{
            cell.attractionName = @"旗津海鲜";
        }
        
        return cell;
    }else{
        CityPresentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CityPresentTableViewCell class]) forIndexPath:indexPath];
        if (!cell) {
            cell = [[CityPresentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CityPresentTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 0;
    }else if (section == 2){
        return 0;
    }else if (section == 3){
        return 2;
    }else{
        return 1;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return kWidth(102);
    }else if (indexPath.section == 1){
        return kWidth(36);
    }else if (indexPath.section == 2){
        return kWidth(90);
    }else if (indexPath.section == 3){
        return kWidth(100);
    }
    return kWidth(170);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1 || section == 2) {
        return 0.001;
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
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = [self.sectionArr objectAtIndex:section];
    titleLab.textColor = [ColorManager Color333333];
    titleLab.font = kBoldFont(16);
    [bgV addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bgV).mas_offset(kWidth(-10));
        make.left.mas_offset(kWidth(16));
    }];
    
    if (section == 0) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushAttractionsVC)];
        [headerV addGestureRecognizer:tap];
    }
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, kWidth(49), kScreenWidth, kWidth(1))];
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
        if (indexPath.row == 0) {
            vc.attractionName = @"金獅湖風景區";
        }else{
            vc.attractionName = @"蓮池潭";
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 3) {
        AttractionDetailViewController *vc = [[AttractionDetailViewController alloc]init];
        if (indexPath.row == 0) {
            vc.attractionName = @"夜市文化";
        }else{
            vc.attractionName = @"旗津海鲜";
        }
        [self.navigationController pushViewController:vc animated:YES];
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
