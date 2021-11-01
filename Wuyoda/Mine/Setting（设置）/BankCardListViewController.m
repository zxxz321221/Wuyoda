//
//  BankCardListViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/29.
//

#import "BankCardListViewController.h"
#import "BankCardListTableViewCell.h"
#import "BankCardListFooterView.h"
#import "BankCardListBottomView.h"
#import "BankCardInfoViewController.h"

@interface BankCardListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic , retain)UITableView *tableView;
@property (nonatomic , retain)BankCardListFooterView *footerV;
@property (nonatomic , retain)BankCardListBottomView *bottomV;
@property (nonatomic , assign)BOOL isEdit;


@end

@implementation BankCardListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"收款方式"];
    [self.view addSubview:nav];
    
    UIButton *editBtn = [[UIButton alloc]init];
    [editBtn setTitle:@"管理" forState:UIControlStateNormal];
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
    [self.tableView registerClass:[BankCardListTableViewCell class] forCellReuseIdentifier:NSStringFromClass([BankCardListTableViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager ColorF2F2F2];
    
    self.footerV = [[BankCardListFooterView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(70))];
    self.tableView.tableFooterView = self.footerV;
    
    [self.view addSubview:self.tableView];
    
    self.bottomV = [[BankCardListBottomView alloc]init];
    self.bottomV.hidden = YES;
    [self.view addSubview:self.bottomV];
    [self.bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.view);
        make.bottom.mas_offset(-kHeight_SafeArea);
        make.height.mas_offset(kWidth(60));
        
    }];
    
}

-(void)editClicked{
    self.isEdit = !self.isEdit;
    if (self.isEdit) {
        self.bottomV.hidden = NO;
        self.tableView.frame = CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea-kWidth(60));
        self.tableView.tableFooterView = nil;
    }else{
        self.bottomV.hidden = YES;
        self.tableView.frame = CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea);
        self.tableView.tableFooterView = self.footerV;
    }
    [self.tableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BankCardListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BankCardListTableViewCell class])];
    if (!cell) {
        cell = [[BankCardListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([BankCardListTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.isEdit = self.isEdit;
    
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return kWidth(90);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return kWidth(16);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return [UIView new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BankCardInfoViewController *vc = [[BankCardInfoViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
