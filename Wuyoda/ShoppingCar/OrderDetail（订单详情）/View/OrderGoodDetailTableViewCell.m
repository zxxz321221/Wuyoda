//
//  OrderGoodDetailTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/26.
//

#import "OrderGoodDetailTableViewCell.h"

@interface OrderGoodDetailTableViewCell ()

@property (nonatomic , retain)UIView *goodBGV;

@property (nonatomic , retain)UIImageView *goodImgV;

@property (nonatomic , retain)UIImageView *statusImgV;

@property (nonatomic , retain)UILabel *goodNameLab;

@property (nonatomic , retain)UILabel *goodPriceLab;

@property (nonatomic , retain)UILabel *goodUnitLab;

@property (nonatomic , retain)UILabel *goodNumLab;


@end

@implementation OrderGoodDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    
    return self;
}

-(void)createUI{
    
//    UIView *topLine = [[UIView alloc]init];
//    topLine.backgroundColor = [ColorManager ColorF2F2F2];
//    [self.contentView addSubview:topLine];
//    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.width.equalTo(self.contentView);
//        make.height.mas_offset(kWidth(1));
//    }];
    
    self.contentView.backgroundColor = [ColorManager ColorF2F2F2];
    
    self.goodBGV = [[UIView alloc]initWithFrame:CGRectMake(kWidth(10), 0, kWidth(355), kWidth(140))];
    self.goodBGV.backgroundColor = [ColorManager WhiteColor];
    [self.contentView addSubview:self.goodBGV];
    
    self.goodImgV = [[UIImageView alloc]init];
    self.goodImgV.backgroundColor = [ColorManager ColorF2F2F2];
    [self.goodImgV setImage:kGetImage(@"good_detail_top")];
    self.goodImgV.layer.cornerRadius = kWidth(10);
    self.goodImgV.layer.masksToBounds = YES;
    self.goodImgV.contentMode = UIViewContentModeScaleAspectFit;
    [self.goodBGV addSubview:self.goodImgV];
    [self.goodImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(10));
        make.top.mas_offset(kWidth(20));
        make.width.height.mas_offset(kWidth(100));
    }];
    
    self.statusImgV = [[UIImageView alloc]initWithImage:kGetImage(@"商品已下架")];
    self.statusImgV.layer.cornerRadius = kWidth(5);
    self.statusImgV.layer.masksToBounds = YES;
    self.statusImgV.hidden = YES;
    [self.goodBGV addSubview:self.statusImgV];
    [self.statusImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(10));
        make.top.mas_offset(kWidth(20));
        make.width.height.mas_offset(kWidth(100));
    }];
    
    self.goodNameLab = [[UILabel alloc]init];
    //self.goodNameLab.text = @"【酱职人】国产黑豆荫油礼盒组...";
    self.goodNameLab.textColor = [ColorManager BlackColor];
    self.goodNameLab.font = kFont(14);
    self.goodNameLab.numberOfLines = 3;
    self.goodNameLab.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.goodBGV addSubview:self.goodNameLab];
    [self.goodNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodImgV.mas_right).mas_offset(kWidth(10));
        make.right.mas_offset(kWidth(-70));
        make.top.mas_offset(kWidth(18));
    }];
    
    self.goodPriceLab = [[UILabel alloc]init];
    //self.goodPriceLab.text = @"￥349.00";
    self.goodPriceLab.textColor = [ColorManager BlackColor];
    self.goodPriceLab.font = kFont(14);
    [self.goodBGV addSubview:self.goodPriceLab];
    [self.goodPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-10));
        make.top.mas_offset(kWidth(18));
    }];
    
    self.goodUnitLab = [[UILabel alloc]init];
    //self.goodUnitLab.text = @"规格：一个";
    self.goodUnitLab.textColor = [ColorManager ColorCCCCCC];
    self.goodUnitLab.font = kFont(12);
    [self.goodBGV addSubview:self.goodUnitLab];
    [self.goodUnitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodNameLab);
        make.top.equalTo(self.goodNameLab.mas_bottom).mas_offset(kWidth(13));
    }];
    
    self.goodNumLab = [[UILabel alloc]init];
    self.goodNumLab.text = @"数量：1";
    self.goodNumLab.textColor = [ColorManager ColorCCCCCC];
    self.goodNumLab.font = kFont(12);
    [self.goodBGV addSubview:self.goodNumLab];
    [self.goodNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodNameLab);
        make.top.equalTo(self.goodUnitLab.mas_bottom).mas_offset(kWidth(13));
    }];
    
    
}


-(void)setModel:(ShopCartModel *)model{
    _model = model;
    [self.goodImgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.goods_file1]]];
    self.goodNameLab.text = model.goods_name;
    self.goodPriceLab.text = [CommonManager getShowPrice:model.money_type Price:model.total_price];
    self.goodNumLab.text = [NSString stringWithFormat:@"数量：%@",model.cart_num];
    if (![model.goods_kg isEqualToString:@"0"] && model.goods_kg) {
        self.goodUnitLab.text = [NSString stringWithFormat:@"%@g",model.goods_kg];
    }else{
        self.goodUnitLab.text = @" ";
    }
    
}

-(void)setOrderGoodModel:(OrderGoodModel *)orderGoodModel{
    [self.goodImgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",orderGoodModel.goods_file1]]];
    self.goodNameLab.text = orderGoodModel.goods_name;
    self.goodPriceLab.text = [CommonManager getShowPrice:orderGoodModel.money_type Price:orderGoodModel.buy_total_price];
    //self.goodPriceLab.text = [NSString stringWithFormat:@"%@%@",[CommonManager getPriceType:orderGoodModel.money_type],orderGoodModel.buy_total_price];
    self.goodNumLab.text = [NSString stringWithFormat:@"数量：%@",orderGoodModel.buy_number];
    if (![orderGoodModel.goods_kg isEqualToString:@"0"] && orderGoodModel.goods_kg) {
        self.goodUnitLab.text = [NSString stringWithFormat:@"%@g",orderGoodModel.goods_kg];
    }else{
        self.goodUnitLab.text = @" ";
    }
    
    if ([orderGoodModel.verify isEqualToString:@"1"]) {
        self.statusImgV.hidden = YES;
    }else if ([orderGoodModel.verify isEqualToString:@"0"]){
        self.statusImgV.hidden = NO;
    }else if ([orderGoodModel.verify isEqualToString:@"2"]){
        self.statusImgV.hidden = NO;
        [self.statusImgV setImage:kGetImage(@"商品已删除")];
    }
    
}

-(void)setIsfirst:(BOOL)isfirst{
    if (isfirst) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.goodBGV.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(kWidth(10), kWidth(10))];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame =  self.goodBGV.bounds;
        maskLayer.path = maskPath.CGPath;
        self.goodBGV.layer.mask = maskLayer;
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
