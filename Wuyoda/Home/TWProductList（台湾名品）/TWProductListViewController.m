//
//  TWProductListViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/17.
//

#import "TWProductListViewController.h"
#import "TWProductListSearchNavView.h"
#import "TWProductListHeaderView.h"
#import "TWProductListTableViewCell.h"

@interface TWProductListViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate>

@property (nonatomic , retain)UITableView *tableView;
@property (nonatomic , retain)TWProductListHeaderView *tableHeaderV;

@property (nonatomic , assign)BOOL isSearch;

@end

@implementation TWProductListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createNav];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea) style:UITableViewStyleGrouped];
    if ([self.type isEqualToString:@"1"]) {
        self.tableView.frame = CGRectMake(0, kHeight_StatusBar+kWidth(78), kScreenWidth, kScreenHeight-kHeight_StatusBar-kWidth(78-kHeight_SafeArea));
    }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[TWProductListTableViewCell class] forCellReuseIdentifier:NSStringFromClass([TWProductListTableViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager WhiteColor];
    
    self.tableHeaderV = [[TWProductListHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(120))];
    self.tableView.tableHeaderView = self.tableHeaderV;
    
    [self.view addSubview:self.tableView];
    
}

-(void)createNav{
    if ([self.type isEqualToString:@"1"]) {
        TWProductListSearchNavView *nav = [[TWProductListSearchNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_StatusBar+kWidth(78))];
        nav.searField.delegate = self;
        [self.view addSubview:nav];
    }else if ([self.type isEqualToString:@"2"]){
        FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"台湾名品"];
        [self.view addSubview:nav];
    }else{
        FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"宝岛礼盒"];
        [self.view addSubview:nav];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TWProductListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TWProductListTableViewCell class]) forIndexPath:indexPath];
    if (!cell) {
        cell = [[TWProductListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TWProductListTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.imgName = [NSString stringWithFormat:@"search_good%ld",indexPath.row+1];
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.isSearch) {
        return 1;
    }
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kWidth(358);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kWidth(46);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(46))];
    headerV.backgroundColor = [ColorManager WhiteColor];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"300优质推荐商品";
    titleLab.textColor = [ColorManager BlackColor];
    titleLab.font = kFont(24);
    [headerV addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.mas_offset(0);
    }];
    
    return headerV;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    self.isSearch = YES;
    [self.tableView reloadData];
    return YES;
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
