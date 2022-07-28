//
//  OrderDetailBottomView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/28.
//

#import "OrderDetailBottomView.h"

@implementation OrderDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    UIView *topLine = [[UIView alloc]init];
    topLine.backgroundColor = [ColorManager ColorF2F2F2];
    [self addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.equalTo(self);
        make.height.mas_offset(kWidth(1));
    }];
    
    self.payBtn = [[UIButton alloc]init];
    [self.payBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [self.payBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    self.payBtn.titleLabel.font = kFont(14);
    [self.payBtn setBackgroundImage:kGetImage(@"提交订单") forState:UIControlStateNormal];
    self.payBtn.layer.cornerRadius = kWidth(20);
    [self addSubview:self.payBtn];
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-20));
        make.top.mas_offset(kWidth(10));
        make.width.mas_offset(kWidth(88));
        make.height.mas_offset(kWidth(40));
    }];
    
    self.allPriceLab = [[UILabel alloc]init];
    self.allPriceLab.text = @"￥0.00";
    self.allPriceLab.textColor = [ColorManager ColorFE3C3D];
    self.allPriceLab.font = kBoldFont(20);
    [self addSubview:self.allPriceLab];
    [self.allPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.payBtn.mas_left).mas_offset(kWidth(-10));
        make.centerY.equalTo(self.payBtn);
    }];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"合计：";
    titleLab.textColor = [ColorManager Color333333];
    titleLab.font = kBoldFont(14);
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.allPriceLab.mas_left).mas_offset(kWidth(-20));
        make.centerY.equalTo(self.payBtn);
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
