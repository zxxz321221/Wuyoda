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

@end

@implementation ShoppingCarViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self getDataFromServer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ColorManager ColorF2F2F2];
    
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
    [editBtn setTitle:@"取消" forState:UIControlStateSelected];
    [editBtn setTitleColor:[ColorManager Color3399FF] forState:UIControlStateNormal];
    editBtn.titleLabel.font = kFont(16);
    [editBtn addTarget:self action:@selector(editShoppintCartClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:editBtn];
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-13));
        make.bottom.equalTo(titleLab);
        make.width.mas_offset(kWidth(35));
        make.height.mas_offset(kWidth(16));
    }];
    
    self.emptyV = [[ShoppingCartEmptyView alloc]init];
    [self.view addSubview:self.emptyV];
    [self.emptyV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.view);
        make.top.equalTo(titleLab.mas_bottom).mas_offset(kWidth(16));
        make.bottom.mas_offset(kWidth(-60));
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
        make.top.equalTo(titleLab.mas_bottom).mas_offset(kWidth(16));
        make.bottom.mas_offset(kWidth(-60));
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


-(void)getDataFromServer{
    NSDictionary *dic = @{@"m_id":[UserInfoModel getUserInfoModel].member_id,@"api_token":[RegisterModel getUserInfoModel].user_token};
    
    [FJNetTool postWithParams:dic url:Store_order_cart loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
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
            
        }else{
            [self.view showHUDWithText:baseModel.msg withYOffSet:0];
        }
    } failure:^(NSError *error) {
            
    }];
}

-(void)selectedAllClicked:(UIButton *)sender{
    sender.selected = !sender.isSelected;
    
    for (int i = 0; i<self.shoppingCartArr.count; i++) {
        ShopCartModel *model = [self.shoppingCartArr objectAtIndex:i];
        if (sender.isSelected) {
            model.isSelect = @"1";
        }else{
            model.isSelect = @"0";
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
        
        if ([model.isSelect isEqualToString:@"1"]) {
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
        
        if ([model.isSelect isEqualToString:@"1"]) {
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
                [self getDataFromServer];
            }
        } failure:^(NSError *error) {
            
        }];
    }else{
        [self.view showHUDWithText:@"请选择商品" withYOffSet:0];
    }
    
}

-(void)editShoppintCartClicked:(UIButton *)sender{
    sender.selected = !sender.isSelected;
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
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.shoppingCartArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kWidth(157);
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
    if ([model.isSelect isEqualToString:@"1"]) {
        model.isSelect = @"0";
        
    }else{
        model.isSelect = @"1";
    }
    [self.shoppingCartArr replaceObjectAtIndex:indexPath.row withObject:model];
    [tableView reloadData];
    
    [self handleCartPrice];
}

-(void)handleCartPrice{
    CGFloat allPrice = 0;
    BOOL selectAll = YES;
    for (int i = 0; i<self.shoppingCartArr.count; i++) {
        ShopCartModel *model = [self.shoppingCartArr objectAtIndex:i];
        CGFloat price = [model.total_price_show floatValue];
        NSInteger num = [model.cart_num integerValue];
        if (![model.isSelect isEqualToString:@"1"]) {
            selectAll = NO;
        }else{
            allPrice += (price *num);
        }
    }
    
    self.bottomV.priceLab.text = [NSString stringWithFormat:@"￥%.2f",allPrice];
    self.bottomV.selectBtn.selected = selectAll;
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
