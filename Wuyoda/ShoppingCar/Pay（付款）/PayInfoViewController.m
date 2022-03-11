//
//  PayInfoViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/11/11.
//

#import "PayInfoViewController.h"
#import "PayInfoTableViewCell.h"
#import "BankCardListView.h"
#import "PayYearOrMonthView.h"
#import "BankModel.h"
#import "PaySuccessViewController.h"

@interface PayInfoViewController ()<UITableViewDelegate,UITableViewDataSource,PayInfoTableViewCellDelegate,selectPayBankDelegate,selectPayDateDelegate>

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)NSArray *titleArr;

@property (nonatomic , retain)NSArray *placeholderArr;

@property (nonatomic , retain)UITextField *nameField;
@property (nonatomic , retain)UITextField *phoneField;
@property (nonatomic , retain)UITextField *idCardField;
@property (nonatomic , retain)UITextField *bankField;
//@property (nonatomic , retain)UITextField *endNumField;
//@property (nonatomic , retain)UITextField *codeField;

//@property (nonatomic , copy)NSString *payType;
//@property (nonatomic , copy)NSString *paymentumf_id;
//@property (nonatomic , retain)BankModel *currentBankModel;
//@property (nonatomic , copy)NSString *yearStr;
//@property (nonatomic , copy)NSString *monthStr;
//
//@property (nonatomic , retain)NSArray *yinlianArr;
//@property (nonatomic , retain)NSArray *xinyongkaArr;
//
//@property (nonatomic , retain)BankCardListView *bankListView;
//@property (nonatomic , retain)PayYearOrMonthView *dateView;

@end

@implementation PayInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"确认付款"];
    [self.view addSubview:nav];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[PayInfoTableViewCell class] forCellReuseIdentifier:NSStringFromClass([PayInfoTableViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager ColorF2F2F2];
    
    [self.view addSubview:self.tableView];
    
    self.titleArr = @[@"订单编号",@"姓名",@"电话",@"身份证号",@"银行卡号"];
    self.placeholderArr = @[@"",@"请输入您的姓名",@"请输入电话号码",@"请输入身份证号",@"请输入银行卡号"];
//    self.payType = @"DEBIT_CARD";
//    self.yearStr = @"21";
//    self.monthStr = @"01";
//    [self getBankListFromServer];
}

//-(void)getBankListFromServer{
//    [FJNetTool postWithParams:@{@"api_token":[RegisterModel getUserInfoModel].user_token} url:Special_bank loading:YES success:^(id responseObject) {
//        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
//        if ([baseModel.code isEqualToString:CODE0]) {
//
//            NSString *CREDIT_CARDStr = responseObject[@"data"][@"CREDIT_CARD"];
//
//            NSData *CREDIT_CARDData = [CREDIT_CARDStr dataUsingEncoding:NSUTF8StringEncoding];
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:CREDIT_CARDData
//                                                                options:NSJSONReadingMutableContainers
//                                                                  error:nil];
//            self.xinyongkaArr = [BankModel mj_objectArrayWithKeyValuesArray:dic[@"banks"]];
//
//            NSString *DEBIT_CARDStr = responseObject[@"data"][@"DEBIT_CARD"];
//
//            NSData *DEBIT_CARDData = [DEBIT_CARDStr dataUsingEncoding:NSUTF8StringEncoding];
//            NSDictionary *dic2 = [NSJSONSerialization JSONObjectWithData:DEBIT_CARDData
//                                                                options:NSJSONReadingMutableContainers
//                                                                  error:nil];
//            self.yinlianArr = [BankModel mj_objectArrayWithKeyValuesArray:dic2[@"banks"]];
//            self.payType = @"DEBIT_CARD";
//            self.currentBankModel = [self.yinlianArr firstObject];
//            [self.tableView reloadData];
//
//        }
//    } failure:^(NSError *error) {
//
//    }];
//}

//-(void)getPayCodeClicked:(UIButton *)sender{
//    if ([self checkInfoEmpty]) {
//        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
//        [dic setValue:[UserInfoModel getUserInfoModel].member_id forKey:@"m_id"];
//        [dic setValue:self.payInfoModel.uid forKey:@"order_id"];
//        [dic setValue:self.payInfoModel.original_price forKey:@"total_price"];
//        [dic setValue:self.payType forKey:@"payment_method"];
//        [dic setValue:self.nameField.text forKey:@"payer_name"];
//        [dic setValue:self.phoneField.text forKey:@"payer_phone"];
//        [dic setValue:self.idCardField.text forKey:@"citizen_id"];
//        [dic setValue:self.currentBankModel.code forKey:@"bank_code"];
//        [dic setValue:self.bankField.text forKey:@"bank_number"];
//        [dic setValue:@"pay_send" forKey:@"apitype"];
//        if ([self.payType isEqualToString:@"CREDIT_CARD"]) {
//            [dic setValue:[NSString stringWithFormat:@"%@%@",self.yearStr,self.monthStr] forKey:@"bank_valid_date"];
//            [dic setValue:self.endNumField.text forKey:@"safe_code"];
//        }
//        NSLog(@"sendDic:%@",dic);
//
//        [FJNetTool postWithParams:dic url:Special_umf_pay loading:YES success:^(id responseObject) {
//            [self.view showHUDWithText:@"发送验证码成功" withYOffSet:0];
//            self.paymentumf_id = responseObject[@"paymentumf_id"];
//        } failure:^(NSError *error) {
//
//        }];
//    }
//}

-(void)payOrderClicked:(UIButton *)sender{
    if ([self checkInfoEmpty]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:[UserInfoModel getUserInfoModel].uid forKey:@"m_uid"];
        [dic setValue:self.payInfoModel.ordersn forKey:@"ordersn"];
        [dic setValue:self.payInfoModel.original_price forKey:@"total_price"];
        [dic setValue:self.nameField.text forKey:@"payer_name"];
        [dic setValue:self.idCardField.text forKey:@"citizen_id"];
        [dic setValue:self.phoneField.text forKey:@"payer_phone"];
        [dic setValue:self.bankField.text forKey:@"bank_number"];
        [dic setValue:[RegisterModel getUserInfoModel].user_token forKey:@"api_token"];
        
        [FJNetTool postWithParams:dic url:Special_juhe_pay loading:YES success:^(id responseObject) {
            BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
            if ([baseModel.code isEqualToString:CODE0]) {
                FJWebViewController *vc = [[FJWebViewController alloc]init];
                vc.url = baseModel.msg;
                vc.ordersn = self.payInfoModel.ordersn;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [self.view showHUDWithText:baseModel.msg withYOffSet:0];
            }
        } failure:^(NSError *error) {
            
        }];
    }
}
//{
//    "api_token" = 11a0c5ce1fe5d77ec30aa361b338da49;
//    "bank_number" = 6257080018600105;
//    "citizen_id" = 440202199808170918;
//    "m_uid" = 40815;
//    ordersn = OD164058991593;
//    "payer_name" = "\U5f20\U4e09";
//    "payer_phone" = 13511111111;
//    "total_price" = "314.28";
//}

//-(void)payOrderClicked:(UIButton *)sender{
//    if ([self checkInfoEmpty]) {
//        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
//        [dic setValue:[UserInfoModel getUserInfoModel].member_id forKey:@"m_id"];
//        [dic setValue:self.payInfoModel.uid forKey:@"order_id"];
//        [dic setValue:self.payInfoModel.original_price forKey:@"total_price"];
//        [dic setValue:self.payType forKey:@"payment_method"];
//        [dic setValue:self.nameField.text forKey:@"payer_name"];
//        [dic setValue:self.phoneField.text forKey:@"payer_phone"];
//        [dic setValue:self.idCardField.text forKey:@"citizen_id"];
//        [dic setValue:self.currentBankModel.code forKey:@"bank_code"];
//        [dic setValue:self.bankField.text forKey:@"bank_number"];
//        [dic setValue:@"pay_execute" forKey:@"apitype"];
//        [dic setValue:self.codeField.text forKey:@"execute_verifypo"];
//        [dic setValue:self.paymentumf_id forKey:@"paymentumf_id"];
//
//        if ([self.payType isEqualToString:@"CREDIT_CARD"]) {
//            [dic setValue:[NSString stringWithFormat:@"%@%@",self.yearStr,self.monthStr] forKey:@"bank_valid_date"];
//            [dic setValue:self.endNumField.text forKey:@"safe_code"];
//        }
//        NSLog(@"payDic:%@",dic);
//
//        [FJNetTool postWithParams:dic url:Special_umf_pay loading:YES success:^(id responseObject) {
//            PaySuccessViewController *vc = [[PaySuccessViewController alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];
//        } failure:^(NSError *error) {
//
//        }];
//    }
//}
//-(void)showBankListView{
//    self.bankListView = [[BankCardListView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar)];
//
//    if ([self.payType isEqualToString:@""]) {
//        self.bankListView.bankArr = self.yinlianArr;
//    }else{
//        self.bankListView.bankArr = self.xinyongkaArr;
//    }
//    self.bankListView.delegate = self;
//    [self.bankListView show];
//    [self.view addSubview:self.bankListView];
//}
//-(void)selectPayBank:(BankModel *)model{
//    self.currentBankModel = model;
//    [self.bankListView close];
//    [self.tableView reloadData];
//}

-(BOOL)checkInfoEmpty{
    if (!self.nameField.text.length) {
        [self.view showHUDWithText:@"请填写完整信息" withYOffSet:0];
        return NO;
    }
    if (!self.phoneField.text.length) {
        [self.view showHUDWithText:@"请填写完整信息" withYOffSet:0];
        return NO;
    }
    if (!self.idCardField.text.length) {
        [self.view showHUDWithText:@"请填写完整信息" withYOffSet:0];
        return NO;
    }
    if (!self.bankField.text.length) {
        [self.view showHUDWithText:@"请填写完整信息" withYOffSet:0];
        return NO;
    }
//    if (!self.codeField.text.length) {
//        [self.view showHUDWithText:@"请填写完整信息" withYOffSet:0];
//        return NO;
//    }
//    if (![self.payType isEqualToString:@"DEBIT_CARD"]) {
//        if (!self.endNumField.text.length) {
//            return NO;
//        }
//    }
    
    return YES;
}

//-(void)updatePayType:(NSString *)payType{
//    self.payType = payType;
//    if ([payType isEqualToString:@"DEBIT_CARD"]) {
//        self.currentBankModel = [self.yinlianArr firstObject];
//        self.titleArr = @[@"订单编号",@"支付方式",@"姓名",@"电话",@"身份证号",@"支持银行",@"银行卡号",@"验证码"];
//        self.placeholderArr = @[@"",@"",@"请输入您的姓名",@"请输入电话号码",@"请输入身份证号",@"",@"请输入银行卡号",@"请输入验证码"];
//
//    }else{
//        self.currentBankModel = [self.xinyongkaArr firstObject];
//        self.titleArr = @[@"订单编号",@"支付方式",@"姓名",@"电话",@"身份证号",@"信用卡",@"信用卡号",@"后四位码",@"有效年月",@"验证码"];
//        self.placeholderArr = @[@"",@"",@"请输入您的姓名",@"请输入电话号码",@"请输入身份证号",@"",@"请输入信用卡号",@"请输入后四位码",@"",@"请输入验证码"];
//    }
//
////    NSMutableArray *reloadArr = [[NSMutableArray alloc]init];
////    for (int i = 0; i<1; i++) {
////        NSIndexPath *path = [NSIndexPath indexPathForRow:i+5 inSection:0];
////        [reloadArr addObject:path];
////    }
//
////    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:5 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//    [self.tableView reloadData];
//}

//-(void)changeYearClicked:(UIButton *)sender{
//    self.dateView = [[PayYearOrMonthView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar)];
//    NSArray *yearsArr = @[@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"45",@"36"];
//    self.dateView.dateArr = yearsArr;
//    self.dateView.type = @"year";
//    self.dateView.delegate = self;
//    [self.dateView show];
//    [self.view addSubview:self.dateView];
//}

//-(void)selectPayDate:(NSString *)date Type:(NSString *)type{
//    if ([type isEqualToString:@"year"]) {
//        self.yearStr = date;
//    }else{
//        self.monthStr = date;
//
//    }
//    [self.dateView close];
//    [self.tableView reloadData];
//}

//-(void)changeMonthClicked:(UIButton *)sender{
//    self.dateView = [[PayYearOrMonthView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar)];
//    NSArray *monthArr = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
//    self.dateView.dateArr = monthArr;
//    self.dateView.type = @"month";
//    self.dateView.delegate = self;
//    [self.dateView show];
//    [self.view addSubview:self.dateView];
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PayInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PayInfoTableViewCell class])];
    if (!cell) {
        cell = [[PayInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([PayInfoTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleLab.text = self.titleArr[indexPath.row];
    cell.infoTextField.placeholder = self.placeholderArr[indexPath.row];
    
    cell.infoLab.hidden = YES;
    cell.infoTextField.hidden = YES;
    cell.yinlianBtn.hidden = YES;
    cell.xinYongkaBtn.hidden = YES;
    cell.getCodeBtn.hidden = YES;
    cell.yearBtn.hidden = YES;
    cell.yearLab.hidden = YES;
    cell.monthBtn.hidden = YES;
    cell.monthLab.hidden = YES;
    
    if (indexPath.row == 0) {
        cell.infoLab.hidden = NO;
        cell.infoLab.text = self.payInfoModel.ordersn;
    }
//    else if (indexPath.row == 1) {
//        cell.payType = self.payType;
//        cell.yinlianBtn.hidden = NO;
//        cell.xinYongkaBtn.hidden = NO;
//        cell.delegate = self;
//    }
    else if (indexPath.row == 1) {
        cell.infoTextField.hidden = NO;
        cell.infoTextField.text = self.nameField.text;
        self.nameField = cell.infoTextField;
    }else if (indexPath.row == 2) {
        cell.infoTextField.hidden = NO;
        cell.infoTextField.text = self.phoneField.text;
        self.phoneField = cell.infoTextField;
    }else if (indexPath.row == 3) {
        cell.infoTextField.hidden = NO;
        cell.infoTextField.text = self.idCardField.text;
        self.idCardField = cell.infoTextField;
    }
//    else if (indexPath.row == 4) {
//        cell.infoLab.hidden = NO;
//        cell.infoLab.text = self.currentBankModel.name_zh;
//    }
    else if (indexPath.row == 4) {
        cell.infoTextField.hidden = NO;
        cell.infoTextField.text = self.bankField.text;
        self.bankField = cell.infoTextField;
    }
//    else{
//        //cell.infoTextField.text = @"";
//        if ([self.payType isEqualToString:@"DEBIT_CARD"]) {
//            if (indexPath.row == 7) {
//                cell.infoTextField.hidden = NO;
//                cell.getCodeBtn.hidden = NO;
//                cell.infoTextField.text = @"";
//                self.codeField = cell.infoTextField;
//                [cell.getCodeBtn addTarget:self action:@selector(getPayCodeClicked:) forControlEvents:UIControlEventTouchUpInside];
//            }
//        }else{
//            if (indexPath.row == 7) {
//                cell.infoTextField.hidden = NO;
//                cell.infoTextField.text = self.endNumField.text;
//                self.endNumField = cell.infoTextField;
//            }
//            if (indexPath.row == 8) {
//                cell.yearBtn.hidden = NO;
//                cell.yearLab.hidden = NO;
//                cell.monthBtn.hidden = NO;
//                cell.monthLab.hidden = NO;
//                [cell.yearBtn setTitle:self.yearStr forState:UIControlStateNormal];
//                [cell.monthBtn setTitle:self.monthStr forState:UIControlStateNormal];
//                [cell.yearBtn addTarget:self action:@selector(changeYearClicked:) forControlEvents:UIControlEventTouchUpInside];
//                [cell.monthBtn addTarget:self action:@selector(changeMonthClicked:) forControlEvents:UIControlEventTouchUpInside];
//
//            }
//            if (indexPath.row == 9) {
//                cell.infoTextField.hidden = NO;
//                cell.getCodeBtn.hidden = NO;
//                cell.infoTextField.text = @"";
//                self.codeField = cell.infoTextField;
//                [cell.getCodeBtn addTarget:self action:@selector(getPayCodeClicked:) forControlEvents:UIControlEventTouchUpInside];
//            }
//        }
//    }
    
    
    
    
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.titleArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return kWidth(52);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return kWidth(80);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return kWidth(5);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(80))];
    footerView.backgroundColor = [ColorManager ColorF2F2F2];
    
    UIButton *payBtn = [[UIButton alloc]initWithFrame:CGRectMake(kWidth(27), kWidth(30), kWidth(321), kWidth(48))];
    [payBtn setTitle:@"提交支付" forState:UIControlStateNormal];
    [payBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    payBtn.titleLabel.font = kFont(16);
    payBtn.layer.cornerRadius = kWidth(24);
    payBtn.backgroundColor = [ColorManager MainColor];
    [payBtn addTarget:self action:@selector(payOrderClicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:payBtn];
    return footerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(5))];
    headerV.backgroundColor = [ColorManager ColorF2F2F2];
    return headerV;
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 5) {
//        [self showBankListView];
//    }
//}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    [self.bankListView removeFromSuperview];
//    [self.dateView removeFromSuperview];
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
