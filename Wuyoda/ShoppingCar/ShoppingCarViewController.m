//
//  ShoppingCarViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/9.
//

#import "ShoppingCarViewController.h"
#import "ShoppingCarTableViewCell.h"
#import "ShoppingCarBottomView.h"
#import "OrderDetail（订单详情）/OrderCancelViewController.h"
#import "ShoppingCartEmptyView.h"
#import "OrderInfoViewController.h"
#import "OrderDetailViewController.h"
#import "ShopCartModel.h"
#import "BankModel.h"

@interface ShoppingCarViewController ()<UITableViewDelegate,UITableViewDataSource,updateCartNumDelegate>

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)ShoppingCartEmptyView *emptyV;

@property (nonatomic , retain)ShoppingCarBottomView *bottomV;

@property (nonatomic , retain)NSMutableArray *shoppingCartArr;

@property (nonatomic , assign)BOOL isEdit;
//33.邮寄  69.当地
@property (nonatomic , copy)NSString *type;

@property (nonatomic , retain)UIButton *expressBtn;

@property (nonatomic , retain)UIButton *currentBtn;

@end

@implementation ShoppingCarViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self getDataFromServer:self.type];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ColorManager ColorF2F2F2];
    
    self.type = @"33";
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"购物车";
    titleLab.textColor = [ColorManager BlackColor];
    titleLab.font = kFont(28);
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.mas_offset(kHeight_StatusBar + kWidth(66));
    }];
    
    UIButton *editBtn = [[UIButton alloc]init];
    [editBtn setTitle:@"管理" forState:UIControlStateNormal];
    [editBtn setTitle:@"完成" forState:UIControlStateSelected];
    [editBtn setTitleColor:[ColorManager MainColor] forState:UIControlStateNormal];
    editBtn.titleLabel.font = kFont(16);
    [editBtn addTarget:self action:@selector(editShoppintCartClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:editBtn];
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-13));
        make.bottom.equalTo(titleLab);
        make.width.mas_offset(kWidth(35));
        make.height.mas_offset(kWidth(16));
    }];
    
    self.expressBtn = [[UIButton alloc]init];
    [self.expressBtn setTitle:@"官方配送" forState:UIControlStateNormal];
    [self.expressBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
    [self.expressBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateSelected];
    [self.expressBtn setBackgroundImage:kGetImage(@"购物车_左白底") forState:UIControlStateNormal];
    [self.expressBtn setBackgroundImage:kGetImage(@"购物车_左白底") forState:UIControlStateHighlighted];
    [self.expressBtn setBackgroundImage:kGetImage(@"购物车_左渐变") forState:UIControlStateSelected];
    self.expressBtn.titleLabel.font = kFont(20);
    self.expressBtn.selected = YES;
    [self.expressBtn addTarget:self action:@selector(changgeShopCartTypeClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.expressBtn.userInteractionEnabled = NO;
    [self.view addSubview:self.expressBtn];
    [self.expressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(10));
        make.top.equalTo(titleLab.mas_bottom).mas_offset(kWidth(20));
        make.width.mas_offset(kWidth(177.5));
        make.height.mas_offset(kWidth(40));
    }];
    
    self.currentBtn = [[UIButton alloc]init];
    [self.currentBtn setTitle:@"商家配送" forState:UIControlStateNormal];
    [self.currentBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
    [self.currentBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateSelected];
    [self.currentBtn setBackgroundImage:kGetImage(@"购物车_右白底") forState:UIControlStateNormal];
    [self.currentBtn setBackgroundImage:kGetImage(@"购物车_右白底") forState:UIControlStateHighlighted];
    [self.currentBtn setBackgroundImage:kGetImage(@"购物车_右渐变") forState:UIControlStateSelected];
    self.currentBtn.titleLabel.font = kFont(20);
    [self.currentBtn addTarget:self action:@selector(changgeShopCartTypeClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.currentBtn];
    [self.currentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_centerX);
        make.top.equalTo(titleLab.mas_bottom).mas_offset(kWidth(20));
        make.width.mas_offset(kWidth(177.5));
        make.height.mas_offset(kWidth(40));
    }];
    
    self.emptyV = [[ShoppingCartEmptyView alloc]init];
    self.emptyV.backgroundColor = [ColorManager WhiteColor];
    self.emptyV.layer.cornerRadius = kWidth(10);
    [self.view addSubview:self.emptyV];
    [self.emptyV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.view);
        make.top.equalTo(self.expressBtn.mas_bottom).mas_offset(kWidth(10));
        make.bottom.mas_offset(kWidth(10));
    }];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [ColorManager ColorF2F2F2];
    [self.tableView registerClass:[ShoppingCarTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ShoppingCarTableViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.view);
        make.top.equalTo(self.expressBtn.mas_bottom).mas_offset(kWidth(10));
        make.bottom.mas_offset(kWidth(-60));
    }];
    
    __weak typeof (self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getDataFromServer:self.type];
    }];
    
    self.bottomV = [[ShoppingCarBottomView alloc]init];
    self.bottomV.backgroundColor = [ColorManager WhiteColor];
    [self.bottomV.cleaningBtn addTarget:self action:@selector(cleaningShoppingCartClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomV.selectBtn addTarget:self action:@selector(selectedAllClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomV.likeBtn addTarget:self action:@selector(likeGoodsClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomV.deleteBtn addTarget:self action:@selector(deleteGoodsClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.bottomV];
    [self.bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.width.equalTo(self.view);
        make.height.mas_offset(kWidth(60));
    }];
    
    
}

-(void)changgeShopCartTypeClicked:(UIButton *)sender{
    sender.selected = YES;
    NSString *type = @"";
    if (sender == self.expressBtn) {
        self.currentBtn.selected = NO;
        self.currentBtn.userInteractionEnabled = YES;
        self.expressBtn.userInteractionEnabled = NO;
        self.type = @"33";
    }else{
        self.expressBtn.selected = NO;
        self.expressBtn.userInteractionEnabled = YES;
        self.currentBtn.userInteractionEnabled = NO;
        
        self.type = @"69";
    }
    
    [self getDataFromServer:self.type];
    
}

-(void)orderBuyAgainNotification:(NSNotification *)notification{
    NSDictionary *orderDic = notification.object;
    NSDictionary *cartListDic = orderDic[@"data"][@"cart_list"];
    NSMutableArray *cartArr = [ShopCartModel mj_objectArrayWithKeyValuesArray:cartListDic[cartListDic.allKeys.firstObject]];
    OrderDetailViewController *vc = [[OrderDetailViewController alloc]init];
    vc.buyAgainDic = orderDic;
    vc.cartArr = cartArr;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)getDataFromServer:(NSString *)type{
    NSDictionary *dic = @{@"m_id":[UserInfoModel getUserInfoModel].member_id,@"api_token":[RegisterModel getUserInfoModel].user_token,@"ship":self.type};
    
    [FJNetTool postWithParams:dic url:Store_order_cart loading:YES success:^(id responseObject) {
        [self.tableView.mj_header endRefreshing];
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            [self.expressBtn setTitle:[NSString stringWithFormat:@"官方配送(%@)",responseObject[@"data"][@"cart_num"][@"pledge"]] forState:UIControlStateNormal];
            [self.currentBtn setTitle:[NSString stringWithFormat:@"商家配送(%@)",responseObject[@"data"][@"cart_num"][@"zhyz"]] forState:UIControlStateNormal];
            self.shoppingCartArr = [ShopCartModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"cart_list"]];
            if (self.shoppingCartArr.count) {
                self.emptyV.hidden = YES;
                self.tableView.hidden = NO;
                self.bottomV.hidden = NO;
                [self.tableView reloadData];
            }else{
                self.tableView.hidden = YES;
                self.bottomV.hidden = YES;
                self.emptyV.hidden = NO;
            }
            [self handleCartPrice];
            
        }else{
            [self.view showHUDWithText:baseModel.msg withYOffSet:0];
        }
    } failure:^(NSError *error) {
        [self.expressBtn setTitle:@"官方配送(0)" forState:UIControlStateNormal];
        [self.currentBtn setTitle:@"商家配送(0)" forState:UIControlStateNormal];
        [self.shoppingCartArr removeAllObjects];
        [self.tableView reloadData];
        [self handleCartPrice];
        [self.tableView.mj_header endRefreshing];
    }];
}

-(void)selectedAllClicked:(UIButton *)sender{
    sender.selected = !sender.isSelected;
    
    for (int i = 0; i<self.shoppingCartArr.count; i++) {
        ShopCartModel *model = [self.shoppingCartArr objectAtIndex:i];
        if (sender.isSelected) {
            if ([model.isup isEqualToString:@"1"]) {
                model.isSelect = @"1";
            }else{
                model.isSelect = @"0";
            }
            
            model.isEdit = @"1";
        }else{
            model.isSelect = @"0";
            model.isEdit = @"0";
        }
        [self.shoppingCartArr replaceObjectAtIndex:i withObject:model];
    }
    
    [self.tableView reloadData];
    
    [self handleCartPrice];
}

-(void)cleaningShoppingCartClicked{
    NSMutableArray *cartArr = [NSMutableArray array];
    for (int i = 0; i<self.shoppingCartArr.count; i++) {
        ShopCartModel *model = [self.shoppingCartArr objectAtIndex:i];
        if ([model.isSelect isEqualToString:@"1"]) {
            [cartArr addObject:model];
        }
    }
    if (cartArr.count) {
        OrderDetailViewController *vc = [[OrderDetailViewController alloc]init];
        vc.cartArr = cartArr;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self.view showHUDWithText:@"请选择商品" withYOffSet:0];
    }
    
    
//    OrderInfoViewController *vc = [[OrderInfoViewController alloc]init];
//    vc.type = @"1";
//    [self.navigationController pushViewController:vc animated:YES];
}

-(void)likeGoodsClicked:(UIButton *)sender{
    
    NSString *cartIDStr = @"";
    for (int i = 0; i<self.shoppingCartArr.count; i++) {
        ShopCartModel *model = [self.shoppingCartArr objectAtIndex:i];
        
        if ([model.isEdit isEqualToString:@"1"]) {
            if (!cartIDStr.length) {
                cartIDStr = model.uid;
            }else{
                cartIDStr = [cartIDStr stringByAppendingFormat:@",%@",model.uid];
            }
        }
    }
    
    if (cartIDStr.length) {
        NSDictionary *dic = @{@"cart_id":cartIDStr,@"m_uid":[UserInfoModel getUserInfoModel].uid,@"api_token":[RegisterModel getUserInfoModel].user_token};
        [FJNetTool postWithParams:dic url:Special_favorite_add loading:YES success:^(id responseObject) {
            BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
            if ([baseModel.code isEqualToString:CODE0]) {
                [self.view showHUDWithText:baseModel.msg withYOffSet:0];
            }
        } failure:^(NSError *error) {
            
        }];
    }else{
        [self.view showHUDWithText:@"请选择商品" withYOffSet:0];
    }
}

-(void)deleteGoodsClicked:(UIButton *)sender{
    NSString *cartIDStr = @"";
    for (int i = 0; i<self.shoppingCartArr.count; i++) {
        ShopCartModel *model = [self.shoppingCartArr objectAtIndex:i];
        
        if ([model.isEdit isEqualToString:@"1"]) {
            if (!cartIDStr.length) {
                cartIDStr = model.uid;
            }else{
                cartIDStr = [cartIDStr stringByAppendingFormat:@",%@",model.uid];
            }
        }
    }
    
    if (cartIDStr.length) {
        NSDictionary *dic = @{@"cart_id":cartIDStr,@"api_token":[RegisterModel getUserInfoModel].user_token};
        [FJNetTool postWithParams:dic url:Special_cart_del loading:YES success:^(id responseObject) {
            BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
            if ([baseModel.code isEqualToString:CODE0]) {
                [self.view showHUDWithText:baseModel.msg withYOffSet:0];
                [self getDataFromServer:self.type];
            }
        } failure:^(NSError *error) {
            
        }];
    }else{
        [self.view showHUDWithText:@"请选择商品" withYOffSet:0];
    }
    
}

-(void)editShoppintCartClicked:(UIButton *)sender{
    sender.selected = !sender.isSelected;
    self.isEdit = !self.isEdit;
    if (sender.isSelected) {
        self.bottomV.likeBtn.hidden = NO;
        self.bottomV.deleteBtn.hidden = NO;
        self.bottomV.cleaningBtn.hidden = YES;
        self.bottomV.allTitleLab.hidden = YES;
        self.bottomV.priceLab.hidden = YES;
    }else{
        self.bottomV.likeBtn.hidden = YES;
        self.bottomV.deleteBtn.hidden = YES;
        self.bottomV.cleaningBtn.hidden = NO;
        self.bottomV.allTitleLab.hidden = NO;
        self.bottomV.priceLab.hidden = NO;
    }
    [self.tableView reloadData];
    [self handleCartPrice];
}

-(void)updateCartNumwithModel:(ShopCartModel *)model{
    for (int i = 0; i<self.shoppingCartArr.count; i++) {
        ShopCartModel *subModel = [self.shoppingCartArr objectAtIndex:i];
        if ([subModel.uid isEqualToString:model.uid]) {
            [self.shoppingCartArr replaceObjectAtIndex:i withObject:model];
            break;
        }
    }
    [self.tableView reloadData];
    
    [self handleCartPrice];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShoppingCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ShoppingCarTableViewCell class]) forIndexPath:indexPath];
    if (!cell) {
        cell = [[ShoppingCarTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ShoppingCarTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [ColorManager ColorF2F2F2];
    cell.delegate = self;
    cell.model = [self.shoppingCartArr objectAtIndex:indexPath.row];
    cell.isEdit = self.isEdit;
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.shoppingCartArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopCartModel *model = [self.shoppingCartArr objectAtIndex:indexPath.row];
    if ([model.isup isEqualToString:@"1"]) {
        
        if ([model.goods_stock integerValue] < [model.cart_num integerValue]) {
            return kWidth(174);
        }
    }else{
        return kWidth(174);
    }
    
    return kWidth(150);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    ShopCartModel *model = [self.shoppingCartArr objectAtIndex:indexPath.row];
    
    if (self.isEdit) {
        if ([model.isEdit isEqualToString:@"1"]) {
            model.isEdit = @"0";
            model.isSelect = @"0";
            
        }else{
            model.isEdit = @"1";
            if ([model.isup isEqualToString:@"1"]) {
                model.isSelect = @"1";
            }
    
        }
    }else{
        if ([model.isSelect isEqualToString:@"1"]) {
            model.isSelect = @"0";
            model.isEdit = @"0";
            
        }else{
            if ([model.isup isEqualToString:@"1"]) {
                model.isSelect = @"1";
                model.isEdit = @"1";
            }
            
        }
        
    }
    [self handleCartPrice];
    [tableView reloadData];
    
    
}

-(void)handleCartPrice{
    CGFloat allPrice = 0;
    BOOL selectAll = YES;
    for (int i = 0; i<self.shoppingCartArr.count; i++) {
        ShopCartModel *model = [self.shoppingCartArr objectAtIndex:i];
        CGFloat price = [model.total_price_show floatValue];
        NSInteger num = [model.cart_num integerValue];
        if (self.isEdit) {
            if (![model.isEdit isEqualToString:@"1"]) {
                selectAll = NO;
            }
            self.bottomV.selectBtn.selected = selectAll;
        }else{
            if (![model.isSelect isEqualToString:@"1"] && [model.isup isEqualToString:@"1"]) {
                selectAll = NO;
            }else{
                if ([model.isup isEqualToString:@"1"]) {
                    allPrice += (price *num);
                }
                
            }
            self.bottomV.selectBtn.selected = selectAll;
        }
        
    }
    
    self.bottomV.priceLab.text = [NSString stringWithFormat:@"￥%.2f",allPrice];
    
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
