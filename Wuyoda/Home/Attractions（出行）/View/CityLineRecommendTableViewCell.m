//
//  CityLineRecommendTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/22.
//

#import "CityLineRecommendTableViewCell.h"

@interface CityLineRecommendTableViewCell ()

@property (nonatomic , retain)UIView *bgView;

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
    
    self.backgroundColor = [ColorManager ColorF2F2F2];
    
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(120))];
    self.bgView.backgroundColor = [ColorManager WhiteColor];
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.height.equalTo(self.contentView);
    }];
    
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
