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
    self.backgroundColor = [ColorManager ColorF2F2F2];
    
    UILabel *oldTitleLab = [[UILabel alloc]init];
    oldTitleLab.text = @"原地址：";
    oldTitleLab.textColor = [ColorManager BlackColor];
    oldTitleLab.font = kBoldFont(18);
    [self addSubview:oldTitleLab];
    [oldTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(23));
        make.top.mas_offset(kWidth(11));
    }];
    
    self.addressLab = [[UILabel alloc]init];
    self.addressLab.text = @"辽宁省大连市沙河口区中山路588-24-8";
    self.addressLab.textColor = [ColorManager BlackColor];
    self.addressLab.font = kFont(16);
    [self addSubview:self.addressLab];
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(23));
        make.right.mas_offset(kWidth(-23));
        make.top.equalTo(oldTitleLab.mas_bottom).mas_offset(kWidth(11));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.text = @"张三";
    self.nameLab.textColor = [ColorManager BlackColor];
    self.nameLab.font = kFont(16);
    [self addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(23));
        make.top.equalTo(self.addressLab.mas_bottom).mas_offset(kWidth(11));
    }];
    
    self.phoneLab = [[UILabel alloc]init];
    self.phoneLab.text = @"156****1245";
    self.phoneLab.textColor = [ColorManager BlackColor];
    self.phoneLab.font = kFont(16);
    [self addSubview:self.phoneLab];
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLab.mas_right).mas_offset(kWidth(5));
        make.top.equalTo(self.addressLab.mas_bottom).mas_offset(kWidth(11));
    }];
    
    UIView *newBgV = [[UIView alloc]initWithFrame:CGRectMake(0, kWidth(127), kScreenWidth, kWidth(93))];
    newBgV.backgroundColor = [ColorManager WhiteColor];
    [self addSubview:newBgV];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:newBgV.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(kWidth(10), kWidth(10))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame =  newBgV.bounds;
    maskLayer.path = maskPath.CGPath;
    newBgV.layer.mask = maskLayer;
    
    UILabel *newTitleLab = [[UILabel alloc]init];
    newTitleLab.text = @"选择新的收货地址";
    newTitleLab.textColor = [ColorManager BlackColor];
    newTitleLab.font = kBoldFont(18);
    [newBgV addSubview:newTitleLab];
    [newTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(25));
        make.top.mas_offset(kWidth(17));
    }];
    
    self.addBtn = [[UIButton alloc]init];
    [self.addBtn setTitle:@"添加新地址" forState:UIControlStateNormal];
    [self.addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.addBtn.titleLabel.font = kFont(16);
    [newBgV addSubview:self.addBtn];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-14));
        make.top.mas_offset(kWidth(21));
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
