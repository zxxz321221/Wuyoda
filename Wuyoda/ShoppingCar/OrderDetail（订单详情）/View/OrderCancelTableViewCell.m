//
//  OrderCancelTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/28.
//

#import "OrderCancelTableViewCell.h"


@implementation OrderCancelTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    
    return self;
}

-(void)createUI{
    self.selectImgV = [[UIImageView alloc]initWithImage:kGetImage(@"未选中")];
    [self.contentView addSubview:self.selectImgV];
    [self.selectImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(30));
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_offset(kWidth(16));
    }];
    
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.text = @"商品无货";
    self.titleLab.textColor = [ColorManager Color666666];
    self.titleLab.font = kFont(16);
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(56));
        make.centerY.equalTo(self.contentView);
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

    if (selected) {
        [self.selectImgV setImage:kGetImage(@"选中")];
    }else{
        [self.selectImgV setImage:kGetImage(@"未选中")];
    }
    // Configure the view for the selected state
}

@end
