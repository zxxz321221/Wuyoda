//
//  AddressInfoTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/27.
//

#import "AddressInfoTableViewCell.h"

@implementation AddressInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
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
        make.left.mas_offset(kWidth(15));
        make.centerY.equalTo(self.contentView);
    }];
    
    self.infoTextField = [[UITextField alloc]init];
    self.infoTextField.textColor = [ColorManager Color666666];
    self.infoTextField.font = kFont(14);
    [self.contentView addSubview:self.infoTextField];
    [self.infoTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(90));
        make.right.mas_offset(kWidth(-36));
        make.centerY.height.equalTo(self.contentView);
    }];
    
    self.defaultImgV = [[UIImageView alloc]init];
    [self.defaultImgV setImage:kGetImage(@"选择")];
    self.defaultImgV.hidden = YES;
    [self.contentView addSubview:self.defaultImgV];
    [self.defaultImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(15));
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_offset(kWidth(18));
    }];
    
    self.defaultLab = [[UILabel alloc]init];
    self.defaultLab.text = @"设置为默认地址";
    self.defaultLab.textColor = [ColorManager Color666666];
    self.defaultLab.font = kFont(14);
    self.defaultLab.hidden = YES;
    [self.contentView addSubview:self.defaultLab];
    [self.defaultLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(48));
        make.centerY.equalTo(self.contentView);
    }];
    
    self.arrowImgV = [[UIImageView alloc]initWithImage:kGetImage(@"")];
    [self.contentView addSubview:self.arrowImgV];
    [self.arrowImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-10));
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_offset(kWidth(16));
    }];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = [ColorManager ColorF2F2F2];
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.width.equalTo(self.contentView);
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
