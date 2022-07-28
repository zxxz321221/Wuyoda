//
//  OrderPriceTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/12/8.
//

#import "OrderPriceTableViewCell.h"

@implementation OrderPriceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    
    return self;
}

-(void)createUI{
    
    self.contentView.backgroundColor = [ColorManager ColorF2F2F2];
    
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(kWidth(10), 0, kWidth(355), kWidth(44))];
    self.bgView.backgroundColor = [ColorManager WhiteColor];
    [self.contentView addSubview:self.bgView];
    
    self.priceTitleLab = [[UILabel alloc]init];
    self.priceTitleLab.textColor = [ColorManager Color333333];
    self.priceTitleLab.font = kFont(14);
    [self.bgView addSubview:self.priceTitleLab];
    [self.priceTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(10));
        make.centerY.equalTo(self.bgView);
    }];
    
    self.priceLab = [[UILabel alloc]init];
    //self.priceLab.text = @"￥349.00";
    self.priceLab.textColor = [ColorManager BlackColor];
    self.priceLab.font = kBoldFont(14);
    [self.bgView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-10));
        make.centerY.equalTo(self.bgView);
    }];
    
//    self.allPriceLab = [[UILabel alloc]init];
//    //self.allPriceLab.text = @"￥349.00";
//    self.allPriceLab.textColor = [UIColor redColor];
//    self.allPriceLab.font = kFont(16);
//    [self.contentView addSubview:self.allPriceLab];
//    [self.allPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_offset(kWidth(-13));
//        make.centerY.equalTo(self.contentView);
//    }];
//    
//    self.allPriceTitleLab = [[UILabel alloc]init];
//    self.allPriceTitleLab.text = @"合计：";
//    self.allPriceTitleLab.textColor = [ColorManager ColorCCCCCC];
//    self.allPriceTitleLab.font = kFont(16);
//    [self.contentView addSubview:self.allPriceTitleLab];
//    [self.allPriceTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.allPriceLab.mas_left);
//        make.centerY.equalTo(self.contentView);
//    }];
}


-(void)setIsFirst:(BOOL)isFirst{
    if (isFirst) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bgView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(kWidth(10), kWidth(10))];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame =  self.bgView.bounds;
        maskLayer.path = maskPath.CGPath;
        self.bgView.layer.mask = maskLayer;
    }else{
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bgView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(0, 0)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame =  self.bgView.bounds;
        maskLayer.path = maskPath.CGPath;
        self.bgView.layer.mask = maskLayer;
    }
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
