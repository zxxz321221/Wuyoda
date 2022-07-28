//
//  AddressListViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/27.
//

#import "AddressListViewController.h"
#import "AddressListTableViewCell.h"
#import "AddressInfoViewController.h"
#import "AddressDeleteAlertView.h"


@interface AddressListViewController ()<UITableViewDelegate,UITableViewDataSource,updateAddressDelegate,updateAddressInfoDelegate>

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)NSMutableArray *addressArr;

@property (nonatomic , retain)AddressDeleteAlertView *deleteAlertV;

@property (nonatomic , retain)AddressModel *editModel;

@end

@implementation AddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [ColorManager ColorF2F2F2];
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"我的收货地址"];
    nav.backgroundColor = [ColorManager ColorF2F2F2];
    nav.isInitBackBtn = YES;
    nav.block = ^{
        if ([self.type isEqualToString:@"order"]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    };
    [self.view addSubview:nav];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea-kWidth(42)-kWidth(50)) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[AddressListTableViewCell class] forCellReuseIdentifier:NSStringFromClass([AddressListTableViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager ColorF2F2F2];
    [self.view addSubview:self.tableView];
    
    UIButton *addBtn = [[UIButton alloc]init];
    [addBtn setTitle:@"新增收获地址" forState:UIControlStateNormal];
    [addBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    addBtn.titleLabel.font = kFont(14);
    [addBtn setBackgroundImage:kGetImage(@"login_按钮") forState:UIControlStateNormal];
    addBtn.layer.cornerRadius = kWidth(21);
    [addBtn addTarget:self action:@selector(addAddressClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.mas_offset(kWidth(-20)-kHeight_SafeArea);
        make.width.mas_offset(kWidth(335));
        make.height.mas_offset(kWidth(48));
    }];
    
    [self getDataFromServer];
}

-(void)deleteAddressWithModel:(AddressModel *)model{
    self.deleteAlertV = [[AddressDeleteAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.deleteAlertV.deleteBtn addTarget:self action:@selector(deleteDoneClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.editModel = model;
    [self.view addSubview:self.deleteAlertV];
}

-(void)deleteDoneClicked:(UIButton *)sender{
    [self.deleteAlertV removeFromSuperview];
    
    NSDictionary *dic = @{@"uid":self.editModel.uid,@"api_token":[RegisterModel getUserInfoModel].user_token};
    
    [FJNetTool postWithParams:dic url:Special_address_del loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            if ([self.editModel.uid isEqualToString:self.addressModel.uid]) {
                [self.view showHUDWithText:@"您的配送地址发生变更" withYOffSet:0];
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(selectAddress:)]) {
                    if (self.addressArr.count>1) {
                        [self.delegate selectAddress:nil];
                    }else{
                        AddressModel *addressModel = [[AddressModel alloc]init];
                        [self.delegate selectAddress:addressModel];
                    }
                    
                }
            }
            [self getDataFromServer];
            
        }
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)updateNormalAddressWithModel:(AddressModel *)model{
    [self getDataFromServer];
}
-(void)updateAddressInfo{
    [self getDataFromServer];
}

-(void)getDataFromServer{
    NSDictionary *dic = @{@"m_uid":[UserInfoModel getUserInfoModel].uid,@"api_token":[RegisterModel getUserInfoModel].user_token};
    
    [FJNetTool postWithParams:dic url:Special_address_list loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            self.addressArr = [AddressModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.tableView reloadData];
//            if (self.addressArr.count) {
//                if (self.delegate && [self.delegate respondsToSelector:@selector(selectAddress:)]) {
//                    [self.delegate selectAddress:self.addressArr[0]];
//                }
//            }
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)addAddressClicked{
    AddressInfoViewController *vc = [[AddressInfoViewController alloc]init];
    vc.type = @"1";
    if (![self.type isEqualToString:@"order"]) {
        vc.delegate = self;
        vc.addressCount = 1;
    }else{
        vc.addressCount = 0;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AddressListTableViewCell class])];
    if (!cell) {
        cell = [[AddressListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([AddressListTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = [self.addressArr objectAtIndex:indexPath.section];
    cell.delegate = self;
    
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.addressArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return kWidth(132);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return kWidth(10);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(10))];
    headerV.backgroundColor = [ColorManager ColorF2F2F2];
    return headerV;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectAddress:)]) {
        [self.delegate selectAddress:self.addressArr[indexPath.section]];
        [self.navigationController popViewControllerAnimated:YES];
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
