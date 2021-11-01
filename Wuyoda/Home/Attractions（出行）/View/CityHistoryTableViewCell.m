//
//  CityHistoryTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/22.
//

#import "CityHistoryTableViewCell.h"

@interface CityHistoryTableViewCell ()

@property (nonatomic , retain)UILabel *timeLab;

@property (nonatomic , retain)UILabel *historyLab;

@end

@implementation CityHistoryTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.timeLab = [[UILabel alloc]init];
    self.timeLab.text = @"2006年10月16日";
    self.timeLab.textColor = [ColorManager Color333333];
    self.timeLab.font = kBoldFont(14);
    [self.contentView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(16));
        make.centerY.equalTo(self.contentView);
    }];
    
    self.historyLab = [[UILabel alloc]init];
    self.historyLab.text = @"2006年10月16日";
    self.historyLab.textColor = [ColorManager Color333333];
    self.historyLab.font = kFont(14);
    [self.contentView addSubview:self.historyLab];
    [self.historyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLab.mas_right).mas_offset(kWidth(10));
        make.right.mas_offset(kWidth(-20));
        make.centerY.equalTo(self.contentView);
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
