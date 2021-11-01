//
//  OrderInfoViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/27.
//

#import "OrderInfoViewController.h"
#import "OrderInfoAddressTableViewCell.h"
#import "OrderInfoGoodTableViewCell.h"
#import "OrderInfoInvoiceTableViewCell.h"
#import "OrderInfoTableViewCell.h"
#import "OrderInfoHeaderView.h"
#import "OrderInfoBottomView.h"

@interface OrderInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)NSArray *infoTitleArr;

@property (nonatomic , retain)OrderInfoHeaderView *headerV;

@property (nonatomic , retain)OrderInfoBottomView *bottomV;

@end

@implementation OrderInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"订单详情"];
    [self.view addSubview:nav];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea-kWidth(48)) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[OrderInfoAddressTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderInfoAddressTableViewCell class])];
    [self.tableView registerClass:[OrderInfoGoodTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderInfoGoodTableViewCell class])];
    [self.tableView registerClass:[OrderInfoInvoiceTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderInfoInvoiceTableViewCell class])];
    [self.tableView registerClass:[OrderInfoTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderInfoTableViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager WhiteColor];
    [self.view addSubview:self.tableView];
    
    if (self.type && ![self.type isEqualToString:@"4"]) {
        self.headerV = [[OrderInfoHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(94))];
        self.headerV.type = self.type;
        self.tableView.tableHeaderView = self.headerV;
        
        self.bottomV = [[OrderInfoBottomView alloc]initWithFrame:CGRectMake(0, kScreenHeight-kHeight_SafeArea-kWidth(49), kScreenWidth, kWidth(49))];
        self.bottomV.type = self.type;
        [self.view addSubview:self.bottomV];
        self.tableView.frame = CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea-kWidth(49));
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        OrderInfoAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderInfoAddressTableViewCell class])];
        if (!cell) {
            cell = [[OrderInfoAddressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([OrderInfoAddressTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else if (indexPath.section == 1){
        OrderInfoGoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderInfoGoodTableViewCell class])];
        if (!cell) {
            cell = [[OrderInfoGoodTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([OrderInfoGoodTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else if (indexPath.section == 2){
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
        
        if (indexPath.row != 1) {
            cell.orderNumLab.hidden = YES;
            cell.orderCopyBtn.hidden = YES;
            cell.infoLab.hidden = NO;
            if (indexPath.row == 0) {
                cell.titleLab.text = @"下单时间";
                cell.infoLab.text = @"2020.7.3 10:30:20";
            }
            if (indexPath.row == 2) {
                cell.titleLab.text = @"支付方式";
                cell.infoLab.text = @"信用卡";
            }
            if (indexPath.row == 3) {
                cell.titleLab.text = @"配送方式";
                cell.infoLab.text = @"快递";
            }
        }else{
            cell.orderNumLab.hidden = NO;
            cell.orderCopyBtn.hidden = NO;
            cell.infoLab.hidden = YES;
            
            cell.titleLab.text = @"订单编号";
            cell.orderNumLab.text = @"202036498721364";
        }
        
        
        return cell;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 3) {
        return 4;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return kWidth(70);
    }else if (indexPath.section == 1){
        return kWidth(311);
    }else if (indexPath.section == 2){
        return kWidth(46);
    }
    return kWidth(26);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section < 3) {
        return 0.001;
    }
    return kWidth(15);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section < 3) {
        return [UIView new];
    }
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(15))];
    headerV.backgroundColor = [ColorManager WhiteColor];
    return headerV;
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
