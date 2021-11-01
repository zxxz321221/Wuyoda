//
//  EvaluateViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/13.
//

#import "EvaluateViewController.h"
#import "QuestionnaireStarView.h"
#import "GoodEvaluateScoreTableViewCell.h"
#import "EvaluateInfoTableViewCell.h"
#import "EvaluateImageTableViewCell.h"


@interface EvaluateViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic , retain)UITableView *tableView;

@end

@implementation EvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"评价晒单"];
    [self.view addSubview:nav];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[GoodEvaluateScoreTableViewCell class] forCellReuseIdentifier:NSStringFromClass([GoodEvaluateScoreTableViewCell class])];
    [self.tableView registerClass:[EvaluateInfoTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EvaluateInfoTableViewCell class])];
    [self.tableView registerClass:[EvaluateImageTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EvaluateImageTableViewCell class])];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager WhiteColor];
    
    
    [self.view addSubview:self.tableView];
    
    
    UIButton *saveBtn = [[UIButton alloc]init];
    [saveBtn setTitle:@"提交" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    saveBtn .titleLabel.font = kFont(14);
    saveBtn.backgroundColor= [ColorManager MainColor];
    saveBtn.layer.cornerRadius = kWidth(24);
    [self.view addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.mas_offset(kWidth(321));
        make.height.mas_offset(kWidth(48));
        make.bottom.mas_offset(-kHeight_SafeArea-kWidth(15));
    }];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==1) {
        EvaluateInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EvaluateInfoTableViewCell class])];
        if (!cell) {
            cell = [[EvaluateInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([EvaluateInfoTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if (indexPath.section == 2){
        EvaluateImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EvaluateImageTableViewCell class])];
        if (!cell) {
            cell = [[EvaluateImageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([EvaluateImageTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        GoodEvaluateScoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GoodEvaluateScoreTableViewCell class])];
        if (!cell) {
            cell = [[GoodEvaluateScoreTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([GoodEvaluateScoreTableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section == 0) {
            cell.showLine = YES;
            cell.titleLab.text = @"商品评分";
        }else{
            cell.showLine = NO;
            if (indexPath.row == 0) {
                cell.titleLab.text = @"快递包装";
            }
            if (indexPath.row == 1) {
                cell.titleLab.text = @"送货速度";
            }
            if (indexPath.row == 2) {
                cell.titleLab.text = @"服务态度";
            }
        }
        
        return cell;
    }
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 3) {
        return 3;
    }
    return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return kWidth(98);
    }else if (indexPath.section == 2){
        return kWidth(118);
    }
    return kWidth(60);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
