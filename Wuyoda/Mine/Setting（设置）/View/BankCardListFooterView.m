//
//  BankCardListFooterView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/29.
//

#import "BankCardListFooterView.h"

@implementation BankCardListFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(kWidth(23), kWidth(20), kWidth(330), kWidth(50))];
    bgView.backgroundColor = [ColorManager WhiteColor];
    [self addSubview:bgView];
    
    UILabel *addLab = [[UILabel alloc]init];
    addLab.text = @"+";
    addLab.textColor = [ColorManager Color666666];
    addLab.font = kFont(16);
    [bgView addSubview:addLab];
    [addLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(114));
        make.centerY.equalTo(bgView);
    }];
    
    UILabel *addTitleLab = [[UILabel alloc]init];
    addTitleLab.text = @"添加银行卡";
    addTitleLab.textColor = [ColorManager Color008A70];
    addTitleLab.font = kFont(16);
    [bgView addSubview:addTitleLab];
    [addTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addLab.mas_right).mas_offset(kWidth(6));
        make.centerY.equalTo(bgView);
    }];
    
    UIButton *addBtn = [[UIButton alloc]initWithFrame:bgView.bounds];
    [bgView addSubview:addBtn];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
