//
//  SearchViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2022/5/24.
//

#import "SearchViewController.h"
#import "SearchNavigationView.h"
#import "SearchCollectionViewCell.h"
#import "SearchCollectionHeaderView.h"
#import "SearchCollectionViewFlowLayout.h"
#import "TWProductListViewController.h"
#import "SearchModel.h"

@interface SearchViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>

@property (nonatomic , retain)UIView *bgView;
@property (nonatomic , retain)UICollectionView *collectionV;
@property (nonatomic , retain)SearchCollectionViewFlowLayout *fl;
@property (nonatomic , retain)NSArray *hotArr;
@property (nonatomic , retain)NSMutableArray *histotyArr;

@end

@implementation SearchViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getHotWordFromServer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SearchNavigationView *nav = [[SearchNavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar)];
    nav.searchField.delegate = self;
    nav.type = @"1";
    [self.view addSubview:nav];
    
    self.view.backgroundColor = [ColorManager ColorF2F2F2];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar+kWidth(20), kScreenWidth, kScreenHeight-kHeight_NavBar-kWidth(20))];
    bgView.backgroundColor = [ColorManager WhiteColor];
    self.bgView = bgView;
    [self.view addSubview:bgView];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(kWidth(10), kWidth(10))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame =  bgView.bounds;
    maskLayer.path = maskPath.CGPath;
    bgView.layer.mask = maskLayer;
    
    
//    self.hotArr = @[@"牛排",@"进口牛奶",@"牛排",@"进口牛奶",@"牛排",@"进口牛奶",@"五花肉",@"保健品",@"牛排",@"进口牛奶",@"牛排",@"鲜牛奶"];
//
//    self.histotyArr = @[@"100",@"101",@"102",@"103",@"104",@"105",@"106",@"107",@"108",@"109"];
    
    
    [self createCollectionV];
    //[self getHotWordFromServer];
    
}

-(void)createCollectionV{
    if (self.collectionV) {
        [self.collectionV removeFromSuperview];
    }
    self.fl = [[SearchCollectionViewFlowLayout alloc]init];
    self.fl.sectionInset = UIEdgeInsetsMake(kWidth(20), kWidth(20), 0, kWidth(20));
    self.fl.headerReferenceSize = CGSizeMake(kScreenWidth, kWidth(35));
    self.fl.hotArr = self.hotArr;
    self.fl.historyArr = self.histotyArr;
    
    self.collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kWidth(10), kScreenWidth, kScreenHeight-kHeight_NavBar-kWidth(30)) collectionViewLayout:self.fl];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    [self.collectionV registerClass:[SearchCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([SearchCollectionViewCell class])];
    [self.collectionV registerClass:[SearchCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"searchCollectionHeader"];
    [self.bgView addSubview:self.collectionV];
    
}

-(void)getHotWordFromServer{
    NSDictionary *dic = @{};
    
    [FJNetTool postWithParams:dic url:Classify_hot_word loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        NSLog(@"hotWord:%@",responseObject);
        if ([baseModel.code isEqualToString:CODE0]) {
            self.hotArr = [SearchModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            if ([CommonManager isLogin:self isPush:NO]) {
                [self getHistotyFromServer];
            }else{
                [self createCollectionV];
            }
            
        }
    } failure:^(NSError *error) {
            
    }];
}

-(void)getHistotyFromServer{
    NSDictionary *dic = @{@"api_token":[RegisterModel getUserInfoModel].user_token,@"m_uid":[UserInfoModel getUserInfoModel].uid};
    
    [FJNetTool postWithParams:dic url:Classify_history loading:NO success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        NSLog(@"history:%@",responseObject);
        if ([baseModel.code isEqualToString:CODE0]) {
            self.histotyArr = [[SearchModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]] mutableCopy];
            
            [self createCollectionV];
        }
    } failure:^(NSError *error) {
            
    }];
}

-(void)deleteHistorySearchFromServer{
    NSDictionary *dic = @{@"api_token":[RegisterModel getUserInfoModel].user_token,@"m_uid":[UserInfoModel getUserInfoModel].uid};
    [FJNetTool postWithParams:dic url:Classify_history_del loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        NSLog(@"history:%@",responseObject);
        if ([baseModel.code isEqualToString:CODE0]) {
            [self.histotyArr removeAllObjects];
            self.fl.historyArr = self.histotyArr;
            [self.collectionV reloadData];
        }
    } failure:^(NSError *error) {
            
    }];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return self.hotArr.count;
    }else{
        return self.histotyArr.count;
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SearchCollectionViewCell class]) forIndexPath:indexPath];
    if (indexPath.section == 0) {
        SearchModel *model = [self.hotArr objectAtIndex:indexPath.row];
        cell.titleLab.text = model.name;
    }else{
        SearchModel *model = [self.histotyArr objectAtIndex:indexPath.row];
        cell.titleLab.text = model.search;
    }
   
    
    
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseIdentifier;
    // header
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        reuseIdentifier = @"searchCollectionHeader";
        SearchCollectionHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        if (indexPath.section == 0) {
            view.titleLab.text = @"热门搜索";
            view.delBtn.hidden = YES;
        }else{
            view.titleLab.text = @"搜索历史";
            view.delBtn.hidden = !self.histotyArr.count;
            [view.delBtn addTarget:self action:@selector(deleteHistorySearchFromServer) forControlEvents:UIControlEventTouchUpInside];
        }

        return view;
        
    }
    return nil;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TWProductListViewController *vc = [[TWProductListViewController alloc]init];
    vc.type = @"1";
    if (indexPath.section == 0) {
        SearchModel *model = [self.hotArr objectAtIndex:indexPath.row];
        vc.searchStr = model.name;
    }else{
        SearchModel *model = [self.histotyArr objectAtIndex:indexPath.row];
        vc.searchStr = model.search;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length) {
        TWProductListViewController *vc = [[TWProductListViewController alloc]init];
        vc.type = @"1";
        vc.searchStr = textField.text;
        [self.navigationController pushViewController:vc animated:YES];
        return YES;
    }
    return NO;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    return CGSizeMake(kScreenWidth, kWidth(35));
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
