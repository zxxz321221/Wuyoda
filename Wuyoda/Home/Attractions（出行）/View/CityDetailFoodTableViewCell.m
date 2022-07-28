//
//  CityDetailFoodTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/22.
//

#import "CityDetailFoodTableViewCell.h"

@interface CityDetailFoodTableViewCell ()

@property (nonatomic , retain)UIView *bgView;

@property (nonatomic , retain)UIImageView *imgV;

@property (nonatomic , retain)UILabel *nameLab;

@property (nonatomic , retain)UILabel *branchLab;

@property (nonatomic , retain)UILabel *tagLab;

@property (nonatomic , retain)UILabel *introLab;

@property (nonatomic , retain)UILabel *addressLab;

@end

@implementation CityDetailFoodTableViewCell

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
        make.width.height.mas_offset(kWidth(100));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    //self.nameLab.text = @"纸箱王";
    self.nameLab.textColor = [ColorManager Color333333];
    self.nameLab.font = kFont(14);
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgV);
        make.left.equalTo(self.imgV.mas_right).mas_offset(kWidth(16));
    }];
    
    self.branchLab = [[UILabel alloc]init];
    //self.branchLab.text = @"（西屯路店）";
    self.branchLab.textColor = [ColorManager Color333333];
    self.branchLab.font = kFont(13);
    [self.contentView addSubview:self.branchLab];
    [self.branchLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.nameLab);
        make.left.equalTo(self.nameLab.mas_right).mas_offset(kWidth(5));
    }];
    
    self.tagLab = [[UILabel alloc]init];
    //self.tagLab.text = @"创意台湾菜";
    self.tagLab.textColor = [ColorManager WhiteColor];
    self.tagLab.font = kFont(10);
    self.tagLab.backgroundColor = [ColorManager ColorFA8B18];
    self.tagLab.layer.cornerRadius = kWidth(3);
    self.tagLab.layer.masksToBounds = YES;
    self.tagLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.tagLab];
    [self.tagLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLab.mas_bottom).mas_offset(kWidth(5));
        make.left.equalTo(self.nameLab);
        make.width.mas_offset(kWidth(60));
        make.height.mas_offset(kWidth(18));
    }];
    
    self.introLab = [[UILabel alloc]init];
    //self.introLab.text = @"很有趣的创意餐厅，店内所有东西都是纸做的";
    self.introLab.textColor = [ColorManager Color333333];
    self.introLab.numberOfLines = 2;
    self.introLab.lineBreakMode = NSLineBreakByTruncatingTail;
    self.introLab.font = kFont(12);
    [self.contentView addSubview:self.introLab];
    [self.introLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tagLab.mas_bottom).mas_offset(kWidth(6));
        make.left.equalTo(self.nameLab);
        make.right.mas_offset(kWidth((-20)));
    }];
    
    self.addressLab = [[UILabel alloc]init];
    //self.addressLab.text = @"位置：东海大学以北1.2公里";
    self.addressLab.textColor = [ColorManager Color333333];
    self.addressLab.font = kFont(12);
    [self.contentView addSubview:self.addressLab];
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.imgV);
        make.left.right.equalTo(self.introLab);
    }];
    
}

-(void)setModel:(CityCustomModel *)model{
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:nil];
    self.nameLab.text = model.custom_title;
    self.tagLab.text = model.custom_td;
    CGFloat strW = 0;
    
    if (model.custom_td.length) {
        strW = [LCTools widthWithString:model.custom_td font:kWidth(10)];
    }
    [self.tagLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(strW+kWidth(5));
    }];
    //CGFloat tagW =
    self.introLab.text = model.custom_brief;
    self.addressLab.text = [NSString stringWithFormat:@"位置:%@",model.custom_position];
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
