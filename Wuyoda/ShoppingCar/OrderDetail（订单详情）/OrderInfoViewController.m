//
//  OrderInfoViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/27.
//

#import "OrderInfoViewController.h"
#import "OrderInfoAddressTableViewCell.h"
//#import "OrderInfoGoodTableViewCell.h"
#import "OrderGoodDetailTableViewCell.h"
#import "OrderPriceTableViewCell.h"
#import "OrderInfoInvoiceTableViewCell.h"
#import "OrderInfoTableViewCell.h"
#import "OrderInfoHeaderView.h"
#import "OrderInfoBottomView.h"
#import "OrderListModel.h"
#import "ChangeOrderAddressViewController.h"
#import "OrderCancelViewController.h"
#import "LogisticsViewController.h"
#import "EvaluateViewController.h"
#import "PayInfoModel.h"
#import "PayInfoViewController.h"
#import "PayModel.h"
#import "PayViewController.h"
#import "ShopCartModel.h"

@interface OrderInfoViewController ()<UITableViewDelegate,UITableViewDataSource,ChangeOrderAddressDelegate>

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)NSArray *infoTitleArr;

@property (nonatomic , retain)OrderInfoHeaderView *headerV;

@property (nonatomic , retain)OrderInfoBottomView *bottomV;

@property (nonatomic , retain)OrderListModel *orderInfoModel;

@property (nonatomic , retain)NSMutableArray *goodsArr;

@property (nonatomic , assign)NSInteger surplusTime;

@property (nonatomic , retain)NSTimer *timer;

@end

@implementation OrderInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"订单详情"];
    nav.backgroundColor = [ColorManager ColorF2F2F2];
    [self.view addSubview:nav];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea-kWidth(48)) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[OrderInfoAddressTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderInfoAddressTableViewCell class])];
    [self.tableView registerClass:[OrderGoodDetailTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderGoodDetailTableViewCell class])];
    [self.tableView registerClass:[OrderPriceTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderPriceTableViewCell class])];
    [self.tableView registerClass:[OrderInfoInvoiceTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderInfoInvoiceTableViewCell class])];
    [self.tableView registerClass:[OrderInfoTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderInfoTableViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager ColorF2F2F2];
    [self.view addSubview:self.tableView];
    [self createBottomView];
    
    self.goodsArr = [[NSMutableArray alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderInfoUpdate) name:@"orderInfoUpdate" object:nil];
    [self getOrderInfoFromServer];
}

-(void)orderInfoUpdate{
    [self getOrderInfoFromServer];
}

-(void)createBottomView{
    self.headerV = [[OrderInfoHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(94))];
    self.headerV.type = self.type;
    self.headerV.ordersn = self.ordersn;
    self.tableView.tableHeaderView = self.headerV;
    if ([self.type isEqualToString:@"1"] || [self.type isEqualToString:@"3"] || [self.type isEqualToString:@"4"] || [self.type isEqualToString:@"5"]) {
        if (self.bottomV) {
            [self.bottomV removeFromSuperview];
        }
        self.bottomV = [[OrderInfoBottomView alloc]initWithFrame:CGRectMake(0, kScreenHeight-kHeight_SafeArea-kWidth(49), kScreenWidth, kWidth(49))];
        [self.bottomV.payBtn addTarget:self action:@selector(payOrderClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomV.addressBtn addTarget:self action:@selector(changeAddressClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomV.cancelBtn addTarget:self action:@selector(cancelOrderClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomV.readLogisticsBtn addTarget:self action:@selector(readLogisticsClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomV.finishEvaluateBtn addTarget:self action:@selector(evaluateClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomV.doneTakeBtn addTarget:self action:@selector(doneTakeClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomV.buyAgainBtn addTarget:self action:@selector(doneTakeClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.bottomV.type = self.type;
        [self.view addSubview:self.bottomV];
        self.tableView.frame = CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea-kWidth(49));
    }else{
        if (self.bottomV) {
            [self.bottomV removeFromSuperview];
        }
        self.tableView.frame = CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea);
    }
}

-(void)getOrderInfoFromServer{
    NSDictionary *dic = @{@"m_id":[UserInfoModel getUserInfoModel].member_id,@"ordersn":self.ordersn,@"api_token":[RegisterModel getUserInfoModel].user_token};
    
    [FJNetTool postWithParams:dic url:Special_orders_list loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
             
            [self.goodsArr removeAllObjects];
            self.orderInfoModel = [OrderListModel mj_objectWithKeyValues:responseObject[@"data"]];
            self.type = self.orderInfoModel.status;
            NSDictionary *goodsDic = self.orderInfoModel.order_goods;
            NSArray *allKey = [goodsDic allKeys];
            for (int i = 0; i<allKey.count; i++) {
                NSString *key = [allKey objectAtIndex:i];
                OrderGoodModel *goodsModel = [OrderGoodModel mj_objectWithKeyValues:goodsDic[key]];
                [self.goodsArr addObject:goodsModel];
            }
            
            if ([self.type isEqualToString:@"1"]) {
                self.surplusTime = self.orderInfoModel.endtime-self.orderInfoModel.time;
                if (self.surplusTime < 0) {
                    self.type = @"2";
                }else{
                    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(surplusPayTime) userInfo:nil repeats:YES];
                    
                }
            }else{
                [self.timer invalidate];
            }
//            if ([self.orderInfoModel.status_code isEqualToString:@"1"]) {
//                self.type = @"1";
//            }
//            else if ([self.orderInfoModel.status_code isEqualToString:@"4"]) {
//                self.type = @"2";
//            }
//            else if ([self.orderInfoModel.status_code isEqualToString:@"5"]) {
//                self.type = @"3";
//            }else{
//                self.type = @"4";
//            }
            [self createBottomView];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)surplusPayTime{
    self.surplusTime -= 1;
    if (self.surplusTime > 0) {
        self.headerV.surplus = self.surplusTime;
    }else{
        [self.timer invalidate];
        [self payTimeOutCancelOrder];
    }
}

-(void)payTimeOutCancelOrder{
    NSDictionary *dic = @{@"m_id":[UserInfoModel getUserInfoModel].member_id,@"uid":self.orderInfoModel.uid,@"cancel":@"订单超时",@"api_token":[RegisterModel getUserInfoModel].user_token};
    [FJNetTool postWithParams:dic url:Special_cancel_order loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            self.type = @"2";
            [[NSNotificationCenter defaultCenter] postNotificationName:@"orderUpdate" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"willPayOrderUpdate" object:nil];
            
            [self createBottomView];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
            
    }];
}

-(void)payOrderClicked:(UIButton *)sender{
//    PayInfoModel *payModel = [[PayInfoModel alloc]init];
//    payModel.ordersn = self.orderInfoModel.ordersn;
//    payModel.order_amount = self.orderInfoModel.total_price;
//    payModel.uid = self.orderInfoModel.uid;
//    PayInfoViewController *vc = [[PayInfoViewController alloc]init];
//    vc.payInfoModel = payModel;
//    [self.navigationController pushViewController:vc animated:YES];
    
    PayModel *payModel = [[PayModel alloc]init];
    payModel.ordersn = self.orderInfoModel.ordersn;
    payModel.total_price = self.orderInfoModel.total_price;
    PayViewController *vc = [[PayViewController alloc]init];
    vc.payModel = payModel;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)changeAddressClicked:(UIButton *)sender{
    
    OrderListModel *model = [[OrderListModel alloc]init];
    model.address = self.orderInfoModel.address;
    model.mobile = self.orderInfoModel.mobile;
    model.pay_name = self.orderInfoModel.pay_name;
    model.ordersn= self.orderInfoModel.ordersn;
    model.addressid= self.orderInfoModel.addressid;
    ChangeOrderAddressViewController *vc = [[ChangeOrderAddressViewController alloc]init];
    vc.orderListModel = model;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)cancelOrderClicked:(UIButton *)sender{
    
    OrderCancelViewController *vc = [[OrderCancelViewController alloc]init];
    vc.uid = self.orderInfoModel.uid;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)doneTakeClicked:(UIButton *)sender{
    
    NSDictionary *dic = @{@"m_id":[UserInfoModel getUserInfoModel].member_id,@"uid":self.orderInfoModel.uid,@"api_token":[RegisterModel getUserInfoModel].user_token};
    
    [FJNetTool postWithParams:dic url:Special_receiv loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            [self.view showHUDWithText:baseModel.msg withYOffSet:0];
            self.type = @"5";
            [self createBottomView];
            [self getOrderInfoFromServer];
        }
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)readLogisticsClicked:(UIButton *)sender{
    LogisticsViewController *vc = [[LogisticsViewController alloc]init];
    vc.orderNum = self.ordersn;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)evaluateClicked:(UIButton *)sender{
    EvaluateViewController *vc = [[EvaluateViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)buyAgainClicked:(UIButton *)sender{
    
    NSDictionary *dic = @{@"m_id":[UserInfoModel getUserInfoModel].member_id,@"order_id":self.orderInfoModel.uid,@"addressid":self.orderInfoModel.addressid,@"api_token":[RegisterModel getUserInfoModel].user_token};
    
    [FJNetTool postWithParams:dic url:Special_buy_again loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        [self.view showHUDWithText:baseModel.msg withYOffSet:0];
        if ([baseModel.code isEqualToString:CODE0]) {
            [self.tabBarController setSelectedIndex:2];
            [self.navigationController popToViewController:self.navigationController.viewControllers.firstObject animated:NO];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)changeOrderAddress{
    [self getOrderInfoFromServer];
}
-(void)copyOrderSnClicked{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:self.orderInfoModel.ordersn];
    [self.view showHUDWithText:@"复制成功" withYOffSet:0];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        OrderInfoAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderInfoAddressTableViewCell class])];
        if (!cell) {
            cell = [[OrderInfoAddressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([OrderInfoAddressTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.type = self.type;
        cell.model = self.orderInfoModel;
        [cell.changeddressBtn addTarget:self action:@selector(changeAddressClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    else if (indexPath.section == 1){
        OrderGoodDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderGoodDetailTableViewCell class])];
        if (!cell) {
            cell = [[OrderGoodDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([OrderGoodDetailTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.orderGoodModel = [self.goodsArr objectAtIndex:indexPath.row];
        
        return cell;
    }else if (indexPath.section == 2){
        OrderPriceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderPriceTableViewCell class])];
        if (!cell) {
            cell = [[OrderPriceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([OrderPriceTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.model = [self.goodsArr objectAtIndex:indexPath.row];
        if (indexPath.row == 0) {
            cell.isLast = NO;
            cell.isFirst = NO;
            cell.priceTitleLab.text = @"小计";
            cell.priceLab.text = [NSString stringWithFormat:@"￥%.2f",[self.orderInfoModel.goods_amount floatValue]];
            cell.priceLab.textColor = [ColorManager Color333333];
        }
        else if (indexPath.row == 1) {
            cell.isFirst = NO;
            cell.isLast = NO;
            cell.priceTitleLab.text = @"运费合计";
            cell.priceLab.text = [CommonManager getShowPrice:self.orderInfoModel.sh_type Price:self.orderInfoModel.sh_price];
            //cell.priceLab.text = [NSString stringWithFormat:@"%@%.2f",[CommonManager getPriceType:self.orderInfoModel.sh_type],[self.orderInfoModel.sh_price floatValue]];
            cell.priceLab.textColor = [ColorManager Color333333];
        }
        else if (indexPath.row == 2) {
            cell.isFirst = NO;
            cell.isLast = YES;
            cell.priceTitleLab.text = @"合计";
            cell.priceLab.text = [NSString stringWithFormat:@"￥%.2f",[self.orderInfoModel.total_price floatValue]];
            cell.priceLab.textColor = [ColorManager MainColor];
            
        }
        
        return cell;
    }
    else if (indexPath.section == 3){
        OrderInfoInvoiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderInfoInvoiceTableViewCell class])];
        if (!cell) {
            cell = [[OrderInfoInvoiceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([OrderInfoInvoiceTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        OrderInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderInfoTableViewCell class])];
        if (!cell) {
            cell = [[OrderInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([OrderInfoTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.isLast = NO;
        if (indexPath.row != 1) {
            cell.orderNumLab.hidden = YES;
            cell.orderCopyBtn.hidden = YES;
            cell.infoLab.hidden = NO;
            if (indexPath.row == 0) {
                cell.titleLab.text = @"下单时间";
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.orderInfoModel.addtime];
                cell.infoLab.text = [CommonManager timeGetCurrentDateOfYearMonthDayHourMinutesSecond:date];
            }
            if (indexPath.row == 2) {
                cell.titleLab.text = @"支付方式";
                cell.infoLab.text = @"信用卡";
            }
            if (indexPath.row == 3) {
                cell.titleLab.text = @"配送方式";
                cell.infoLab.text = @"快递";
                cell.isLast = YES;
            }
        }else{
            cell.orderNumLab.hidden = NO;
            cell.orderCopyBtn.hidden = NO;
            cell.infoLab.hidden = YES;
            
            cell.titleLab.text = @"订单编号";
            cell.orderNumLab.text = self.orderInfoModel.ordersn;
            [cell.orderCopyBtn addTarget:self action:@selector(copyOrderSnClicked) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        return cell;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return self.goodsArr.count;
    }
    if (section == 2) {
        return 3;
    }
    if (section == 4) {
        return 4;
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
    if (section == 3) {
        return kWidth(20);
    }
    return 0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
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
