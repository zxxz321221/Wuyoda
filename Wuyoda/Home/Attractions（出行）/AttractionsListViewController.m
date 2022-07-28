//
//  AttractionsListViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/18.
//

#import "AttractionsListViewController.h"
#import "AttractionsListNavView.h"
#import "AttractionsListTableViewCell.h"
#import "AttractionDetailViewController.h"
#import "AttractionModel.h"

@interface AttractionsListViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)NSArray *attractionArr;

@property (nonatomic , retain)NSMutableArray *attractionSearchArr;

@end

@implementation AttractionsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AttractionsListNavView *nav = [[AttractionsListNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar)];
    nav.searchField.delegate = self;
    [self.view addSubview:nav];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar+kWidth(20), kScreenWidth, kScreenHeight-kHeight_NavBar-kWidth(20))];
    bgView.backgroundColor = [ColorManager WhiteColor];
    [self.view addSubview:bgView];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(kWidth(10), kWidth(10))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame =  bgView.bounds;
    maskLayer.path = maskPath.CGPath;
    bgView.layer.mask = maskLayer;
    
    self.view.backgroundColor = [ColorManager ColorF2F2F2];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"热门推荐";
    titleLab.textColor = [ColorManager BlackColor];
    titleLab.font = kFont(24);
    [bgView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(kWidth(20));
    }];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kWidth(10)+kWidth(60), kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea-kWidth(10)-kWidth(60)) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [ColorManager ColorF2F2F2];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[AttractionsListTableViewCell class] forCellReuseIdentifier:NSStringFromClass([AttractionsListTableViewCell class])];
    [bgView addSubview:self.tableView];
    
    [self getDataFromServer];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length) {
        [self.attractionSearchArr removeAllObjects];
        for (int i = 0; i<self.attractionArr.count; i++) {
            AttractionModel *model = [self.attractionArr objectAtIndex:i];
            if ([model.scenic_title containsString:textField.text]) {
                [self.attractionSearchArr addObject:model];
            }
        }
    }else{
        self.attractionSearchArr = [self.attractionArr mutableCopy];
    }
    
    [self.tableView reloadData];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *inputWordStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (!inputWordStr.length) {
        self.attractionSearchArr = [self.attractionArr mutableCopy];
        [self.tableView reloadData];
    }
    return YES;
}

-(void)getDataFromServer{
    NSDictionary *dic = @{@"ps_id":self.cityID};
    
    [FJNetTool postWithParams:dic url:Store_scenic_list loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            self.attractionArr = [AttractionModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            self.attractionSearchArr = [self.attractionArr mutableCopy];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AttractionsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AttractionsListTableViewCell class]) forIndexPath:indexPath];
    if (!cell) {
        cell = [[AttractionsListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([AttractionsListTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = [self.attractionSearchArr objectAtIndex:indexPath.row];
    if (indexPath.row == 0) {
        cell.isFirst = YES;
    }else{
        cell.isFirst = NO;
    }
        
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.attractionSearchArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kWidth(170);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AttractionDetailViewController *vc = [[AttractionDetailViewController alloc]init];
    AttractionModel *model = [self.attractionSearchArr objectAtIndex:indexPath.row];
    vc.scenic_id = model.uid;
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
