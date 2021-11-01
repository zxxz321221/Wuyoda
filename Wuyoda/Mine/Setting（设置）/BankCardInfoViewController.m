//
//  BankCardInfoViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/30.
//

#import "BankCardInfoViewController.h"
#import "AddressInfoTableViewCell.h"
#import "BankCardDefaultTableViewCell.h"

@interface BankCardInfoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)UIView *footerV;

@property (nonatomic , assign)BOOL isEdit;

@end

@implementation BankCardInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"银行卡信息"];
    [self.view addSubview:nav];
    
    UIButton *editBtn = [[UIButton alloc]init];
    [editBtn setTitle:@"修改" forState:UIControlStateNormal];
    [editBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
    editBtn.titleLabel.font = kFont(14);
    [editBtn addTarget:self action:@selector(editClicked) forControlEvents:UIControlEventTouchUpInside];
    [nav addSubview:editBtn];
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-20));
        make.bottom.mas_offset(kWidth(0));
        make.width.mas_offset(kWidth(32));
        make.height.mas_offset(kHeight_NavBar-kHeight_StatusBar);
    }];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[AddressInfoTableViewCell class] forCellReuseIdentifier:NSStringFromClass([AddressInfoTableViewCell class])];
    [self.tableView registerClass:[BankCardDefaultTableViewCell class] forCellReuseIdentifier:NSStringFromClass([BankCardDefaultTableViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager ColorF2F2F2];
    
    self.footerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(100))];
    UIButton *doneBtn = [[UIButton alloc]initWithFrame:CGRectMake(kWidth(27), kWidth(50), kWidth(321), kWidth(48))];
    [doneBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    doneBtn.titleLabel.font = kFont(14);
    doneBtn.layer.cornerRadius = kWidth(24);
    doneBtn.backgroundColor = [ColorManager MainColor];
    [self.footerV addSubview:doneBtn];
    self.tableView.tableFooterView = self.footerV;
    
    [self.view addSubview:self.tableView];
    

}

-(void)editClicked{
    self.isEdit = !self.isEdit;
    if (self.isEdit) {
        self.tableView.tableFooterView = self.footerV;
    }else{

        self.tableView.tableFooterView = nil;
    }
    [self.tableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        AddressInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AddressInfoTableViewCell class])];
        if (!cell) {
            cell = [[AddressInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([AddressInfoTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row == 0) {
            cell.titleLab.text = @"银行名称";
            cell.infoTextField.placeholder = @"请输入银行名称";
        }
        if (indexPath.row == 1) {
            cell.titleLab.text = @"填写备注";
            cell.infoTextField.placeholder = @"请输入备注";
        }
        if (indexPath.row == 2) {
            cell.titleLab.text = @"银行卡号";
            cell.infoTextField.placeholder = @"请输入银行卡号";
        }

        
        return cell;
        
    }else{
        BankCardDefaultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BankCardDefaultTableViewCell class])];
        if (!cell) {
            cell = [[BankCardDefaultTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([BankCardDefaultTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.isEdit = self.isEdit;
        
        return cell;
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return kWidth(52);
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
