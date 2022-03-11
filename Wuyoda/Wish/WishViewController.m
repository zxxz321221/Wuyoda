//
//  WishViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/9.
//

#import "WishViewController.h"
#import "WishListTableViewCell.h"
#import "WishAttractionViewController.h"
#import "WishModel.h"
#import "WishBottomView.h"
#import "FootprintViewController.h"
#import "ProductDetailViewController.h"
#import "HomeModel.h"

@interface WishViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , retain)UILabel *addressNumLab;

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)NSMutableArray *wishArr;

@property (nonatomic , assign)BOOL isEdit;

@property (nonatomic , retain)WishBottomView *bottomV;

@end

@implementation WishViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getDataFromServer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"心愿单";
    titleLab.textColor = [ColorManager BlackColor];
    titleLab.font = kFont(28);
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.mas_offset(kHeight_StatusBar + kWidth(66));
    }];
    
    UIView *myAddressV = [[UIView alloc]init];
    myAddressV.layer.cornerRadius = kWidth(10);
    myAddressV.layer.borderColor = [ColorManager ColorF2F2F2].CGColor;
    myAddressV.layer.borderWidth = kWidth(1);
    [self.view addSubview:myAddressV];
    [myAddressV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.equalTo(titleLab.mas_bottom).mas_offset(kWidth(23));
        make.width.mas_offset(kWidth(160));
        make.height.mas_offset(kWidth(83));
    }];
    
    UIImageView *addressImgV = [[UIImageView alloc]initWithImage:kGetImage(@"我的地点")];
    [myAddressV addSubview:addressImgV];
    [addressImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(15));
        make.centerY.equalTo(myAddressV);
        make.width.mas_offset(kWidth(37));
        make.height.mas_offset(kWidth(32));
    }];
    UILabel *addressTitleLab = [[UILabel alloc]init];
    addressTitleLab.text = @"我的地点";
    addressTitleLab.textColor = [ColorManager BlackColor];
    addressTitleLab.font = kFont(16);
    [myAddressV addSubview:addressTitleLab];
    [addressTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addressImgV.mas_right).mas_offset(kWidth(10));
        make.top.mas_offset(kWidth(18));
    }];
    UIButton *addressBtn = [[UIButton alloc]init];
    [addressBtn addTarget:self action:@selector(toMyWishAttractionClicked:) forControlEvents:UIControlEventTouchUpInside];
    [myAddressV addSubview:addressBtn];
    [addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.height.equalTo(myAddressV);
    }];
    
    self.addressNumLab = [[UILabel alloc]init];
    self.addressNumLab.text = @"共1个";
    self.addressNumLab.textColor = [ColorManager Color7F7F7F];
    self.addressNumLab.font = kFont(12);
    [myAddressV addSubview:self.addressNumLab];
    [self.addressNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addressTitleLab);
        make.top.equalTo(addressTitleLab.mas_bottom).mas_offset(kWidth(7));
    }];
    
    
    UIView *myHistoryV = [[UIView alloc]init];
    myHistoryV.layer.cornerRadius = kWidth(10);
    myHistoryV.layer.borderColor = [ColorManager ColorF2F2F2].CGColor;
    myHistoryV.layer.borderWidth = kWidth(1);
    [self.view addSubview:myHistoryV];
    [myHistoryV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-20));
        make.top.equalTo(titleLab.mas_bottom).mas_offset(kWidth(23));
        make.width.mas_offset(kWidth(160));
        make.height.mas_offset(kWidth(83));
    }];
    
    UIImageView *historyImgV = [[UIImageView alloc]initWithImage:kGetImage(@"历史足迹")];
    [myHistoryV addSubview:historyImgV];
    [historyImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(15));
        make.centerY.equalTo(myHistoryV);
        make.width.mas_offset(kWidth(37));
        make.height.mas_offset(kWidth(32));
    }];
    UILabel *historyTitleLab = [[UILabel alloc]init];
    historyTitleLab.text = @"历史足迹";
    historyTitleLab.textColor = [ColorManager BlackColor];
    historyTitleLab.font = kFont(16);
    [myHistoryV addSubview:historyTitleLab];
    [historyTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(historyImgV.mas_right).mas_offset(kWidth(10));
        make.top.mas_offset(kWidth(18));
    }];
    
    UIButton *historyBtn = [[UIButton alloc]init];
    [historyBtn addTarget:self action:@selector(toMyFootPrintClicked:) forControlEvents:UIControlEventTouchUpInside];
    [myHistoryV addSubview:historyBtn];
    [historyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.height.equalTo(myHistoryV);
    }];
    
    UILabel *historyGoods = [[UILabel alloc]init];
    historyGoods.text = @"最近浏览的商品";
    historyGoods.textColor = [ColorManager Color7F7F7F];
    historyGoods.font = kFont(12);
    [myHistoryV addSubview:historyGoods];
    [historyGoods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(historyTitleLab);
        make.top.equalTo(historyTitleLab.mas_bottom).mas_offset(kWidth(7));
    }];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[WishListTableViewCell class] forCellReuseIdentifier:NSStringFromClass([WishListTableViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager WhiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.bottom.equalTo(self.view);
        make.top.equalTo(myAddressV.mas_bottom).mas_offset(kWidth(20));
    }];
    
    self.bottomV = [[WishBottomView alloc]init];
    self.bottomV.backgroundColor = [ColorManager WhiteColor];
    self.bottomV.hidden = YES;
    [self.bottomV.selectBtn addTarget:self action:@selector(selectedAllClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomV.deleteBtn addTarget:self action:@selector(deleteGoodsClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.bottomV];
    [self.bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.width.equalTo(self.view);
        make.height.mas_offset(kWidth(60));
    }];
}

-(void)getDataFromServer{
    
    NSDictionary *dic = @{@"m_uid":[UserInfoModel getUserInfoModel].uid,@"api_token":[RegisterModel getUserInfoModel].user_token};
    
    [FJNetTool postWithParams:dic url:Special_favorites loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            self.wishArr = [WishModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            self.isEdit = NO;
            self.bottomV.hidden = YES;
            [self.tableView reloadData];
        }else{
            [self.view showHUDWithText:baseModel.msg withYOffSet:0];
        }
    } failure:^(NSError *error) {
            
    }];
}

-(void)selectedAllClicked:(UIButton *)sender{
    sender.selected = !sender.isSelected;
    
    for (int i = 0; i<self.wishArr.count; i++) {
        WishModel *model = [self.wishArr objectAtIndex:i];
        if (sender.isSelected) {
            model.isSelect = @"1";
        }else{
            model.isSelect = @"0";
        }
        [self.wishArr replaceObjectAtIndex:i withObject:model];
    }
    
    [self.tableView reloadData];
}

-(void)deleteGoodsClicked:(UIButton *)sender{
    NSString *cartIDStr = @"";
    for (int i = 0; i<self.wishArr.count; i++) {
        WishModel *model = [self.wishArr objectAtIndex:i];
        
        if ([model.isSelect isEqualToString:@"1"]) {
            if (!cartIDStr.length) {
                cartIDStr = model.f_uid;
            }else{
                cartIDStr = [cartIDStr stringByAppendingFormat:@",%@",model.f_uid];
            }
        }
    }
    
    if (cartIDStr.length) {
        NSDictionary *dic = @{@"f_uid":cartIDStr,@"m_uid":[UserInfoModel getUserInfoModel].uid,@"api_token":[RegisterModel getUserInfoModel].user_token};
        [FJNetTool postWithParams:dic url:Special_favorite_del loading:YES success:^(id responseObject) {
            BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
            if ([baseModel.code isEqualToString:CODE0]) {
                [self.view showHUDWithText:baseModel.msg withYOffSet:0];
                [self getDataFromServer];
            }
        } failure:^(NSError *error) {
            
        }];
    }else{
        [self.view showHUDWithText:@"请选择商品" withYOffSet:0];
    }
    
}

-(void)toMyWishAttractionClicked:(id)sender{
    [self.view showHUDWithText:@"敬请期待" withYOffSet:0];
//    WishAttractionViewController *vc = [[WishAttractionViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
}
-(void)toMyFootPrintClicked:(id)sender{
    FootprintViewController *vc = [[FootprintViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)editWishListClicked:(UIButton *)sender{
    self.isEdit = !self.isEdit;
    if (self.isEdit) {
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_offset(kWidth(-60));
        }];
        self.bottomV.hidden = NO;
    }else{
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.view);
        }];
        self.bottomV.hidden = YES;
    }
    [self.tableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WishListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([WishListTableViewCell class]) forIndexPath:indexPath];
    if (!cell) {
        cell = [[WishListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([WishListTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = [self.wishArr objectAtIndex:indexPath.row];
    cell.isEdit = self.isEdit;
    
    //cell.imgName = [NSString stringWithFormat:@"home_special_good%ld",indexPath.row+1];
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.wishArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kWidth(107);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kWidth(33);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(33))];
    headerV.backgroundColor = [ColorManager WhiteColor];
    UILabel *goodsLab = [[UILabel alloc]init];
    goodsLab.text = [NSString stringWithFormat:@"%ld个商品",self.wishArr.count];
    goodsLab.textColor = [ColorManager BlackColor];
    goodsLab.font = kFont(12);
    [headerV addSubview:goodsLab];
    [goodsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.mas_offset(0);
    }];
    
    UIButton *editBtn = [[UIButton alloc]init];
    if (self.isEdit) {
        [editBtn setTitle:@"取消" forState:UIControlStateNormal];
    }else{
        [editBtn setTitle:@"分享/编辑" forState:UIControlStateNormal];
    }
    [editBtn setTitleColor:[ColorManager MainColor] forState:UIControlStateNormal];
    editBtn.titleLabel.font = kFont(14);
    [editBtn addTarget:self action:@selector(editWishListClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headerV addSubview:editBtn];
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-20));
        make.centerY.equalTo(goodsLab);
        make.width.mas_offset(kWidth(70));
        make.height.mas_offset(kWidth(20));
    }];
    
    return headerV;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isEdit) {
        WishModel *model = [self.wishArr objectAtIndex:indexPath.row];
        if ([model.isSelect isEqualToString:@"1"]) {
            model.isSelect = @"0";
        }else{
            model.isSelect = @"1";
        }
        [self.wishArr replaceObjectAtIndex:indexPath.row withObject:model];
        [self.tableView reloadData];
        BOOL isAll = YES;
        for (WishModel *model in self.wishArr) {
            if (![model.isSelect isEqualToString:@"1"]) {
                isAll = NO;
                break;
            }
        }
        if (isAll) {
            self.bottomV.selectBtn.selected = YES;
        }else{
            self.bottomV.selectBtn.selected = NO;
        }
    }else{
        WishModel *wishModel = [self.wishArr objectAtIndex:indexPath.row];
        if ([wishModel.isup isEqualToString:@"1"]) {
            ProductDetailViewController *vc = [[ProductDetailViewController alloc]init];
            vc.uid = wishModel.f_uid;
            vc.supplier_id = wishModel.supplier_id;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [self.view showHUDWithText:@"商品已下架" withYOffSet:0];
        }
        
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
