//
//  AddressInfoViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/27.
//

#import "AddressInfoViewController.h"
#import "AddressInfoTableViewCell.h"
#import "AddressInfoFooterView.h"

@interface AddressInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)NSArray *titleArr;

@property (nonatomic , retain)NSArray *placeholderArr;

@property (nonatomic  , retain)AddressInfoFooterView *footerV;

@end

@implementation AddressInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"新增收货地址"];
    [self.view addSubview:nav];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea-kWidth(42)-kWidth(60)) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[AddressInfoTableViewCell class] forCellReuseIdentifier:NSStringFromClass([AddressInfoTableViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager WhiteColor];
    
    AddressInfoFooterView *footerV = [[AddressInfoFooterView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(190))];
    self.tableView.tableFooterView = footerV;
    
    
    [self.view addSubview:self.tableView];
    
    UIButton *saveBtn = [[UIButton alloc]init];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = kFont(14);
    saveBtn.backgroundColor = [ColorManager MainColor];
    saveBtn.layer.cornerRadius = kWidth(21);
    [saveBtn addTarget:self action:@selector(saveAddressClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.mas_offset(kWidth(-20)-kHeight_SafeArea);
        make.width.mas_offset(kWidth(350));
        make.height.mas_offset(kWidth(42));
    }];
    
    self.titleArr = @[@[@"收货人",@"手机号",@"收货地址",@"门牌号",@""],@[@"姓名",@"身份证号"]];
    self.placeholderArr = @[@[@"您的姓名",@"您的手机号",@"小区/写字楼/学校",@"例：8号楼808室",@""],@[@"请输入姓名",@"请输入身份证号"]];
}
-(void)saveAddressClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AddressInfoTableViewCell class])];
    if (!cell) {
        cell = [[AddressInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([AddressInfoTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleLab.text = self.titleArr[indexPath.section][indexPath.row];
    cell.infoTextField.placeholder = self.placeholderArr[indexPath.section][indexPath.row];
    
    if (indexPath.section == 0 && indexPath.row == 4) {
        cell.titleLab.hidden = YES;
        cell.infoTextField.hidden = YES;
        cell.arrowImgV.hidden = YES;
        cell.defaultImgV.hidden = NO;
        cell.defaultLab.hidden = NO;
    }else{
        cell.titleLab.hidden = NO;
        cell.infoTextField.hidden = NO;
        cell.arrowImgV.hidden = YES;
        cell.defaultImgV.hidden = YES;
        cell.defaultLab.hidden = YES;
        
        if (indexPath.section == 0 && indexPath.row == 2) {
            cell.arrowImgV.hidden = NO;
        }
    }
    
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
    }
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return kWidth(48);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
