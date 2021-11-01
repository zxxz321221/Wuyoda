//
//  HomeSearchAllCityTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/16.
//

#import "HomeSearchAllCityTableViewCell.h"

@interface HomeSearchAllCityTableViewCell ()

@property (nonatomic , retain)UILabel *cityLab;

@end

@implementation HomeSearchAllCityTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cityLab = [[UILabel alloc]init];
        self.cityLab.text = @"中正、万华";
        self.cityLab.textColor = [ColorManager BlackColor];
        self.cityLab.font = kFont(14);
        [self.contentView addSubview:self.cityLab];
        [self.cityLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(kWidth(20));
            make.centerY.equalTo(self.contentView);
        }];
    }
    
    return self;
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
