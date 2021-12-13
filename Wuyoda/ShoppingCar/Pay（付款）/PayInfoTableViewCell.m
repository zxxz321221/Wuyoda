//
//  PayInfoTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/11/11.
//

#import "PayInfoTableViewCell.h"

@implementation PayInfoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.textColor = [ColorManager Color666666];
    self.titleLab.font = kFont(14);
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(24));
        make.centerY.equalTo(self.contentView);
    }];
    
    self.infoLab = [[UILabel alloc]init];
    self.infoLab.textColor = [ColorManager Color333333];
    self.infoLab.font = kFont(14);
    [self.contentView addSubview:self.infoLab];
    [self.infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(100));
        make.centerY.equalTo(self.contentView);
    }];
    
    self.infoTextField = [[UITextField alloc]init];
    self.infoTextField.textColor = [ColorManager Color333333];
    self.infoTextField.font = kFont(14);
    [self.contentView addSubview:self.infoTextField];
    [self.infoTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(100));
        make.centerY.equalTo(self.contentView);
        make.right.mas_offset(kWidth(-100));
        make.height.mas_offset(kWidth(50));
    }];
    
    self.yinlianBtn = [[UIButton alloc]init];
    [self.yinlianBtn setTitle:@"银联支付" forState:UIControlStateNormal];
    [self.yinlianBtn setTitleColor:[ColorManager Color333333] forState:UIControlStateNormal];
    [self.yinlianBtn setImage:kGetImage(@"选择") forState:UIControlStateNormal];
    [self.yinlianBtn setImage:kGetImage(@"选中") forState:UIControlStateSelected];
    self.yinlianBtn.titleLabel.font = kFont(14);
    [self.yinlianBtn addTarget:self action:@selector(changePayTypeClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.yinlianBtn];
    [self.yinlianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(100));
        make.centerY.equalTo(self.contentView);
        make.width.mas_offset(kWidth(80));
        make.height.mas_offset(kWidth(50));
    }];
    
    self.xinYongkaBtn = [[UIButton alloc]init];
    [self.xinYongkaBtn setTitle:@"信用卡支付" forState:UIControlStateNormal];
    [self.xinYongkaBtn setTitleColor:[ColorManager Color333333] forState:UIControlStateNormal];
    [self.xinYongkaBtn setImage:kGetImage(@"选择") forState:UIControlStateNormal];
    [self.xinYongkaBtn setImage:kGetImage(@"选中") forState:UIControlStateSelected];
    self.xinYongkaBtn.titleLabel.font = kFont(14);
    [self.xinYongkaBtn addTarget:self action:@selector(changePayTypeClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.xinYongkaBtn];
    [self.xinYongkaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.yinlianBtn.mas_right).mas_offset(kWidth(30));
        make.centerY.equalTo(self.contentView);
        make.width.mas_offset(kWidth(95));
        make.height.mas_offset(kWidth(50));
    }];
    
    self.yearBtn = [[UIButton alloc] init];
    [self.yearBtn setTitle:@"21" forState:UIControlStateNormal];
    [self.yearBtn setTitleColor:[ColorManager Color333333] forState:UIControlStateNormal];
    self.yearBtn.titleLabel.font = kFont(14);
    self.yearBtn.layer.borderColor = [ColorManager Color777777].CGColor;
    self.yearBtn.layer.borderWidth = kWidth(1);
    [self.contentView addSubview:self.yearBtn];
    [self.yearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(100));
        make.centerY.equalTo(self.contentView);
        make.width.mas_offset(kWidth(46));
        make.height.mas_offset(kWidth(24));
    }];
    self.yearLab = [[UILabel alloc]init];
    self.yearLab.text = @"年";
    self.yearLab.textColor = [ColorManager Color333333];
    self.yearLab.font = kFont(14);
    [self.contentView addSubview:self.yearLab];
    [self.yearLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.yearBtn.mas_right).mas_offset(kWidth(10));
        make.centerY.equalTo(self.contentView);
    }];
    
    self.monthBtn = [[UIButton alloc] init];
    [self.monthBtn setTitle:@"21" forState:UIControlStateNormal];
    [self.monthBtn setTitleColor:[ColorManager Color333333] forState:UIControlStateNormal];
    self.monthBtn.titleLabel.font = kFont(14);
    self.monthBtn.layer.borderColor = [ColorManager Color777777].CGColor;
    self.monthBtn.layer.borderWidth = kWidth(1);
    [self.contentView addSubview:self.monthBtn];
    [self.monthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.yearLab.mas_right).mas_offset(kWidth(10));
        make.centerY.equalTo(self.contentView);
        make.width.mas_offset(kWidth(46));
        make.height.mas_offset(kWidth(24));
    }];
    self.monthLab = [[UILabel alloc]init];
    self.monthLab.text = @"月";
    self.monthLab.textColor = [ColorManager Color333333];
    self.monthLab.font = kFont(14);
    [self.contentView addSubview:self.monthLab];
    [self.monthLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.monthBtn.mas_right).mas_offset(kWidth(10));
        make.centerY.equalTo(self.contentView);
    }];
    
    self.getCodeBtn = [[UIButton alloc]init];
    [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.getCodeBtn setTitleColor:[ColorManager MainColor] forState:UIControlStateNormal];
    self.getCodeBtn.titleLabel.font = kFont(14);
    
    [self.contentView addSubview:self.getCodeBtn];
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-24));
        make.centerY.equalTo(self.contentView);
        make.width.mas_offset(kWidth(80));
        make.height.mas_offset(kWidth(50));
    }];
}

-(void)changePayTypeClicked:(UIButton *)sender{
    sender.selected = YES;
    if (sender == self.yinlianBtn) {
        self.xinYongkaBtn.selected = NO;
        if (self.delegate && [self.delegate respondsToSelector:@selector(updatePayType:)]) {
            [self.delegate updatePayType:@"DEBIT_CARD"];
        }
    }else{
        self.yinlianBtn.selected = NO;
        if (self.delegate && [self.delegate respondsToSelector:@selector(updatePayType:)]) {
            [self.delegate updatePayType:@"CREDIT_CARD"];
        }
    }
}

-(void)setPayType:(NSString *)payType{
    _payType = payType;
    if ([payType isEqualToString:@"DEBIT_CARD"]) {
        self.yinlianBtn.selected = YES;
        self.xinYongkaBtn.selected = NO;
    }else{
        self.xinYongkaBtn.selected = YES;
        self.yinlianBtn.selected = NO;
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
