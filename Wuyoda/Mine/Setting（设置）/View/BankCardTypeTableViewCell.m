//
//  BankCardTypeTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/29.
//

#import "BankCardTypeTableViewCell.h"

@implementation BankCardTypeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    
    return self;
}

-(void)createUI{
    UIImageView *imgV = [[UIImageView alloc]initWithImage:kGetImage(@"银行卡")];
    [self.contentView addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(30));
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_offset(kWidth(18));
    }];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"银行卡";
    titleLab.textColor = [ColorManager Color333333];
    titleLab.font = kFont(16);
    [self.contentView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(56));
        make.centerY.equalTo(self.contentView);
    }];
    
    UIImageView *arrowImgV = [[UIImageView alloc]initWithImage:kGetImage(@"")];
    [self.contentView addSubview:arrowImgV];
    [arrowImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-19));
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_offset(kWidth(16));
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
