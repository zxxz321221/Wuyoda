//
//  GoodEvaluateScoreTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/13.
//

#import "GoodEvaluateScoreTableViewCell.h"

@implementation GoodEvaluateScoreTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    
    return self;
}

-(void)createUI{
    
    self.topLine = [[UIView alloc]init];
    self.topLine.backgroundColor = [ColorManager ColorF2F2F2];
    [self.contentView addSubview:self.topLine];
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.equalTo(self.contentView);
        make.height.mas_offset(kWidth(1));
    }];
    
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.textColor = [ColorManager Color333333];
    self.titleLab.font = kFont(14);
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(24));
        make.centerY.equalTo(self);
    }];
    
    self.startV = [[QuestionnaireStarView alloc] init];
    self.startV.starImage = [UIImage imageNamed:@"foreStarImg"];
    //star.starImageForHalf = [UIImage imageNamed:@"half-star"];
    self.startV.unstarImage = [UIImage imageNamed:@"backStarImg"];
    self.startV.numberOfStars = 5;
    [self.contentView addSubview:self.startV];
    [self.startV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(100));
        make.centerY.equalTo(self.contentView);
    }];
    
    self.bottomLine = [[UIView alloc]init];
    self.bottomLine.backgroundColor = [ColorManager ColorF2F2F2];
    [self.contentView addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.width.equalTo(self.contentView);
        make.height.mas_offset(kWidth(1));
    }];
}

-(void)setShowLine:(BOOL)showLine{
    if (showLine) {
        self.topLine.hidden = NO;
        self.bottomLine.hidden = NO;
    }else{
        self.topLine.hidden = YES;
        self.bottomLine.hidden = YES;
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
