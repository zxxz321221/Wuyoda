//
//  CityAttractionTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/22.
//

#import "CityAttractionTableViewCell.h"

@interface CityAttractionTableViewCell ()

@property (nonatomic , retain)UIView *bgView;

@property (nonatomic , retain)UIImageView *imgV;

@property (nonatomic , retain)UILabel *nameLab;

@property (nonatomic , retain)UILabel *introLab;

@end

@implementation CityAttractionTableViewCell

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
    
    
    self.imgV = [[UIImageView alloc]init];
    self.imgV.backgroundColor = [ColorManager ColorF2F2F2];
    self.imgV.layer.cornerRadius = kWidth(5);
    self.imgV.layer.masksToBounds = YES;
    [self.contentView addSubview:self.imgV];
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(16));
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_offset(kWidth(80));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    //self.nameLab.text = @"逢甲夜市";
    self.nameLab.textColor = [ColorManager Color333333];
    self.nameLab.font = kBoldFont(14);
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgV.mas_right).mas_offset(kWidth(16));
        make.top.equalTo(self.imgV);
    }];
    
    self.introLab = [[UILabel alloc]init];
    //self.introLab.text = @"湿地面积不大，包含潮溪、沼泽、沙滩、碎石、泥滩等丰富且复杂的湿地生态。生物物种差异度极高，是各种底栖生物、鱼贝类、鸟类、水禽类栖息的最佳场所。高美湿地是著名的观...";
    self.introLab.textColor = [ColorManager Color333333];
    self.introLab.font = kFont(12);
    self.introLab.numberOfLines = 4;
    self.introLab.lineBreakMode = NSLineBreakByCharWrapping;
    [self addSubview:self.introLab];
    [self.introLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgV.mas_right).mas_offset(kWidth(16));
        make.right.mas_offset(-20);
        make.top.equalTo(self.nameLab.mas_bottom).mas_offset(kWidth(8));
    }];
}

-(void)setModel:(AttractionModel *)model{
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    self.nameLab.text = model.scenic_title;
    self.introLab.text = model.scenic_brief;
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
