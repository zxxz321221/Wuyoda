//
//  CityHistoryTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/22.
//

#import "CityHistoryTableViewCell.h"

@interface CityHistoryTableViewCell ()

@property (nonatomic , retain)UIView *bgView;

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
    
    self.backgroundColor = [ColorManager ColorF2F2F2];
    
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(120))];
    self.bgView.backgroundColor = [ColorManager WhiteColor];
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.height.equalTo(self.contentView);
    }];
    
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

- (void)setModel:(CityEventModel *)model{
    self.timeLab.text = model.event_date;
    self.historyLab.text = model.event_content;
}

-(void)setIsLast:(BOOL)isLast{
    if (isLast) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bgView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(kWidth(10), kWidth(10))];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame =  self.bgView.bounds;
        maskLayer.path = maskPath.CGPath;
        self.bgView.layer.mask = maskLayer;
        
    }else{
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bgView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(0, 0)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame =  self.bgView.bounds;
        maskLayer.path = maskPath.CGPath;
        self.bgView.layer.mask = maskLayer;
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
