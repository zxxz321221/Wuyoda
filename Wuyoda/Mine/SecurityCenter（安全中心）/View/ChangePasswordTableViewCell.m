//
//  ChangePasswordTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/9.
//

#import "ChangePasswordTableViewCell.h"

@implementation ChangePasswordTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    
    return self;
}

-(void)createUI{
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.textColor = [ColorManager Color333333];
    self.titleLab.font = kFont(14);
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.mas_offset(kWidth(24));
    }];
    
    self.infoTextField = [[UITextField alloc]init];
    self.infoTextField.textColor = [ColorManager Color333333];
    self.infoTextField.font = kFont(14);
    [self.contentView addSubview:self.infoTextField];
    [self.infoTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.mas_offset(kWidth(98));
        make.right.mas_offset(kWidth(-70));
        make.height.mas_offset(kWidth(24));
    }];
    
    self.getCodeBtn = [[UIButton alloc]init];
    [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.getCodeBtn setTitleColor:[ColorManager MainColor] forState:UIControlStateNormal];
    self.getCodeBtn.titleLabel.font = kFont(14);
    [self.contentView addSubview:self.getCodeBtn];
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.mas_offset(kWidth(-24));
        make.width.mas_offset(kWidth(75));
        make.height.mas_offset(kWidth(20));
    }];
    
    self.disAppearBtn = [[UIButton alloc]init];
    [self.disAppearBtn setImage:kGetImage(@"") forState:UIControlStateNormal];
    [self.disAppearBtn setImage:kGetImage(@"") forState:UIControlStateSelected];
    [self.contentView addSubview:self.disAppearBtn];
    [self.disAppearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.mas_offset(kWidth(-24));
        make.width.height.mas_offset(kWidth(12));
    }];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = [ColorManager ColorF2F2F2];
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_offset(kWidth(1));
    }];
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
