//
//  BankCardDefaultTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/30.
//

#import "BankCardDefaultTableViewCell.h"

@implementation BankCardDefaultTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    
    return self;
}

-(void)createUI{
    self.selectImgV = [[UIImageView alloc]initWithImage:kGetImage(@"选择")];
    [self.contentView addSubview:self.selectImgV];
    [self.selectImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(24));
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_offset(kWidth(20));
    }];
    
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.text = @"默认银行卡";
    self.titleLab.textColor = [ColorManager Color333333];
    self.titleLab.font = kFont(14);
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(24));
        make.centerY.equalTo(self.contentView);
    }];
}

-(void)setIsEdit:(BOOL)isEdit{
    if (isEdit) {
        self.selectImgV.hidden = NO;
        self.titleLab.text = @"设置为默认银行卡";
        [self.titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(kWidth(52));
        }];
    }else{
        self.selectImgV.hidden = YES;
        self.titleLab.text = @"默认银行卡";
        [self.titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(kWidth(24));
        }];
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
