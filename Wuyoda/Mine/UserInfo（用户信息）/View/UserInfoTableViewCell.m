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
    self.titleLab.textColor = [ColorManager BlackColor];
    self.titleLab.font = kFont(14);
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.mas_offset(kWidth(24));
    }];
    
    self.infoTextField = [[UITextField alloc]init];
    self.infoTextField.textColor = [ColorManager Color666666];
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
    [self.manBtn setTitleColor:[ColorManager Color666666] forState:UIControlStateNormal];
    [self.manBtn setImage:kGetImage(@"编辑资料-未选中") forState:UIControlStateNormal];
    [self.manBtn setImage:kGetImage(@"编辑资料—选中") forState:UIControlStateSelected];
    self.manBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, kWidth(10));
    self.manBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.manBtn.titleLabel.font = kFont(14);
    [self.contentView addSubview:self.manBtn];
    [self.manBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(104));
        make.centerY.equalTo(self.contentView);
        make.width.mas_offset(kWidth(55));
        make.height.mas_offset(kWidth(16));
    }];
    self.manBtn.titleEdgeInsets = UIEdgeInsetsMake(0, kWidth(5), 0, 0);
    self.manBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, kWidth(35));
    
    self.womenBtn = [[UIButton alloc]init];
    [self.womenBtn setTitle:@"女士" forState:UIControlStateNormal];
    [self.womenBtn setTitleColor:[ColorManager Color666666] forState:UIControlStateNormal];
    [self.womenBtn setImage:kGetImage(@"编辑资料-未选中") forState:UIControlStateNormal];
    [self.womenBtn setImage:kGetImage(@"编辑资料—选中") forState:UIControlStateSelected];
    self.womenBtn.titleLabel.font = kFont(14);
    self.womenBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, kWidth(10));
    self.womenBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.contentView addSubview:self.womenBtn];
    [self.womenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(172));
        make.centerY.equalTo(self.contentView);
        make.width.mas_offset(kWidth(55));
        make.height.mas_offset(kWidth(16));
    }];
    self.womenBtn.titleEdgeInsets = UIEdgeInsetsMake(0, kWidth(5), 0, 0);
    self.womenBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, kWidth(35));
    
    UIView *topLine = [[UIView alloc]init];
    topLine.backgroundColor = [ColorManager ColorF2F2F2];
    [self.contentView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
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
