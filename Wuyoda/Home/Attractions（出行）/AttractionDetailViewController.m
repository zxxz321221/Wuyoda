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

@interface AttractionDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , retain)UITableView *tableView;
@property (nonatomic , retain)AttractionDetailHeaderView *tableHeaderV;

@property (nonatomic , retain)CWStarRateView *recommendStar;
@property (nonatomic , retain)UILabel *recommendLab;
@property (nonatomic , retain)UIButton *likeBtn;

@end

@implementation AttractionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kHeight_SafeArea-kWidth(96)) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    [self.tableView registerClass:[AttractionDetailIntroTableViewCell class] forCellReuseIdentifier:NSStringFromClass([AttractionDetailIntroTableViewCell class])];
    [self.tableView registerClass:[AttractionDetailRecommendTableViewCell class] forCellReuseIdentifier:NSStringFromClass([AttractionDetailRecommendTableViewCell class])];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager WhiteColor];
    self.tableHeaderV = [[AttractionDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(470))];
    self.tableHeaderV.attractionName = self.attractionName;
    self.tableView.tableHeaderView = self.tableHeaderV;
    
    [self.view addSubview:self.tableView];
    
    UIView *bottomV = [[UIView alloc]init];
    bottomV.backgroundColor = [ColorManager WhiteColor];
    [self.view addSubview:bottomV];
    [bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.width.equalTo(self.view);
        make.height.mas_offset(kWidth(96)+kHeight_SafeArea);
    }];
    
    self.recommendStar = [[CWStarRateView alloc]initWithFrame:CGRectMake(kWidth(20), kWidth(30), kWidth(80), kWidth(15)) numberOfStars:5];
    self.recommendStar.scorePercent = 0.8;
    [bottomV addSubview:self.recommendStar];
    
    self.recommendLab = [[UILabel alloc]init];
    self.recommendLab.text = @"98%客人推荐";
    self.recommendLab.textColor = [ColorManager Color555555];
    self.recommendLab.font = kFont(12);
    [bottomV addSubview:self.recommendLab];
    [self.recommendLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.equalTo(self.recommendStar.mas_bottom).mas_offset(kWidth(2));
    }];
    
    self.likeBtn = [[UIButton alloc]init];
    [self.likeBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [self.likeBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    self.likeBtn.titleLabel.font = kFont(14);
    self.likeBtn.backgroundColor = [ColorManager ColorD8001B];
    self.likeBtn.layer.cornerRadius = kWidth(5);
    [self.likeBtn addTarget:self action:@selector(likeAttractionClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bottomV addSubview:self.likeBtn];
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kWidth(24));
        make.right.mas_offset(kWidth(-22));
        make.width.mas_offset(kWidth(120));
        make.height.mas_offset(kWidth(40));
    }];
    
    
}

-(void)likeAttractionClicked:(UIButton *)sender{
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        AttractionDetailIntroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AttractionDetailIntroTableViewCell class]) forIndexPath:indexPath];
        if (!cell) {
            cell = [[AttractionDetailIntroTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([AttractionDetailIntroTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.attractionName = self.attractionName;
        
        return cell;
    }
    else {
        AttractionDetailRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AttractionDetailRecommendTableViewCell class]) forIndexPath:indexPath];
        if (!cell) {
            cell = [[AttractionDetailRecommendTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([AttractionDetailRecommendTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if ([self.attractionName isEqualToString:@"金獅湖風景區"]) {
            return kWidth(200);
        }
        if ([self.attractionName isEqualToString:@"夜市文化"]) {
            return kWidth(450);
        }
        if ([self.attractionName isEqualToString:@"旗津海鲜"]) {
            return kWidth(250);
        }
        return kWidth(550);
    }else{
        return kWidth(194)*2;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

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
        titleLab.text = @"其他景点";
    }
    return headerV;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    return [UIView new];
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
