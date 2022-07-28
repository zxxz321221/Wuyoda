//
//  OrderExpressView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/12/8.
//

#import "OrderExpressView.h"
#import "OrderExpressTableViewCell.h"

@interface OrderExpressView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,retain)UIView *bgView;

@property (nonatomic ,retain)UITableView *tableView;

@property (nonatomic ,retain)NSDictionary *shipDic;

@end

@implementation OrderExpressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    UIView *shadowView = [[UIView alloc]initWithFrame:self.bounds];
    shadowView.backgroundColor = [ColorManager BlackColor];
    shadowView.alpha = 0.5;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
    [shadowView addGestureRecognizer:tap];
    [self addSubview:shadowView];
    
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height, kScreenWidth, kWidth(392))];
    self.bgView.cornerRadius = kWidth(10);
    self.bgView.backgroundColor = [ColorManager ColorF7F7F7];
    [self addSubview:self.bgView];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"运输方式";
    titleLab.textColor = [ColorManager BlackColor];
    titleLab.font = kFont(16);
    [self.bgView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView);
        make.top.mas_offset(kWidth(20));
    }];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kWidth(60), kScreenWidth, self.bgView.bounds.size.height-kWidth(60)-kWidth(70)-kHeight_SafeArea) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [ColorManager ColorF7F7F7];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[OrderExpressTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderExpressTableViewCell class])];
    [self.bgView addSubview:self.tableView];
    
    
    UIButton *doneBtn = [[UIButton alloc]init];
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    [doneBtn setBackgroundImage:kGetImage(@"login_按钮") forState:UIControlStateNormal];
    doneBtn.titleLabel.font = kFont(16);
    [doneBtn addTarget:self action:@selector(selectExpressClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:doneBtn];
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView);
        make.bottom.mas_offset(kWidth(-20)-kHeight_SafeArea);
        make.width.mas_offset(kWidth(335));
        make.height.mas_offset(kWidth(48));
    }];
    
}

-(void)selectExpressClicked:(id)sender{
    if (self.shipDic) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectOrderExpress:)]) {
            [self.delegate selectOrderExpress:self.shipDic];
        }
    }
}

- (void)show{
    [UIView animateWithDuration:0.5 animations:^{
        self.bgView.frame = CGRectMake(0, self.bounds.size.height-kWidth(382), kScreenWidth, kWidth(392));
    }];
}

-(void)close{
    [UIView animateWithDuration:0.5 animations:^{
            self.bgView.frame = CGRectMake(0, self.bounds.size.height, kScreenWidth, kWidth(392));
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderExpressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderExpressTableViewCell class]) forIndexPath:indexPath];
    if (!cell) {
        cell = [[OrderExpressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([OrderExpressTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [ColorManager ColorF7F7F7];
    
    cell.shipDic = [self.shipList objectAtIndex:indexPath.row];
    
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.shipList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kWidth(35);
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
    self.shipDic = [self.shipList objectAtIndex:indexPath.row];
}

-(void)setShipList:(NSArray *)shipList{
    _shipList = shipList;
    self.shipDic = [shipList firstObject];
    [self.tableView reloadData];
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}

//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"expressTableCell" forIndexPath:indexPath];
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"expressTableCell"];
//    }
//    cell.backgroundColor = [ColorManager ColorF2F2F2];
//    NSDictionary *shipDic = [self.shipList objectAtIndex:indexPath.row];
//    cell.textLabel.text = [shipDic valueForKey:@"name"];
//
//    return cell;
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSDictionary *shipDic = [self.shipList objectAtIndex:indexPath.row];
//    if (self.delegate && [self.delegate respondsToSelector:@selector(selectOrderExpress:)]) {
//        [self.delegate selectOrderExpress:shipDic];
//    }
//
//    [self removeFromSuperview];
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
