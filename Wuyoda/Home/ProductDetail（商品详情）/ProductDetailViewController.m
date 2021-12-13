//
//  ProductDetailViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/15.
//

#import "ProductDetailViewController.h"
#import "ProductDetailHeaderView.h"
#import "ProductDetailFooterView.h"
#import "ProductDetailIntroduceTableViewCell.h"
#import "ProductDetailEvaluateTableViewCell.h"
#import "ProductDetailServerTableViewCell.h"
#import "ProductDetailRecommendTableViewCell.h"
#import "HomeModel.h"

@interface ProductDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)ProductDetailHeaderView *tableHeaderV;
@property (nonatomic , retain)ProductDetailFooterView *tableFooterV;

@property (nonatomic , retain)NSMutableArray *sectionArr;
@property (nonatomic , retain)NSMutableArray *labArr;

@property (nonatomic , retain)NSMutableArray *shopArr;
@property (nonatomic , retain)HomeShopModel *storeModel;

@end

@implementation ProductDetailViewController

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
    [self.tableView registerClass:[ProductDetailIntroduceTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ProductDetailIntroduceTableViewCell class])];
    [self.tableView registerClass:[ProductDetailEvaluateTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ProductDetailEvaluateTableViewCell class])];
    [self.tableView registerClass:[ProductDetailServerTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ProductDetailServerTableViewCell class])];
    [self.tableView registerClass:[ProductDetailRecommendTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ProductDetailRecommendTableViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager ColorF7F7F7];
    self.tableHeaderV = [[ProductDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(633))];
    self.tableView.tableHeaderView = self.tableHeaderV;
    
    [self.view addSubview:self.tableView];
    
    self.tableFooterV = [[ProductDetailFooterView alloc]initWithFrame:CGRectMake(0, kScreenHeight-kWidth(96)-kHeight_SafeArea, kScreenWidth, kWidth(96)+kHeight_SafeArea)];
    [self.view addSubview:self.tableFooterV];
    
    self.labArr = [[NSMutableArray alloc]initWithObjects:@"5.0评分 · 好极了 · 172条评论",@"超赞商品",@"低价优势",@"安心购",@"传统工艺",@"上选品质",@"礼盒系列", nil];
    self.tableHeaderV.labelArr = self.labArr;
    
    self.sectionArr = [[NSMutableArray alloc]initWithObjects:@"商品介绍",@"客人评价",@"",@"其他好东西", nil];
    
    [self getDataFromServer];
    
}

-(void)getDataFromServer{
    NSDictionary *dic = @{@"uid":self.uid,@"supplier_id":self.supplier_id,@"api_token":[RegisterModel getUserInfoModel].user_token};
    [FJNetTool postWithParams:dic url:Store_Detail loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            self.storeModel = [HomeShopModel mj_objectWithKeyValues:responseObject[@"data"]];
            self.shopArr = [HomeShopModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"qita"]];
            self.tableFooterV.model = self.storeModel;
            self.tableHeaderV.model = self.storeModel;
            [self.tableView reloadData];
        }else{
            [self.view showHUDWithText:baseModel.msg withYOffSet:0];
        }
    } failure:^(NSError *error) {
            
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ProductDetailIntroduceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProductDetailIntroduceTableViewCell class]) forIndexPath:indexPath];
        if (!cell) {
            cell = [[ProductDetailIntroduceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ProductDetailIntroduceTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.storeModel;
        
        return cell;
    }
    else if (indexPath.section == 1) {
        ProductDetailEvaluateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProductDetailEvaluateTableViewCell class]) forIndexPath:indexPath];
        if (!cell) {
            cell = [[ProductDetailEvaluateTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ProductDetailEvaluateTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else if (indexPath.section == 2) {
        ProductDetailServerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProductDetailServerTableViewCell class]) forIndexPath:indexPath];
        if (!cell) {
            cell = [[ProductDetailServerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ProductDetailServerTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        ProductDetailRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProductDetailRecommendTableViewCell class]) forIndexPath:indexPath];
        if (!cell) {
            cell = [[ProductDetailRecommendTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ProductDetailRecommendTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.shopArr = self.shopArr;
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CGFloat textH = [UILabel getHeightByWidth:kWidth(335) title:self.storeModel.goods_advance font:kFont(14)];
        return kWidth(65)+textH;
        //return kWidth(260);
    }else if (indexPath.section == 1){
        return kWidth(196);
    }else if (indexPath.section == 2){
        return kWidth(64);
    }else{
        return kWidth(233)*2+kWidth(24);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        
        return kWidth(10);
    }
    return kWidth(56);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(56))];
    headerV.backgroundColor = [ColorManager ColorF7F7F7];
    if (section == 2) {
        headerV.frame = CGRectMake(0, 0, kScreenWidth, kWidth(10));
    }else{
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, kWidth(10), kScreenWidth, kWidth(46))];
        bgView.backgroundColor = [ColorManager WhiteColor];
        [headerV addSubview:bgView];
        UILabel *titleLab = [[UILabel alloc]init];
        titleLab.text = [self.sectionArr objectAtIndex:section];
        titleLab.textColor = [ColorManager BlackColor];
        titleLab.font = kFont(20);
        [bgView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(kWidth(20));
            make.top.mas_offset(15);
        }];
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
