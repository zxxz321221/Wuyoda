//
//  AboutTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/8.
//

#import "AboutTableViewCell.h"

@implementation AboutTableViewCell

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
    
    UIImageView *arrowImgV = [[UIImageView alloc]initWithImage:kGetImage(@"箭头_深")];
    arrowImgV.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:arrowImgV];
    [arrowImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-24));
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_offset(kWidth(16));
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
