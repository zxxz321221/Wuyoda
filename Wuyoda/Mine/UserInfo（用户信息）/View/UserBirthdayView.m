//
//  UserBirthdayView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/12/14.
//

#import "UserBirthdayView.h"

@interface UserBirthdayView ()

@property (nonatomic ,retain)UIView *bgView;

@property (nonatomic ,retain)UIDatePicker *pickerView;

@property (nonatomic ,retain)NSString *dateStr;

@end

@implementation UserBirthdayView

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
    [doneBtn addTarget:self action:@selector(selectDateClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:doneBtn];
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-15));
        make.top.mas_offset(0);
        make.width.height.mas_offset(kWidth(40));
    }];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, kWidth(40), kScreenWidth, kWidth(1))];
    line.backgroundColor = [ColorManager ColorF2F2F2];
    [self.bgView addSubview:line];
    
    self.pickerView = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, kWidth(40), kScreenWidth, self.bgView.bounds.size.height-kWidth(50))];
//    self.pickerView.delegate = self;
//    self.pickerView.dataSource = self;
    self.pickerView.datePickerMode = UIDatePickerModeDate;
    if (@available(iOS 13.4, *)) {
        self.pickerView.preferredDatePickerStyle = UIDatePickerStyleWheels;
    } else {
        // Fallback on earlier versions
    }
    [self.pickerView addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    if (@available(iOS 13.0, *)) {
        [self.pickerView setDate:[NSDate date] animated:YES];
    } else {
        // Fallback on earlier versions
    }
    [self.pickerView setMaximumDate:[NSDate date]];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文
    self.pickerView.locale = locale;
    [self.bgView addSubview:self.pickerView];
    self.dateStr = [CommonManager getCurrentDateOfYearMonthDay:[NSDate date]];
}

-(void)selectDateClicked:(id)sender{
    if (self.dateStr) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectUserBirthday:)]) {
            [self.delegate selectUserBirthday:self.dateStr];
        }
    }
}

-(void)dateChange:(UIDatePicker *)pickerV {
    self.dateStr = [CommonManager getCurrentDateOfYearMonthDay:pickerV.date];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
