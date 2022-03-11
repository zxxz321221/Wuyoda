//
//  CityLineRecommendTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/22.
//

#import "CityLineRecommendTableViewCell.h"

@interface CityLineRecommendTableViewCell ()

@property (nonatomic , retain)UILabel *nameLab;

@property (nonatomic , retain)UILabel *recommendLab;

@end

@implementation CityLineRecommendTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.text = @"台中经典一日游";
    self.nameLab.textColor = [ColorManager Color333333];
    self.nameLab.font = kBoldFont(14);
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(16));
        make.top.mas_offset(kWidth(15));
    }];
    
    self.recommendLab = [[UILabel alloc]init];
    self.recommendLab.text = @"D1 台中火车站 →彩虹眷村 →东海大学 →东海乳品小栈 →逢甲夜市";
    self.recommendLab.textColor = [ColorManager Color333333];
    self.recommendLab.font = kFont(14);
    self.recommendLab.numberOfLines = 0;
    self.recommendLab.lineBreakMode = NSLineBreakByCharWrapping;
    [self.contentView addSubview:self.recommendLab];
    [self.recommendLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(16));
        make.right.mas_offset(kWidth(-16));
        make.top.equalTo(self.nameLab.mas_bottom).mas_offset(kWidth(10));
    }];
}

-(void)setModel:(CityTripModel *)model{
    self.nameLab.text = model.trip_title;
    self.recommendLab.text = model.trip_content;
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
