//
//  UserInfoViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/8.
//

#import "UserInfoViewController.h"
#import "UserInfoTableViewCell.h"

@interface UserInfoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)UIImageView *iconImgV;

@property (nonatomic , retain)UITextField *nameField;

@property (nonatomic , retain)UIButton *manBtn;

@property (nonatomic , retain)UIButton *womenBtn;

@property (nonatomic , retain)UITextField *birthdayField;

@property (nonatomic , copy)NSString *nameStr;
@property (nonatomic , copy)NSString *sexStr;
@property (nonatomic , copy)NSString *birthdatStr;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"编辑个人资料"];
    [self.view addSubview:nav];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UserInfoTableViewCell class] forCellReuseIdentifier:NSStringFromClass([UserInfoTableViewCell class])];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager WhiteColor];
    
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(144))];
    headerV.backgroundColor = [ColorManager ColorF2F2F2];
    UIView *bgV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(136))];
    bgV.backgroundColor = [ColorManager WhiteColor];
    [headerV addSubview:bgV];
    self.iconImgV = [[UIImageView alloc]init];
    self.iconImgV.backgroundColor = [ColorManager RandomColor];
    self.iconImgV.layer.cornerRadius = kWidth(40);
    [bgV addSubview:self.iconImgV];
    [self.iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(bgV);
        make.width.height.mas_offset(kWidth(80));
    }];
    self.tableView.tableHeaderView = headerV;
    
    UIView *footerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(77))];
    UIButton *saveBtn = [[UIButton alloc]init];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    saveBtn .titleLabel.font = kFont(14);
    saveBtn.backgroundColor= [ColorManager MainColor];
    saveBtn.layer.cornerRadius = kWidth(24);
    [saveBtn addTarget:self action:@selector(saveUserInfoClicked) forControlEvents:UIControlEventTouchUpInside];
    [footerV addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.equalTo(footerV);
        make.width.mas_offset(kWidth(321));
        make.height.mas_offset(kWidth(48));
    }];
    self.tableView.tableFooterView = footerV;
    self.sexStr = @"1";
    
    [self.view addSubview:self.tableView];
}

-(void)saveUserInfoClicked{
    
    NSDictionary *dic = @{@"uid":[UserInfoModel getUserInfoModel].uid,@"member_name":self.nameField.text,@"mamber_sex":self.sexStr,@"mamber_birthday":self.birthdatStr};
    
//    [FJNetTool postWithParams:dic url:Login_perfect loading:YES success:^(id responseObject) {
//        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
//        if ([baseModel.code isEqualToString:CODE0]) {
//
//        }
//    } failure:^(NSError *error) {
//
//    }];
}

-(void)changeSexClicked:(UIButton *)sender{
    sender.selected = YES;
    if (sender == self.manBtn) {
        self.womenBtn.selected = NO;
        self.sexStr = @"1";
    }else{
        self.manBtn.selected = NO;
        self.sexStr = @"0";
    }
    
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UserInfoTableViewCell class])];
    if (!cell) {
        cell = [[UserInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UserInfoTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        cell.titleLab.text = @"昵称";
        cell.infoTextField.placeholder = @"请输入昵称";
        cell.manBtn.hidden = YES;
        cell.womenBtn.hidden = YES;
        cell.infoTextField.hidden = NO;
        self.nameField = cell.infoTextField;
        cell.infoTextField.text = self.nameStr;
        
    }
    if (indexPath.row == 1) {
        cell.titleLab.text = @"性别";
        cell.manBtn.hidden = NO;
        cell.womenBtn.hidden = NO;
        cell.infoTextField.hidden = YES;
        self.manBtn = cell.manBtn;
        self.womenBtn = cell.womenBtn;
        [cell.manBtn addTarget:self action:@selector(changeSexClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.womenBtn addTarget:self action:@selector(changeSexClicked:) forControlEvents:UIControlEventTouchUpInside];
        if ([self.sexStr isEqualToString:@"0"]) {
            cell.womenBtn.selected = YES;
            cell.manBtn.selected = NO;
        }else{
            cell.womenBtn.selected = NO;
            cell.manBtn.selected = YES;
        }
    }
    if (indexPath.row == 2) {
        cell.titleLab.text = @"生日";
        cell.infoTextField.placeholder = @"请输入生日";
        cell.manBtn.hidden = YES;
        cell.womenBtn.hidden = YES;
        cell.infoTextField.hidden = NO;
        self.birthdayField = cell.infoTextField;
        cell.infoTextField.text = self.birthdatStr;
        self.birthdayField.userInteractionEnabled = NO;
    }
    
    
    return cell;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return kWidth(52);
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
    if (indexPath.row == 2) {
        
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
