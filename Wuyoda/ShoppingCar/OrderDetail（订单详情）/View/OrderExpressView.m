//
//  OrderExpressView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/12/8.
//

#import "OrderExpressView.h"

@interface OrderExpressView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic ,retain)UIView *bgView;

@property (nonatomic ,retain)UIPickerView *pickerView;

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
    
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height, kScreenWidth, kWidth(210))];
    self.bgView.cornerRadius = kWidth(10);
    self.bgView.backgroundColor = [ColorManager WhiteColor];
    [self addSubview:self.bgView];
    
    UIButton *doneBtn = [[UIButton alloc]init];
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[ColorManager Color7F7F7F] forState:UIControlStateNormal];
    doneBtn.titleLabel.font = kFont(14);
    [doneBtn addTarget:self action:@selector(selectExpressClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:doneBtn];
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-15));
        make.top.mas_offset(0);
        make.width.height.mas_offset(kWidth(40));
    }];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, kWidth(40), kScreenWidth, kWidth(1))];
    line.backgroundColor = [ColorManager ColorF2F2F2];
    [self.bgView addSubview:line];
    
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, kWidth(40), kScreenWidth, self.bgView.bounds.size.height-kWidth(50))];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self.bgView addSubview:self.pickerView];
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
        self.bgView.frame = CGRectMake(0, self.bounds.size.height-kWidth(200), kScreenWidth, kWidth(210));
    }];
}

-(void)close{
    [UIView animateWithDuration:0.5 animations:^{
            self.bgView.frame = CGRectMake(0, self.bounds.size.height, kScreenWidth, kWidth(210));
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.shipList.count;
}

//-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    NSDictionary *shipDic = [self.shipList objectAtIndex:row];
//    return [shipDic valueForKey:@"name"];
//}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    NSDictionary *shipDic = [self.shipList objectAtIndex:row];
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(30))];
    titleLab.text = [shipDic valueForKey:@"name"];
    titleLab.textColor = [ColorManager MainColor];
    titleLab.font = kBoldFont(16);
    titleLab.textAlignment = NSTextAlignmentCenter;
    
    return titleLab;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.shipDic = [self.shipList objectAtIndex:row];
}

-(void)setShipList:(NSArray *)shipList{
    _shipList = shipList;
    self.shipDic = [shipList firstObject];
    [self.pickerView reloadComponent:0];
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
