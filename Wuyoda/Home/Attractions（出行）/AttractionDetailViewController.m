//
//  AttractionDetailViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/18.
//

#import "AttractionDetailViewController.h"
#import "AttractionDetailHeaderView.h"
#import "AttractionDetailIntroTableViewCell.h"
#import "AttractionDetailRecommendTableViewCell.h"
#import "CWStarRateView.h"
#import "AttractionModel.h"
#import "BannerModel.h"

@interface AttractionDetailViewController ()<UITableViewDelegate,UITableViewDataSource,updateScenicIntroduceDelegate>

@property (nonatomic , retain)UITableView *tableView;
@property (nonatomic , retain)AttractionDetailHeaderView *tableHeaderV;

@property (nonatomic , retain)CWStarRateView *recommendStar;
@property (nonatomic , retain)UILabel *recommendLab;
@property (nonatomic , retain)UIButton *likeBtn;

@property (nonatomic , retain)AttractionModel *model;
@property (nonatomic , retain)NSArray *otherArr;

@property (nonatomic , assign)CGFloat webH;

@end

@implementation AttractionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"景点详情"];
    nav.backgroundColor = [ColorManager ColorF2F2F2];
    [self.view addSubview:nav];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar+kWidth(20), kScreenWidth, kScreenHeight-kHeight_NavBar-kWidth(20))];
    bgView.backgroundColor = [ColorManager WhiteColor];
    [self.view addSubview:bgView];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(kWidth(10), kWidth(10))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame =  bgView.bounds;
    maskLayer.path = maskPath.CGPath;
    bgView.layer.mask = maskLayer;
    
    self.view.backgroundColor = [ColorManager ColorF2F2F2];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kHeight_SafeArea-kHeight_NavBar-kWidth(20)) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[AttractionDetailIntroTableViewCell class] forCellReuseIdentifier:NSStringFromClass([AttractionDetailIntroTableViewCell class])];
    [self.tableView registerClass:[AttractionDetailRecommendTableViewCell class] forCellReuseIdentifier:NSStringFromClass([AttractionDetailRecommendTableViewCell class])];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager WhiteColor];
    //self.tableHeaderV = [[AttractionDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(470))];
    self.tableHeaderV = [[AttractionDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(430))];
    //self.tableHeaderV.attractionName = self.attractionName;
    self.tableView.tableHeaderView = self.tableHeaderV;
    
    [bgView addSubview:self.tableView];
    
//    UIView *bottomV = [[UIView alloc]init];
//    bottomV.backgroundColor = [ColorManager WhiteColor];
//    [self.view addSubview:bottomV];
//    [bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.bottom.width.equalTo(self.view);
//        make.height.mas_offset(kWidth(96)+kHeight_SafeArea);
//    }];
//
//    self.recommendStar = [[CWStarRateView alloc]initWithFrame:CGRectMake(kWidth(20), kWidth(30), kWidth(80), kWidth(15)) numberOfStars:5];
//    self.recommendStar.scorePercent = 0.8;
//    [bottomV addSubview:self.recommendStar];
//
//    self.recommendLab = [[UILabel alloc]init];
//    self.recommendLab.text = @"98%客人推荐";
//    self.recommendLab.textColor = [ColorManager Color555555];
//    self.recommendLab.font = kFont(12);
//    [bottomV addSubview:self.recommendLab];
//    [self.recommendLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(kWidth(20));
//        make.top.equalTo(self.recommendStar.mas_bottom).mas_offset(kWidth(2));
//    }];
//
//    self.likeBtn = [[UIButton alloc]init];
//    [self.likeBtn setTitle:@"收藏" forState:UIControlStateNormal];
//    [self.likeBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
//    self.likeBtn.titleLabel.font = kFont(14);
//    self.likeBtn.backgroundColor = [ColorManager ColorD8001B];
//    self.likeBtn.layer.cornerRadius = kWidth(5);
//    [self.likeBtn addTarget:self action:@selector(likeAttractionClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [bottomV addSubview:self.likeBtn];
//    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_offset(kWidth(24));
//        make.right.mas_offset(kWidth(-22));
//        make.width.mas_offset(kWidth(120));
//        make.height.mas_offset(kWidth(40));
//    }];
    
    [self getDataFromServer];
}

-(void)getDataFromServer{
    NSDictionary *dic = @{@"scenic_id":self.scenic_id};
    
    [FJNetTool postWithParams:dic url:Store_scenic_intro loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            self.model = [AttractionModel mj_objectWithKeyValues:responseObject[@"data"]];
            self.otherArr = [AttractionModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"qita"]];
            self.tableHeaderV.model = self.model;
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)updateScenicInftoduceHeight:(CGFloat)height{
    self.webH = height;
    NSLog(@"webHHHHH:%f",height);
    [self.tableView beginUpdates];
    //[tableview.delegate tableView:tableViewheightForRowAtIndexPath:indexPath];
    [self.tableView endUpdates];

}

-(void)likeAttractionClicked:(UIButton *)sender{
    [self.view showHUDWithText:@"敬请期待" withYOffSet:0];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return self.otherArr.count;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        AttractionDetailIntroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AttractionDetailIntroTableViewCell class]) forIndexPath:indexPath];
        if (!cell) {
            cell = [[AttractionDetailIntroTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([AttractionDetailIntroTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.attractionName = self.attractionName;
        cell.model = self.model;
        cell.delegate = self;
        
        return cell;
    }
    else {
        AttractionDetailRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AttractionDetailRecommendTableViewCell class]) forIndexPath:indexPath];
        if (!cell) {
            cell = [[AttractionDetailRecommendTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([AttractionDetailRecommendTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = [self.otherArr objectAtIndex:indexPath.row];
        
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return kWidth(25)+self.webH;
    }else{
        return kWidth(120);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 1 && !self.otherArr.count) {
        return 0.001;
    }
    return kWidth(56);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(56))];
    headerV.backgroundColor = [ColorManager ColorF7F7F7];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, kWidth(10), kScreenWidth, kWidth(46))];
    bgView.backgroundColor = [ColorManager WhiteColor];
    [headerV addSubview:bgView];
    UILabel *titleLab = [[UILabel alloc]init];
    
    titleLab.textColor = [ColorManager BlackColor];
    titleLab.font = kFont(20);
    [bgView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.mas_offset(15);
    }];
    if (section == 0) {
        titleLab.text = @"景点介绍";
    }else{
        if (self.otherArr.count) {
            titleLab.text = @"其他景点";
        }
    }
    return headerV;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        AttractionModel *model = [self.otherArr objectAtIndex:indexPath.row];
        AttractionDetailViewController *vc = [[AttractionDetailViewController alloc]init];
        vc.scenic_id = model.uid;
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
