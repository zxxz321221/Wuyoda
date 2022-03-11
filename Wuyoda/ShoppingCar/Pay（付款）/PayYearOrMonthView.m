//
//  PayYearOrMonthView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/11/12.
//

#import "PayYearOrMonthView.h"

@interface PayYearOrMonthView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic ,retain)UIView *bgView;

@property (nonatomic ,retain)UIPickerView *pickerView;

@property (nonatomic ,copy)NSString *dateStr;

@end

@implementation PayYearOrMonthView

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
    if (self.dateStr) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectPayDate:Type:)]) {
            [self.delegate selectPayDate:self.dateStr Type:self.type];
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
    return self.dateArr.count;
}

//-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    NSDictionary *shipDic = [self.shipList objectAtIndex:row];
//    return [shipDic valueForKey:@"name"];
//}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(30))];
    titleLab.text = [self.dateArr objectAtIndex:row];
    titleLab.textColor = [ColorManager MainColor];
    titleLab.font = kBoldFont(16);
    titleLab.textAlignment = NSTextAlignmentCenter;
    
    return titleLab;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.dateStr = [self.dateArr objectAtIndex:row];
}


-(void)setDateArr:(NSArray *)dateArr{
    _dateArr = dateArr;
    self.dateStr = [dateArr firstObject];
    [self.pickerView reloadComponent:0];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dateListCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"dateListCell"];
    }
    
    cell.textLabel.text = [self.dateArr objectAtIndex:indexPath.row];
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dateArr.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
