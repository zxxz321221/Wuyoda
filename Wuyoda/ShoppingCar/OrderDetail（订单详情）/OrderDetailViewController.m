//
//  OrderDetailViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/26.
//

#import "OrderDetailViewController.h"
#import "OrderAddressTableViewCell.h"
#import "OrderGoodDetailTableViewCell.h"
#import "OrderDetailInfoTableViewCell.h"
#import "OrderPriceTableViewCell.h"
#import "OrderInvoiceTableViewCell.h"
#import "OrderRemarkTableViewCell.h"
#import "AddressListViewController.h"
#import "OrderDetailBottomView.h"
#import "PayViewController.h"
#import "ShopCartModel.h"
#import "AddressModel.h"
#import "OrderDetailFooterView.h"
#import "OrderModel.h"
#import "AddressModel.h"
#import "OrderExpressView.h"
#import "OrderRemarkView.h"

@interface OrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource,selectAddressDelegate,OrderExpressSelectDelegate,OrderRemarkDelegate>

@property (nonatomic , retain)UITableView *tableView;

//@property (nonatomic , retain)OrderDetailFooterView *footerV;

@property (nonatomic , retain)OrderDetailBottomView *bottomV;

@property (nonatomic , retain)AddressModel *addressModel;

@property (nonatomic , retain)OrderModel *orderModel;

@property (nonatomic , retain)NSDictionary *cartListDic;

@property (nonatomic , retain)NSMutableArray *goodsArr;

@property (nonatomic , retain)NSArray *shipList;
@property (nonatomic , retain)NSDictionary *currentShipDic;
@property (nonatomic , retain)OrderExpressView *expressV;
@property (nonatomic , retain)OrderRemarkView *remarkV;

@property (nonatomic , retain)NSDictionary *allPriceDic;

@property (nonatomic , copy)NSString *remarkStr;

@property (nonatomic , assign)BOOL isFirst;

@end

@implementation OrderDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!self.isFirst) {
        [self getDataFromServer];
        self.buyAgainDic = [NSDictionary new];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.isFirst = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"确认订单"];
    nav.backgroundColor = [ColorManager ColorF2F2F2];
    [self.view addSubview:nav];
    self.isFirst = YES;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea-kWidth(60)) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[OrderAddressTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderAddressTableViewCell class])];
    [self.tableView registerClass:[OrderGoodDetailTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderGoodDetailTableViewCell class])];
    [self.tableView registerClass:[OrderDetailInfoTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderDetailInfoTableViewCell class])];
    [self.tableView registerClass:[OrderPriceTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderPriceTableViewCell class])];
//    [self.tableView registerClass:[OrderInvoiceTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderInvoiceTableViewCell class])];
//    [self.tableView registerClass:[OrderRemarkTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderRemarkTableViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager ColorF2F2F2];
//    self.footerV = [[OrderDetailFooterView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(80))];
//    self.tableView.tableFooterView = self.footerV;
    [self.view addSubview:self.tableView];
    
    self.bottomV = [[OrderDetailBottomView alloc]init];
    [self.bottomV.payBtn addTarget:self action:@selector(payClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.bottomV];
    [self.bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.width.left.equalTo(self.view);
        make.height.mas_offset(kWidth(60)+kHeight_SafeArea);
    }];
    
    self.goodsArr = [[NSMutableArray alloc]init];
    self.remarkStr = @"";
    
    if (self.buyAgainDic) {
        self.addressModel = [AddressModel mj_objectWithKeyValues:self.buyAgainDic[@"data"][@"address"]];
        self.cartListDic = self.buyAgainDic[@"data"][@"cart_list"];
        NSArray *allKey = [self.cartListDic allKeys];
        for (int i = 0; i<allKey.count; i++) {
            NSString *key = [allKey objectAtIndex:i];
            NSArray *goodsArr = [ShopCartModel mj_objectArrayWithKeyValuesArray:self.cartListDic[key]];
            [self.goodsArr addObjectsFromArray:goodsArr];
        }
        
        NSDictionary *cartInfoDic = self.buyAgainDic[@"data"][@"cart_info"];
        self.orderModel = [OrderModel mj_objectWithKeyValues:cartInfoDic[cartInfoDic.allKeys.firstObject]];
        NSDictionary *shipDic = [self.orderModel.yunfei valueForKey:@"ship_list"];
        self.shipList = [shipDic valueForKey:shipDic.allKeys.firstObject];
        self.currentShipDic = nil;
        self.allPriceDic = nil;
        //self.currentShipDic = [self.shipList firstObject];
//            self.footerV.allPriceLab.text = [NSString stringWithFormat:@"%@%@",self.orderModel.money_sign,self.orderModel.total_price];
//            self.footerV.goodAllPriceLab.text = [NSString stringWithFormat:@"%@%@",self.orderModel.money_sign,self.orderModel.total_price];
        self.bottomV.allPriceLab.text = [NSString stringWithFormat:@"￥%.2f",[self.orderModel.total_price floatValue]];
        [self.tableView reloadData];
    }else{
        [self getDataFromServer];
    }
   
}

-(void)getDataFromServer{
    NSString *cartIDStr = @"";
    for (int i = 0; i<self.cartArr.count; i++) {
        ShopCartModel *model = [self.cartArr objectAtIndex:i];
        if (i == 0) {
            cartIDStr = model.uid;
        }else{
            cartIDStr = [cartIDStr stringByAppendingFormat:@",%@",model.uid];
        }
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:cartIDStr,@"cart_id",[RegisterModel getUserInfoModel].user_token,@"api_token",[UserInfoModel getUserInfoModel].member_id,@"m_id", nil];
    if (self.addressModel) {
        [dic setValue:self.addressModel.uid forKey:@"addressid"];
    }
    
    [FJNetTool postWithParams:dic url:Special_confirm_order loading:YES success:^(id responseObject) {
        NSLog(@"jjjjjkjk:%@",responseObject);
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            [self.goodsArr removeAllObjects];
            self.addressModel = [AddressModel mj_objectWithKeyValues:responseObject[@"data"][@"address"]];
            self.cartListDic = responseObject[@"data"][@"cart_list"];
            NSArray *allKey = [self.cartListDic allKeys];
            for (int i = 0; i<allKey.count; i++) {
                NSString *key = [allKey objectAtIndex:i];
                NSArray *goodsArr = [ShopCartModel mj_objectArrayWithKeyValuesArray:self.cartListDic[key]];
                [self.goodsArr addObjectsFromArray:goodsArr];
            }
            
            NSDictionary *cartInfoDic = responseObject[@"data"][@"cart_info"];
            self.orderModel = [OrderModel mj_objectWithKeyValues:cartInfoDic[cartInfoDic.allKeys.firstObject]];
            NSLog(@"yunfei:%@",self.orderModel.yunfei);
            if ([self.orderModel.yunfei isKindOfClass:[NSDictionary class]]) {
                NSDictionary *shipDic = [self.orderModel.yunfei valueForKey:@"ship_list"];
                self.shipList = [shipDic valueForKey:shipDic.allKeys.firstObject];
                [self.bottomV.payBtn setBackgroundImage:kGetImage(@"提交订单") forState:UIControlStateNormal];
                self.bottomV.payBtn.userInteractionEnabled = YES;
            }else{
                [self.bottomV.payBtn setBackgroundImage:nil forState:UIControlStateNormal];
                self.bottomV.payBtn.backgroundColor = [ColorManager Color999999];
                self.bottomV.payBtn.userInteractionEnabled = NO;
            }
            
            self.currentShipDic = nil;
            self.allPriceDic = nil;
            //self.currentShipDic = [self.shipList firstObject];
//            self.footerV.allPriceLab.text = [NSString stringWithFormat:@"%@%@",self.orderModel.money_sign,self.orderModel.total_price];
//            self.footerV.goodAllPriceLab.text = [NSString stringWithFormat:@"%@%@",self.orderModel.money_sign,self.orderModel.total_price];
            self.bottomV.allPriceLab.text = [NSString stringWithFormat:@"￥%.2f",[self.orderModel.total_price floatValue]];
            [self.tableView reloadData];
        }else{
            if ([baseModel.code isEqualToString:@"400"] && [baseModel.msg isEqualToString:@"1"]) {
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addAddressNotification:) name:@"orderAddAddress" object:nil];
                AddressListViewController *vc = [[AddressListViewController alloc]init];
                vc.type = @"order";
                vc.delegate = self;
                [self.navigationController pushViewController:vc animated:YES];
                [self.view showHUDWithText:baseModel.data withYOffSet:0];
            }else{
                [self.view showHUDWithText:baseModel.msg withYOffSet:0];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)getAllPriceFromServer{
    NSDictionary *dic = @{@"ship_uid":self.currentShipDic[@"uid"],@"total_price":self.orderModel.total_price,@"ship_price":self.currentShipDic[@"price"],@"ship_type":self.currentShipDic[@"price_type"],@"api_token":[RegisterModel getUserInfoModel].user_token};
    
    [FJNetTool postWithParams:dic url:Special_order_total loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            self.allPriceDic = responseObject;
            self.bottomV.allPriceLab.text = [NSString stringWithFormat:@"￥%.2f",[responseObject[@"data"] floatValue]];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)addAddressNotification:(NSNotification *)notification{
    self.addressModel = notification.object;
    //[self getDataFromServer];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"orderAddAddress" object:nil];
}

-(void)selectOrderExpress:(NSDictionary *)shipDic{
    self.currentShipDic = shipDic;
    [self.expressV close];
    [self getAllPriceFromServer];
}
-(void)insertOrderRemark:(NSString *)remark{
    self.remarkStr = remark;
    [self.tableView reloadData];
}

-(void)payClicked{
    if (!self.addressModel.uid.length) {
        [self.view showHUDWithText:@"请选择地址" withYOffSet:0];
        return;
    }
    if (!self.currentShipDic) {
        [self.view showHUDWithText:@"请选择快递方式" withYOffSet:0];
        return;
    }
    
    PayViewController *vc = [[PayViewController alloc]init];
    vc.cartListDic = self.cartListDic;
    vc.memo = self.remarkStr;
    vc.fare = self.currentShipDic[@"id"];
    vc.addressid = self.addressModel.uid;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)selectAddress:(AddressModel *)model{
    self.addressModel = model;
    if (model && model.uid) {
        //[self getDataFromServer];
    }else{
        [self.tableView reloadData];
    }
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        OrderAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderAddressTableViewCell class])];
        if (!cell) {
            cell = [[OrderAddressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([OrderAddressTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.addressModel;
        
        return cell;
    }
    else if (indexPath.section == 1){
        OrderGoodDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderGoodDetailTableViewCell class])];
        if (!cell) {
            cell = [[OrderGoodDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([OrderGoodDetailTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = [self.goodsArr objectAtIndex:indexPath.row];
        if (indexPath.row == 0) {
            cell.isfirst = YES;
        }else{
            cell.isfirst = NO;
        }
        
        return cell;
    }
    else if (indexPath.section == 2){
        
        OrderDetailInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailInfoTableViewCell class])];
        if (!cell) {
            cell = [[OrderDetailInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([OrderDetailInfoTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row == 0) {
            cell.isLast = NO;
            cell.titleLab.text = @"运输方式";
            if (self.currentShipDic) {
                cell.infoLab.text = self.currentShipDic[@"name"];
            }else{
                if ([self.orderModel.yunfei isKindOfClass:[NSDictionary class]]) {
                    cell.infoLab.text = @"请选择运输方式";
                }else{
                    cell.infoLab.text = @"无法配送";
                }
                
            }
            cell.infoLab.textColor = [ColorManager Color333333];
        }
        if (indexPath.row == 1) {
            cell.isLast = NO;
            cell.titleLab.text = @"发票";
            cell.infoLab.text = @"不开发票";
            cell.infoLab.textColor = [ColorManager Color999999];
        }
        if (indexPath.row == 2) {
            cell.isLast = YES;
            cell.titleLab.text = @"订单备注";
            if (self.remarkStr.length) {
                cell.infoLab.text = self.remarkStr;
            }else{
                cell.infoLab.text = @"请填写您的要求";
            }
            cell.infoLab.textColor = [ColorManager Color999999];
            
        }
        
        return cell;
    }
    else{
        OrderPriceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderPriceTableViewCell class])];
        if (!cell) {
            cell = [[OrderPriceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([OrderPriceTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        if (indexPath.row == 0) {
            cell.isLast = NO;
            cell.isFirst = YES;
            cell.priceTitleLab.text = @"小计";
            cell.priceLab.text = [NSString stringWithFormat:@"￥%.2f",[self.orderModel.total_price floatValue]];
        }
        else if (indexPath.row == 1) {
            cell.isFirst = NO;
            cell.isLast = NO;
            cell.priceTitleLab.text = @"运费合计";
            if (self.currentShipDic) {
                cell.priceLab.text = [NSString stringWithFormat:@"%@%@",self.currentShipDic[@"price_sign"],self.currentShipDic[@"price"]];
            }else{
                //cell.priceLab.text = [NSString stringWithFormat:@"%@%@",self.orderModel.money_sign,@"0"];
                cell.priceLab.text = @"￥0.00";
            }
        }
        else if (indexPath.row == 2) {
            cell.isFirst = NO;
            cell.isLast = YES;
            cell.priceTitleLab.text = @"合计";
            if (self.allPriceDic) {
                cell.priceLab.text = [NSString stringWithFormat:@"￥%.2f",[self.allPriceDic[@"data"] floatValue]];
            }else{
                cell.priceLab.text = [NSString stringWithFormat:@"￥%.2f",[self.orderModel.total_price floatValue]];
            }
            
        }
        //cell.isFirst = YES;
        return cell;
    }
//    else if (indexPath.section == 3){
//        OrderInvoiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderInvoiceTableViewCell class])];
//        if (!cell) {
//            cell = [[OrderInvoiceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([OrderInvoiceTableViewCell class])];
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//        return cell;
//    }else{
//        OrderRemarkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderRemarkTableViewCell class])];
//        if (!cell) {
//            cell = [[OrderRemarkTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([OrderRemarkTableViewCell class])];
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//        cell.remarkField.text = self.remarkTextF.text;
//        self.remarkTextF = cell.remarkField;
//
//        return cell;
//    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return self.goodsArr.count;
    }
    if (section == 2 || section== 3) {
        return 3;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return kWidth(84);
    }else if (indexPath.section == 1){
        return kWidth(140);
    }
    return kWidth(44);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   
    if (section == 0) {
        return kWidth(10);
    }
    if (section == 2) {
        return 0.001;
    }
    return kWidth(20);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        AddressListViewController *vc = [[AddressListViewController alloc]init];
        vc.addressModel = self.addressModel;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        if ([self.orderModel.yunfei isKindOfClass:[NSDictionary class]]){
            self.expressV = [[OrderExpressView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar)];
            self.expressV.delegate = self;
            self.expressV.shipList = self.shipList;
            [self.view addSubview:self.expressV];
            [self.expressV show];
        }
    }
    if (indexPath.section == 2 && indexPath.row == 2) {
        self.remarkV = [[OrderRemarkView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar)];
        self.remarkV.delegate = self;
        [self.view addSubview:self.remarkV];
        [self.remarkV show];
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
