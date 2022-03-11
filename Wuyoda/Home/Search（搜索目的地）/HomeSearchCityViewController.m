//
//  HomeSearchCityViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/16.
//

#import "HomeSearchCityViewController.h"
#import "HomeSearchAllCityTableViewCell.h"
#import "HomeSearchHotCityView.h"
#import "TWProductListViewController.h"
#import "HomeSearchField.h"

@interface HomeSearchCityViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,HomeSearchHotCitySelectDelegate>

@property (nonatomic , retain)HomeSearchField *searchField;

@property (nonatomic , retain)UIScrollView *areaScrollV;

@property (nonatomic , retain)UIView *scrollLine;

@property (nonatomic , retain)NSMutableArray *areaArr;

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)HomeSearchHotCityView *tableHeaderV;

@property (nonatomic , retain)NSMutableArray *showCityArr;

@end

@implementation HomeSearchCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"选择目的地城市"];
    [self.view addSubview:nav];
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-kWidth(60), kHeight_StatusBar, kWidth(40), kHeight_NavBar-kHeight_StatusBar)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = kFont(14);
    [cancelBtn addTarget:self action:@selector(cancelClicked:) forControlEvents:UIControlEventTouchUpInside];
    [nav addSubview:cancelBtn];
    
    self.searchField = [[HomeSearchField alloc]init];
    self.searchField.placeholder = @"输入城市名称";
    self.searchField.textColor = [ColorManager BlackColor];
    self.searchField.font = kFont(16);
    self.searchField.backgroundColor = [ColorManager ColorF2F2F2];
    self.searchField.layer.cornerRadius = kWidth(5);
    UIImageView *leftV = [[UIImageView alloc]initWithImage:kGetImage(@"搜索")];
    self.searchField.leftView = leftV;
    self.searchField.leftViewMode = UITextFieldViewModeAlways;
    self.searchField.returnKeyType = UIReturnKeyDone;
    self.searchField.delegate = self;
    [self.view addSubview:self.searchField];
    [self.searchField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(nav.mas_bottom).mas_offset(kWidth(26));
        make.width.mas_offset(kWidth(336));
        make.height.mas_offset(kWidth(36));
    }];
    
//    self.areaScrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar+kWidth(85), kScreenWidth, kWidth(40))];
//    [self.view addSubview:self.areaScrollV];
//
//    self.scrollLine = [[UIView alloc]initWithFrame:CGRectMake(kWidth(-40), kWidth(36), kWidth(40), kWidth(4))];
//    self.scrollLine.backgroundColor = [ColorManager MainColor];
//    [self.areaScrollV addSubview:self.scrollLine];
//
//    self.areaArr = [[NSMutableArray alloc]initWithObjects:@"北台湾",@"中台湾",@"南台湾",@"东台湾",@"台湾离岛", nil];
//    for (int i = 0; i<self.areaArr.count; i++) {
//        UIButton *areaBtn = [[UIButton alloc]initWithFrame:CGRectMake(kWidth(20)+kWidth(67)*i, 0, kWidth(67), kWidth(40))];
//        [areaBtn setTitle:[self.areaArr objectAtIndex:i] forState:UIControlStateNormal];
//        areaBtn.titleLabel.font = kFont(14);
//        if (i == 0) {
//            [areaBtn setTitleColor:[ColorManager MainColor] forState:UIControlStateNormal];
//            self.scrollLine.frame = CGRectMake(areaBtn.centerX-kWidth(20), kWidth(36), kWidth(40), kWidth(4));
//        }else{
//            [areaBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
//        }
//        areaBtn.tag = i;
//        [areaBtn addTarget:self action:@selector(changAreaClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [self.areaScrollV addSubview:areaBtn];
//    }
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar+kWidth(72), kScreenWidth, kScreenHeight-kHeight_NavBar-kWidth(72)-kHeight_SafeArea) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[HomeSearchAllCityTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HomeSearchAllCityTableViewCell class])];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableHeaderV = [[HomeSearchHotCityView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(184))];
    self.tableHeaderV.delegate = self;
    self.tableHeaderV.hotCityArr = self.hotCityArr;
    self.tableView.tableHeaderView = self.tableHeaderV;
    
    [self.view addSubview:self.tableView];
    
    self.showCityArr = [self.allCityArr mutableCopy];
}


-(void)cancelClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

//-(BOOL)textFieldShouldReturn:(UITextField *)textField{
//    
//    return YES;
//}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *inputWordStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSLog(@"string:%@",inputWordStr);
    if (inputWordStr.length) {
        NSMutableArray *cityArr = [[NSMutableArray alloc]init];
        for (int i = 0; i<self.allCityArr.count; i++) {
            NSString *city = [self.allCityArr objectAtIndex:i];
            if ([city containsString:inputWordStr]) {
                [cityArr addObject:city];
            }
        }
        self.showCityArr = cityArr;
    }else{
        self.showCityArr = [self.allCityArr mutableCopy];
    }
    
    [self.tableView reloadData];
    return YES;
}

-(void)selectHotCity:(NSString *)city{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectCity:)]) {
        [self.delegate selectCity:city];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)changAreaClicked:(UIButton *)sender{
    for (UIView *v in self.areaScrollV.subviews) {
        if ([v isKindOfClass:[UIButton class]]) {
            if (sender == v) {
                [sender setTitleColor:[ColorManager MainColor] forState:UIControlStateNormal];
                self.scrollLine.frame = CGRectMake(sender.centerX-kWidth(20), kWidth(36), kWidth(40), kWidth(4));
            }else{
                UIButton *areaBtn = (UIButton *)v;
                [areaBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
            }
        }
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.showCityArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeSearchAllCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeSearchAllCityTableViewCell class]) forIndexPath:indexPath];
    if (!cell) {
        cell = [[HomeSearchAllCityTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([HomeSearchAllCityTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.cityLab.text = [self.showCityArr objectAtIndex:indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kWidth(49);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.0001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(36))];
//    headerV.backgroundColor = [ColorManager ColorF2F2F2];
//    UILabel *titleLab = [[UILabel alloc]init];
//    titleLab.text = @"台北市";
//    titleLab.textColor = [ColorManager BlackColor];
//    titleLab.font = kFont(16);
//    [headerV addSubview:titleLab];
//    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(kWidth(20));
//        make.centerY.equalTo(headerV);
//    }];
    
    return [UIView new];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    return [UIView new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectCity:)]) {
        [self.delegate selectCity:self.showCityArr[indexPath.row]];
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
