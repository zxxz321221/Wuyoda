//
//  UserInfoTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/8.
//

#import "UserInfoTableViewCell.h"

@implementation UserInfoTableViewCell

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
    self.infoTextField.textColor = [ColorManager Color777777];
    self.infoTextField.font = kFont(14);
    [self.contentView addSubview:self.infoTextField];
    [self.infoTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.mas_offset(kWidth(106));
        make.right.mas_offset(kWidth(-69));
        make.height.mas_offset(kWidth(24));
    }];
    
    self.manBtn = [[UIButton alloc]init];
    [self.manBtn setTitle:@"男士" forState:UIControlStateNormal];
    [self.manBtn setTitleColor:[ColorManager Color777777] forState:UIControlStateNormal];
    [self.manBtn setImage:kGetImage(@"") forState:UIControlStateNormal];
    [self.manBtn setImage:kGetImage(@"") forState:UIControlStateSelected];
    self.manBtn.titleLabel.font = kFont(14);
    [self.contentView addSubview:self.manBtn];
    [self.manBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(104));
        make.centerY.equalTo(self.contentView);
        make.width.mas_offset(kWidth(55));
        make.height.mas_offset(kWidth(16));
    }];
    
    self.womenBtn = [[UIButton alloc]init];
    [self.womenBtn setTitle:@"女士" forState:UIControlStateNormal];
    [self.womenBtn setTitleColor:[ColorManager Color777777] forState:UIControlStateNormal];
    [self.womenBtn setImage:kGetImage(@"") forState:UIControlStateNormal];
    [self.womenBtn setImage:kGetImage(@"") forState:UIControlStateSelected];
    self.womenBtn.titleLabel.font = kFont(14);
    [self.contentView addSubview:self.womenBtn];
    [self.womenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(172));
        make.centerY.equalTo(self.contentView);
        make.width.mas_offset(kWidth(55));
        make.height.mas_offset(kWidth(16));
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
