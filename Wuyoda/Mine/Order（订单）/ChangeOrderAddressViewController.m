//
//  ChangeOrderAddressViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/12.
//

#import "ChangeOrderAddressViewController.h"
#import "ChangeOrderAddressHeaderView.h"
#import "ChangeOrderAddressTableViewCell.h"
#import "AddressModel.h"
#import "AddressInfoViewController.h"

@interface ChangeOrderAddressViewController ()<UITableViewDelegate, UITableViewDataSource,updateAddressInfoDelegate>

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)ChangeOrderAddressHeaderView *headerV;

@property (nonatomic , retain)NSArray *addressArr;

@property (nonatomic , retain)AddressModel *selectModel;

@end

@implementation ChangeOrderAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"修改地址"];
    [self.view addSubview:nav];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar-kWidth(78)-kHeight_SafeArea) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[ChangeOrderAddressTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ChangeOrderAddressTableViewCell class])];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager WhiteColor];
    
    self.headerV = [[ChangeOrderAddressHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(220))];
    [self.headerV.addBtn addTarget:self action:@selector(addressAddClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.headerV.orderListModel = self.orderListModel;
    self.tableView.tableHeaderView = self.headerV;
    
    [self.view addSubview:self.tableView];
    
    UIButton *saveBtn = [[UIButton alloc]init];
    [saveBtn setTitle:@"提交修改" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    saveBtn .titleLabel.font = kFont(14);
    saveBtn.backgroundColor= [ColorManager MainColor];
    saveBtn.layer.cornerRadius = kWidth(24);
    [saveBtn addTarget:self action:@selector(changeAddressClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.mas_offset(kWidth(321));
        make.height.mas_offset(kWidth(48));
        make.bottom.mas_offset(-kHeight_SafeArea-kWidth(15));
    }];
    
    [self getAddressListFromServer];
}

-(void)getAddressListFromServer{
    NSDictionary *dic = @{@"m_uid":[UserInfoModel getUserInfoModel].uid,@"api_token":[RegisterModel getUserInfoModel].user_token};
    
    [FJNetTool postWithParams:dic url:Special_address_list loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            self.selectModel = nil;
            self.addressArr = [AddressModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.tableView reloadData];
            
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)addressAddClicked:(id)sender{
    AddressInfoViewController *vc = [[AddressInfoViewController alloc]init];
    vc.type = @"1";
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)changeAddressClicked:(id)sender{
    if (self.selectModel) {
        NSDictionary *dic = @{@"m_id":[UserInfoModel getUserInfoModel].member_id,@"ordersn":self.orderListModel.ordersn,@"addressid":self.selectModel.uid,@"api_token":[RegisterModel getUserInfoModel].user_token};
        
        [FJNetTool postWithParams:dic url:Special_modify_address loading:YES success:^(id responseObject) {
            BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
            if ([baseModel.code isEqualToString:CODE0]) {
                [self.view showHUDWithText:@"修改成功" withYOffSet:0];
                if (self.delegate && [self.delegate respondsToSelector:@selector(changeOrderAddress)]) {
                    [self.delegate changeOrderAddress];
                }
            }
        } failure:^(NSError *error) {
            
        }];
    }else{
        [self.view showHUDWithText:@"请选择地址" withYOffSet:0];
    }
}

-(void)updateAddressInfo{
    [self getAddressListFromServer];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChangeOrderAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ChangeOrderAddressTableViewCell class])];
    if (!cell) {
        cell = [[ChangeOrderAddressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ChangeOrderAddressTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = [self.addressArr objectAtIndex:indexPath.row];
    
    return cell;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.addressArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return kWidth(74);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return [UIView new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectModel = [self.addressArr objectAtIndex:indexPath.row];
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
