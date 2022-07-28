//
//  OrderDetailInfoTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2022/6/1.
//

#import "OrderDetailInfoTableViewCell.h"

@interface OrderDetailInfoTableViewCell ()

@property (nonatomic , retain)UIView *bgView;

@end

@implementation OrderDetailInfoTableViewCell


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
    
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.textColor = [ColorManager Color333333];
    self.titleLab.font = kFont(14);
    [self.bgView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgView);
        make.left.mas_offset(kWidth(10));
    }];
    
    self.infoLab = [[UILabel alloc]init];
    self.infoLab.font = kFont(14);
    self.infoLab.textAlignment = NSTextAlignmentRight;
    [self.bgView addSubview:self.infoLab];
    [self.infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgView);
        make.right.mas_offset(kWidth(-35));
        make.left.mas_offset(kWidth(100));
    }];
    
    UIImageView *arrowImgV = [[UIImageView alloc]initWithImage:kGetImage(@"箭头_浅")];
    arrowImgV.contentMode = UIViewContentModeScaleAspectFit;
    [self.bgView addSubview:arrowImgV];
    [arrowImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-10));
        make.centerY.equalTo(self.bgView);
        make.width.height.mas_offset(kWidth(16));
    }];
    
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
