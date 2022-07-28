//
//  OrderInfoBottomView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/12.
//

#import "OrderInfoBottomView.h"

@implementation OrderInfoBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.buyAgainBtn = [[UIButton alloc]init];
    [self.buyAgainBtn setTitle:@"再次购买" forState:UIControlStateNormal];
    [self.buyAgainBtn setTitleColor:[ColorManager MainColor] forState:UIControlStateNormal];
    self.buyAgainBtn.titleLabel.font = kFont(12);
    self.buyAgainBtn.layer.borderColor = [ColorManager MainColor].CGColor;
    self.buyAgainBtn.layer.borderWidth = kWidth(1);
    self.buyAgainBtn.layer.cornerRadius = kWidth(14);
    [self addSubview:self.buyAgainBtn];
    [self.buyAgainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-16));
        make.centerY.equalTo(self);
        make.width.mas_offset(kWidth(74));
        make.height.mas_offset(kWidth(28));
    }];
    
    self.payBtn = [[UIButton alloc]init];
    [self.payBtn setTitle:@"立即付款" forState:UIControlStateNormal];
    [self.payBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    self.payBtn.titleLabel.font = kFont(12);
    self.payBtn.layer.cornerRadius = kWidth(14);
    self.payBtn.layer.masksToBounds = YES;
    [self.payBtn setBackgroundImage:kGetImage(@"推荐按钮") forState:UIControlStateNormal];
    [self addSubview:self.payBtn];
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-16));
        make.centerY.equalTo(self);
        make.width.mas_offset(kWidth(74));
        make.height.mas_offset(kWidth(28));
    }];
    
    self.addressBtn = [[UIButton alloc]init];
    [self.addressBtn setTitle:@"修改地址" forState:UIControlStateNormal];
    [self.addressBtn setTitleColor:[ColorManager ColorFB9A3A] forState:UIControlStateNormal];
    self.addressBtn.titleLabel.font = kFont(12);
    self.addressBtn.layer.borderColor = [ColorManager ColorFB9A3A].CGColor;
    self.addressBtn.layer.borderWidth = kWidth(1);
    self.addressBtn.layer.cornerRadius = kWidth(14);
    [self addSubview:self.addressBtn];
    [self.addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-98));
        make.centerY.equalTo(self);
        make.width.mas_offset(kWidth(74));
        make.height.mas_offset(kWidth(28));
    }];
    
    self.cancelBtn = [[UIButton alloc]init];
    [self.cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:[ColorManager Color666666] forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font = kFont(12);
    self.cancelBtn.layer.borderColor = [ColorManager Color666666].CGColor;
    self.cancelBtn.layer.borderWidth = kWidth(1);
    self.cancelBtn.layer.cornerRadius = kWidth(14);
    [self addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-180));
        make.centerY.equalTo(self);
        make.width.mas_offset(kWidth(74));
        make.height.mas_offset(kWidth(28));
    }];
    
    self.doneTakeBtn = [[UIButton alloc]init];
    [self.doneTakeBtn setTitle:@"确认收货" forState:UIControlStateNormal];
    [self.doneTakeBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
    self.doneTakeBtn.titleLabel.font = kFont(12);
    self.doneTakeBtn.layer.borderColor = [ColorManager BlackColor].CGColor;
    self.doneTakeBtn.layer.borderWidth = kWidth(1);
    self.doneTakeBtn.layer.cornerRadius = kWidth(14);
    [self addSubview:self.doneTakeBtn];
    [self.doneTakeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-16));
        make.centerY.equalTo(self);
        make.width.mas_offset(kWidth(74));
        make.height.mas_offset(kWidth(28));
    }];
    
    self.readLogisticsBtn = [[UIButton alloc]init];
    [self.readLogisticsBtn setTitle:@"查看物流" forState:UIControlStateNormal];
    [self.readLogisticsBtn setTitleColor:[ColorManager Color666666] forState:UIControlStateNormal];
    self.readLogisticsBtn.titleLabel.font = kFont(12);
    self.readLogisticsBtn.layer.borderColor = [ColorManager Color666666].CGColor;
    self.readLogisticsBtn.layer.borderWidth = kWidth(1);
    self.readLogisticsBtn.layer.cornerRadius = kWidth(14);
    [self addSubview:self.readLogisticsBtn];
    [self.readLogisticsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-98));
        make.centerY.equalTo(self);
        make.width.mas_offset(kWidth(74));
        make.height.mas_offset(kWidth(28));
    }];
    
    self.finishEvaluateBtn = [[UIButton alloc]init];
    [self.finishEvaluateBtn setTitle:@"评价" forState:UIControlStateNormal];
    [self.finishEvaluateBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
    self.finishEvaluateBtn.titleLabel.font = kFont(12);
    self.finishEvaluateBtn.layer.borderColor = [ColorManager BlackColor].CGColor;
    self.finishEvaluateBtn.layer.borderWidth = kWidth(1);
    self.finishEvaluateBtn.layer.cornerRadius = kWidth(14);
    [self addSubview:self.finishEvaluateBtn];
    [self.finishEvaluateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-98));
        make.centerY.equalTo(self);
        make.width.mas_offset(kWidth(74));
        make.height.mas_offset(kWidth(28));
    }];
    
    self.deleteBtn = [[UIButton alloc]init];
    [self.deleteBtn setTitle:@"删除订单" forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:[ColorManager Color666666] forState:UIControlStateNormal];
    self.deleteBtn.titleLabel.font = kFont(12);
    self.deleteBtn.layer.borderColor = [ColorManager Color666666].CGColor;
    self.deleteBtn.layer.borderWidth = kWidth(1);
    self.deleteBtn.layer.cornerRadius = kWidth(14);
    [self addSubview:self.deleteBtn];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-98));
        make.centerY.equalTo(self);
        make.width.mas_offset(kWidth(74));
        make.height.mas_offset(kWidth(28));
    }];
}

-(void)setType:(NSString *)type{
    //1.待付款 2.已取消 3.已付款 4.已发货 5.已完成 6.已退货
    _type = type;
    self.buyAgainBtn.hidden = YES;
    self.payBtn.hidden = YES;
    self.addressBtn.hidden = YES;
    self.cancelBtn.hidden = YES;
    self.doneTakeBtn.hidden = YES;
    self.readLogisticsBtn.hidden = YES;
    self.finishEvaluateBtn.hidden = YES;
    self.deleteBtn.hidden = YES;
    
    if ([type isEqualToString:@"1"]) {
        self.buyAgainBtn.hidden = YES;
        self.payBtn.hidden = NO;
        self.addressBtn.hidden = NO;
        self.cancelBtn.hidden = NO;
        self.doneTakeBtn.hidden = YES;
        self.readLogisticsBtn.hidden = YES;
        self.finishEvaluateBtn.hidden = YES;
        self.deleteBtn.hidden = YES;
    }
    else if ([type isEqualToString:@"4"]) {
        self.buyAgainBtn.hidden = YES;
        self.payBtn.hidden = YES;
        self.addressBtn.hidden = YES;
        self.cancelBtn.hidden = YES;
        self.doneTakeBtn.hidden = NO;
        self.readLogisticsBtn.hidden = NO;
        self.finishEvaluateBtn.hidden = YES;
        self.deleteBtn.hidden = YES;
    }
    else if ([type isEqualToString:@"5"]) {
        self.buyAgainBtn.hidden = NO;
        self.payBtn.hidden = YES;
        self.addressBtn.hidden = YES;
        self.cancelBtn.hidden = YES;
        self.doneTakeBtn.hidden = YES;
        self.readLogisticsBtn.hidden = YES;
        self.finishEvaluateBtn.hidden = YES;
        self.deleteBtn.hidden = NO;
    }else if ([type isEqualToString:@"3"]) {
        self.buyAgainBtn.hidden = YES;
        self.payBtn.hidden = YES;
        self.addressBtn.hidden = YES;
        self.cancelBtn.hidden = YES;
        self.doneTakeBtn.hidden = NO;
        self.readLogisticsBtn.hidden = YES;
        self.finishEvaluateBtn.hidden = YES;
        self.deleteBtn.hidden = YES;
    }
    else {
        self.buyAgainBtn.hidden = NO;
        self.payBtn.hidden = YES;
        self.addressBtn.hidden = YES;
        self.cancelBtn.hidden = YES;
        self.doneTakeBtn.hidden = YES;
        self.readLogisticsBtn.hidden = YES;
        self.finishEvaluateBtn.hidden = YES;
        self.deleteBtn.hidden = YES;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
