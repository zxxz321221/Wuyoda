//
//  HomeViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/9.
//

#import "HomeViewController.h"
#import "HomeTableHeaderView.h"
#import "HomeSpecialProductTableViewCell.h"
#import "HomeCultureProductTableViewCell.h"
#import "HomeAttractionsTableViewCell.h"
#import "HomeSearchCityViewController.h"
#import "PreferentialGoodListViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "HomeModel.h"
#import "ClassicalProductListViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,SpecailProductTypeSelectDelegate,CLLocationManagerDelegate>

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)HomeTableHeaderView *tableHeaderV;

@property (nonatomic , retain)NSMutableArray *sectionArr;

@property (nonatomic , retain)NSMutableArray *specialTypeArr;
@property (nonatomic , assign)NSInteger specialTypeIndex;

@property (nonatomic , strong) CLLocationManager* locationManager;
@property (nonatomic , copy) NSString *currentCity;

@property (nonatomic , retain)NSMutableArray *cityArr;
@property (nonatomic , retain)NSMutableArray *specialShopArr;
@property (nonatomic , retain)HomeShopModel *specialTopModel;

@end

@implementation HomeViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (![UserInfoModel getUserInfoModel].token) {
//        LoginViewController *VC = [[LoginViewController alloc] init];
//        FJBaseNavigationController *nav = [[FJBaseNavigationController alloc]initWithRootViewController:VC];
//        nav.modalPresentationStyle = UIModalPresentationFullScreen;
//        [self presentViewController:nav animated:YES completion:nil];
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSString *openStatus = [[NSUserDefaults standardUserDefaults]objectForKey:@"firstOpen"];
    if ([openStatus isEqualToString:@"login"]) {
        NewLoginViewController *VC = [[NewLoginViewController alloc] init];
        FJBaseNavigationController *nav = [[FJBaseNavigationController alloc]initWithRootViewController:VC];
        nav.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:nav animated:YES completion:nil];
    }else if ([openStatus isEqualToString:@"register"]){
        RegisterViewController *VC = [[RegisterViewController alloc] init];
        FJBaseNavigationController *nav = [[FJBaseNavigationController alloc]initWithRootViewController:VC];
        nav.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:nav animated:YES completion:nil];
    }
}

-(void)getLoginStatusFromServer{
    NSDictionary *dic = @{@"api_token":[RegisterModel getUserInfoModel].user_token,@"uid":[UserInfoModel getUserInfoModel].uid};
//    7c558d0a3ab262e12a4427d8113a2a54
    [FJNetTool postWithParams:dic url:Login_login_status loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            if ([baseModel.msg isEqualToString:@"有效"]) {
                NSLog(@"login_statis:%@",responseObject[@"data"]);
                UserInfoModel *userModel = [UserInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
                
                RegisterModel *registerModel = [RegisterModel getUserInfoModel];
                registerModel.user_id = userModel.member_id;
                registerModel.user_token = userModel.token;
                [RegisterModel saveUserInfoModel:registerModel];
                [UserInfoModel saveUserInfoModel:userModel];
                
                [self getDataFromServer];
            }
        }else{
            [self.view showHUDWithText:@"登录状态已过期，请重新登录" withYOffSet:0];
            [UserInfoModel clearUserInfo];
            [[NSUserDefaults standardUserDefaults] setValue:@"logout" forKey:@"firstOpen"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeAccountLoginTimeOut" object:nil];
            
            NewLoginViewController *VC = [[NewLoginViewController alloc] init];
            FJBaseNavigationController *nav = [[FJBaseNavigationController alloc]initWithRootViewController:VC];
            nav.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:nav animated:YES completion:nil];
            //[self getTokenFromServer];
        }
            
    } failure:^(NSError *error) {
            
    }];
    
}

//-(void)getTokenFromServer{
    
//    [FJNetTool postWithParams:@{} url:Login_GetToken loading:YES success:^(id responseObject){
//        NSString *token = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//        registerModel.user_token = token;
//        [RegisterModel saveUserInfoModel:registerModel];
//        [self getDataFromServer];
//    } failure:^(NSError *error) {
//        if (error.code != 1005) {
//            [self getTokenFromServer];
//        }
//
//    }];
////    if (!registerModel.user_token.length) {
////
////    }else{
////        [self getDataFromServer];
////    }
//}

-(void)getHomeStoreFromServer:(HomeCategoryModel *)model{
    NSDictionary *dic = @{@"goods_category":model.uid};
    self.specialTopModel = nil;
    [self.specialShopArr removeAllObjects];
    [FJNetTool postWithParams:dic url:Index_shop loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            
            NSArray *shopArr = [HomeShopModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            for (HomeShopModel *model in shopArr) {
                if ([model.istop isEqualToString:@"1"]) {
                    self.specialTopModel = model;
                }else{
                    [self.specialShopArr addObject:model];
                }
            }
            
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)getHomeCategoryFromServer{
    NSDictionary *dic = @{};
    
    [FJNetTool postWithParams:dic url:Index_category loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            NSLog(@"homeCategory:%@",responseObject);
            self.specialTypeArr = [HomeCategoryModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            
            self.specialTypeIndex = 0;
            [self getHomeStoreFromServer:[self.specialTypeArr objectAtIndex:self.specialTypeIndex]];
        }
    } failure:^(NSError *error) {
        
    }];
}


-(void)getDataFromServer{
    [FJNetTool postWithParams:@{} url:Index_index loading:YES success:^(id responseObject) {
        
        BaseModel *model = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([model.code isEqualToString:CODE0]) {
            
            [self getHomeCategoryFromServer];
            self.cityArr = [[HomeCityModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"recity"]] mutableCopy];
            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"data"][@"city"] forKey:@"allCity"];
            //NSDictionary *shopDic = responseObject[@"data"][@"shop"];
            //NSMutableArray *hotCityArr = [[NSMutableArray alloc]initWithObjects:@"台北市",@"高雄市",@"苗栗县",@"嘉义县",@"台中市" , nil];
            //self.tableHeaderV.hotCityArr = hotCityArr;
            //self.tableHeaderV.allCityArr = responseObject[@"data"][@"city"];
//            self.specialTypeArr = hotCityArr;
            
//            for (int i = 0; i<self.specialTypeArr.count; i++) {
//                NSString *key = [self.specialTypeArr objectAtIndex:i];
//                NSMutableArray *modelArr = [HomeShopModel mj_objectArrayWithKeyValuesArray:shopDic[key]];
//
//                [self.specialShopArr addObject:modelArr];;
//
//            }
            
        }else{
            [self.view showHUDWithText:model.msg withYOffSet:0];
        }
            
    } failure:^(NSError *error) {
            
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([CommonManager isLogin:self isPush:NO]) {
        [self getLoginStatusFromServer];
    }else{
        //[self getTokenFromServer];
        
    }
    [self getDataFromServer];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kHeight_TabBar) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    [self.tableView registerClass:[HomeSpecialProductTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HomeSpecialProductTableViewCell class])];
    [self.tableView registerClass:[HomeCultureProductTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HomeCultureProductTableViewCell class])];
    [self.tableView registerClass:[HomeAttractionsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HomeAttractionsTableViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager WhiteColor];
    self.tableHeaderV = [[HomeTableHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(440))];
    self.tableView.tableHeaderView = self.tableHeaderV;
    
    [self.view addSubview:self.tableView];
    
    [self locate];
    
    //self.sectionArr = [[NSMutableArray alloc]initWithObjects:@{@"title":@"口碑推荐",@"sub":@"台湾名产贴心推荐，低至7折"},@{@"title":@"宝岛特色文创",@"sub":@"文创商品直接销售机会难得"},@{@"title":@"你可能也想去",@"sub":@"发现更多出行灵感"}, nil];
    self.sectionArr = [[NSMutableArray alloc]initWithObjects:@{@"title":@"口碑推荐",@"sub":@"台湾名产贴心推荐，低至7折"},@{@"title":@"你可能也想去",@"sub":@"发现更多出行灵感"}, nil];
    self.specialShopArr = [[NSMutableArray alloc]init];
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeHomdeCity:) name:@"changeHomeCity" object:nil];
//    self.specialTypeArr = [[NSMutableArray alloc]initWithObjects:@"台北市",@"莺歌",@"马祖",@"阿里山",@"基隆",@"台南市",@"高雄市",@"澎湖", nil];
    
//    NSString *openStatus = [[NSUserDefaults standardUserDefaults]objectForKey:@"firstOpen"];
//    if (![openStatus isEqualToString:@"none"]) {
//        NewLoginViewController *VC = [[NewLoginViewController alloc] init];
//        FJBaseNavigationController *nav = [[FJBaseNavigationController alloc]initWithRootViewController:VC];
//        nav.modalPresentationStyle = UIModalPresentationFullScreen;
//        [self presentViewController:nav animated:YES completion:nil];
//    }
    
//    if (![CommonManager isLogin:self isPush:NO]) {
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshHomeData) name:@"reloadHomeData" object:nil];
//    }
}

- (void)locate {
     //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
//        [locationManager requestAlwaysAuthorization];
        //currentCity = [[NSString alloc] init];
        if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                 NSLog(@"requestAlwaysAuthorization");
                 [self.locationManager requestAlwaysAuthorization];
             }
         
             //开始定位，不断调用其代理方法
             [self.locationManager startUpdatingLocation];
    }
    
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"允许\"定位\"提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * ok = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开定位设置
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingsURL];
    }];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:cancel];
    [alertVC addAction:ok];
    [self presentViewController:alertVC animated:YES completion:nil];
    
}
//定位成功
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [self.locationManager stopUpdatingLocation];
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    
      //反编码
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            self.currentCity = placeMark.locality;
            if (!self.currentCity) {
                self.currentCity = @"无法定位当前城市";
            }
            NSLog(@"%@",self.currentCity); //这就是当前的城市
            NSLog(@"%@----%@---%@",placeMark.administrativeArea,placeMark.locality,placeMark.name);//具体地址:  xx市xx区xx街道
            self.tableHeaderV.currentCity = self.currentCity;
            if ([placeMark.country isEqualToString:@"中国"]) {
                if ([placeMark.locality isEqualToString:@"香港特别行政区"] || [placeMark.locality isEqualToString:@"澳门特别行政区"] || [placeMark.administrativeArea isEqualToString:@"台湾省"]) {
                    
                }
            }
        }
        else if (error == nil && placemarks.count == 0) {
            NSLog(@"No location and error return");
        }
        else if (error) {
            NSLog(@"location error: %@ ",error);
        }
  
    }];
}

//-(void)changeHomdeCity:(NSNotification *)notification{
//    NSString *city = notification.object[@"city"];
//    BOOL inArr = [self.specialTypeArr containsObject:city];
//    if (self.specialTypeArr.count == 5) {
//        if (inArr) {
//            self.specialTypeIndex = [self.specialTypeArr indexOfObject:city];
//        }else{
//            [self.specialTypeArr insertObject:city atIndex:0];
//            self.specialTypeIndex = 0;
//        }
//    }else{
//        if (inArr) {
//            self.specialTypeIndex = [self.specialTypeArr indexOfObject:city];
//        }else{
//            [self.specialTypeArr replaceObjectAtIndex:0 withObject:city];
//            self.specialTypeIndex = 0;
//        }
//    }
//    [self getHomeStoreFromServer:city];
//}

-(void)selectSpecailProductType:(NSInteger)index{
    self.specialTypeIndex = index;
    //[self.tableView reloadData];
    [self getHomeStoreFromServer:[self.specialTypeArr objectAtIndex:index]];
}

-(void)showMoreClicked:(UIButton *)sender{
    PreferentialGoodListViewController *vc = [[PreferentialGoodListViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)moreCategoryClicked{
    HomeCategoryModel *model = [self.specialTypeArr objectAtIndex:self.specialTypeIndex];
    ClassicalProductListViewController *vc = [[ClassicalProductListViewController alloc]init];
    vc.uid = model.uid;
    [self.navigationController pushViewController:vc animated:YES];
}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    [self.view endEditing:YES];
//}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HomeSpecialProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeSpecialProductTableViewCell class]) forIndexPath:indexPath];
        if (!cell) {
            cell = [[HomeSpecialProductTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([HomeSpecialProductTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.typeIndex = self.specialTypeIndex;
        cell.typeArr = self.specialTypeArr;
        cell.shopArr = self.specialShopArr;
        cell.topGoodModel = self.specialTopModel;
        cell.delegate = self;
        
        return cell;
    }
//    else if (indexPath.section == 1) {
//        HomeCultureProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeCultureProductTableViewCell class]) forIndexPath:indexPath];
//        if (!cell) {
//            cell = [[HomeCultureProductTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([HomeCultureProductTableViewCell class])];
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//        return cell;
//    }
    else{
        HomeAttractionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeAttractionsTableViewCell class]) forIndexPath:indexPath];
        if (!cell) {
            cell = [[HomeAttractionsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([HomeAttractionsTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.cityArr = self.cityArr;
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CGFloat height = 0;
        if (self.specialTopModel) {
            height += +kWidth(413);
        }
        NSInteger line = self.specialShopArr.count/2;
        if (self.specialShopArr.count%2) {
            line += 1;
        }
        
        height += kWidth(260)*line;
        
        return height + kWidth(70)+kWidth(24)*2;
    }
//    else if (indexPath.section == 1){
//        return kWidth(200);
//    }
    else{
        return kWidth(230);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kWidth(66);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if (section == 0) {
//        return kWidth(68);
//    }
    return 0.0001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(65))];
    headerV.backgroundColor = [ColorManager WhiteColor];
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = [[self.sectionArr objectAtIndex:section] valueForKey:@"title"];
    titleLab.textColor = [ColorManager BlackColor];
    titleLab.font = kFont(20);
    [headerV addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.mas_offset(0);
    }];
    
    if (section == 0) {
        UIButton *moreBtn = [[UIButton alloc]init];
        [moreBtn setTitle:@"更多推荐" forState:UIControlStateNormal];
        [moreBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
        moreBtn.titleLabel.font = kFont(14);
        [moreBtn setImage:kGetImage(@"箭头_深") forState:UIControlStateNormal];
        moreBtn.imageEdgeInsets = UIEdgeInsetsMake(0, kWidth(70), 0, 0);
        moreBtn.titleEdgeInsets = UIEdgeInsetsMake(0, kWidth(-15), 0, 0);
        [moreBtn addTarget:self action:@selector(moreCategoryClicked) forControlEvents:UIControlEventTouchUpInside];
        [headerV addSubview:moreBtn];
        [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(kWidth(-20));
            make.centerY.equalTo(titleLab);
            make.width.mas_offset(kWidth(80));
            make.height.mas_offset(kWidth(16));
        }];
    }
    
    
    UILabel *subLab = [[UILabel alloc]init];
    subLab.text = [[self.sectionArr objectAtIndex:section] valueForKey:@"sub"];
    subLab.textColor = [ColorManager Color7F7F7F];
    subLab.font = kFont(14);
    [headerV addSubview:subLab];
    [subLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.equalTo(titleLab.mas_bottom).mas_offset(4);
    }];
    
    return headerV;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    if (section == 0) {
//        UIView *footerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(68))];
//        footerV.backgroundColor = [ColorManager WhiteColor];
//        UIButton *moreBtn = [[UIButton alloc]init];
//        NSString *titleStr = @"显示更多特惠商品";
////        if (self.specialTypeArr.count) {
////            titleStr = [NSString stringWithFormat:@"显示更多%@特惠商品",[self.specialTypeArr objectAtIndex:self.specialTypeIndex]];
////        }
//        [moreBtn setTitle:titleStr forState:UIControlStateNormal];
//        [moreBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
//        moreBtn.titleLabel.font = kFont(14);
//        moreBtn.layer.cornerRadius = kWidth(5);
//        moreBtn.layer.borderColor = [ColorManager BlackColor].CGColor;
//        moreBtn.layer.borderWidth = 1;
//        [moreBtn addTarget:self action:@selector(showMoreClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [footerV addSubview:moreBtn];
//        [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.centerX.equalTo(footerV);
//            make.width.mas_offset(kWidth(335));
//            make.height.mas_offset(kWidth(36));
//        }];
//        
//        return footerV;
//    }
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
