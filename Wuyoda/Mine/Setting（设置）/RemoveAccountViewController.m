//
//  RemoveAccountViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/29.
//

#import "RemoveAccountViewController.h"
#import "OrderCancelTableViewCell.h"
#import "RemoveAccountIntroViewController.h"

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
    nav.backgroundColor = [ColorManager ColorF2F2F2];
    [self.view addSubview:nav];
    
    self.view.backgroundColor = [ColorManager ColorF2F2F2];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar+kWidth(20), kScreenWidth, kScreenHeight-kHeight_NavBar-kWidth(20))];
    bgView.backgroundColor = [ColorManager WhiteColor];
    [self.view addSubview:bgView];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(kWidth(10), kWidth(10))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame =  bgView.bounds;
    maskLayer.path = maskPath.CGPath;
    bgView.layer.mask = maskLayer;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kWidth(10), kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea-kWidth(48)-kWidth(60)-kWidth(30)) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[OrderCancelTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderCancelTableViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager WhiteColor];
    
    [bgView addSubview:self.tableView];
    
    self.titleArr = @[@"需要解绑手机",@"需要解绑邮箱",@"安全/隐私顾虑",@"只是多余的账号",@"购物遇到困难",@"其他"];
    
    UIButton *doneBtn = [[UIButton alloc]init];
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    doneBtn.titleLabel.font = kFont(14);
    [doneBtn setBackgroundImage:kGetImage(@"login_按钮") forState:UIControlStateNormal];;
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
                [self.view showHUDWithText:baseModel.msg withYOffSet:0];
                [UserInfoModel clearUserInfo];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else{
                [self.view showHUDWithText:baseModel.msg withYOffSet:0];
            }
        } failure:^(NSError *error) {

        }];
//        RemoveAccountIntroViewController *vc = [[RemoveAccountIntroViewController alloc]init];
//        vc.reason = self.reason;
//        [self.navigationController pushViewController:vc animated:YES];
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
