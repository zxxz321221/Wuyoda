//
//  ChangeOrderAddressHeaderView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/12.
//

#import "ChangeOrderAddressHeaderView.h"

@interface ChangeOrderAddressHeaderView ()

@property (nonatomic , retain)UILabel *nameLab;

@property (nonatomic , retain)UILabel *phoneLab;

@property (nonatomic , retain)UILabel *addressLab;

@end

@implementation ChangeOrderAddressHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.backgroundColor = [ColorManager WhiteColor];
    
    UILabel *oldTitleLab = [[UILabel alloc]init];
    oldTitleLab.text = @"原地址：";
    oldTitleLab.textColor = [ColorManager BlackColor];
    oldTitleLab.font = kBoldFont(18);
    [self addSubview:oldTitleLab];
    [oldTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.mas_offset(kWidth(20));
    }];
    
    self.addressLab = [[UILabel alloc]init];
    self.addressLab.text = @"辽宁省大连市沙河口区中山路588-24-8";
    self.addressLab.textColor = [ColorManager BlackColor];
    self.addressLab.font = kFont(14);
    [self addSubview:self.addressLab];
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.right.mas_offset(kWidth(-23));
        make.top.equalTo(oldTitleLab.mas_bottom).mas_offset(kWidth(20));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.text = @"张三";
    self.nameLab.textColor = [ColorManager BlackColor];
    self.nameLab.font = kFont(16);
    [self addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.equalTo(self.addressLab.mas_bottom).mas_offset(kWidth(20));
    }];
    
    self.phoneLab = [[UILabel alloc]init];
    self.phoneLab.text = @"156****1245";
    self.phoneLab.textColor = [ColorManager BlackColor];
    self.phoneLab.font = kFont(16);
    [self addSubview:self.phoneLab];
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLab.mas_right).mas_offset(kWidth(5));
        make.centerY.equalTo(self.nameLab);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [ColorManager ColorF2F2F2];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self);
        make.top.mas_offset(kWidth(130));
        make.height.mas_offset(kWidth(5));
    }];
    
    UILabel *newTitleLab = [[UILabel alloc]init];
    newTitleLab.text = @"选择新的收货地址";
    newTitleLab.textColor = [ColorManager BlackColor];
    newTitleLab.font = kBoldFont(18);
    [self addSubview:newTitleLab];
    [newTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.equalTo(line.mas_bottom).mas_offset(kWidth(25));
    }];
    
    self.addBtn = [[UIButton alloc]init];
    [self.addBtn setTitle:@"添加新地址" forState:UIControlStateNormal];
    [self.addBtn setTitleColor:[ColorManager ColorFB9A3A] forState:UIControlStateNormal];
    self.addBtn.titleLabel.font = kFont(14);
    [self addSubview:self.addBtn];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-20));
        make.bottom.equalTo(newTitleLab);
        make.width.mas_offset(kWidth(85));
        make.height.mas_offset(kWidth(18));
    }];
    
}

-(void)setOrderListModel:(OrderListModel *)orderListModel{
    self.addressLab.text = orderListModel.address;
    self.nameLab.text = orderListModel.pay_name;
    self.phoneLab.text = orderListModel.mobile;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
