//
//  RemoveAccountViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/29.
//

#import "RemoveAccountViewController.h"
#import "OrderCancelTableViewCell.h"

@interface RemoveAccountViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)NSArray *titleArr;

@property (nonatomic , copy)NSString *reason;

@end

@implementation RemoveAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"账号注销"];
    [self.view addSubview:nav];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea-kWidth(48)-kWidth(60)) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[OrderCancelTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderCancelTableViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager WhiteColor];
    
    [self.view addSubview:self.tableView];
    
    self.titleArr = @[@"需要解绑手机",@"需要解绑邮箱",@"安全/隐私顾虑",@"只是多余的账号",@"购物遇到困难",@"其他"];
    
    UIButton *doneBtn = [[UIButton alloc]init];
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    doneBtn.titleLabel.font = kFont(14);
    doneBtn.backgroundColor = [ColorManager MainColor];
    doneBtn.layer.cornerRadius = kWidth(24);
    [doneBtn addTarget:self action:@selector(doneClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doneBtn];
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.mas_offset(kWidth(-20)-kHeight_SafeArea);
        make.width.mas_offset(kWidth(321));
        make.height.mas_offset(kWidth(48));
    }];
}

-(void)doneClicked{
    if (self.reason.length) {
        NSDictionary *dic = @{@"uid":[UserInfoModel getUserInfoModel].uid,@"cancel":self.reason,@"api_token":[RegisterModel getUserInfoModel].user_token};
        
        [FJNetTool postWithParams:dic url:Login_cancel loading:YES success:^(id responseObject) {
            BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
            if ([baseModel.code isEqualToString:CODE0]) {
                [UserInfoModel clearUserInfo];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        } failure:^(NSError *error) {
            
        }];
    }else{
        [self.view showHUDWithText:@"请选择注销原因" withYOffSet:0];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderCancelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderCancelTableViewCell class])];
    if (!cell) {
        cell = [[OrderCancelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([OrderCancelTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleLab.text = [self.titleArr objectAtIndex:indexPath.row];
    
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return kWidth(64);
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
    self.reason = [self.titleArr objectAtIndex:indexPath.row];
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
