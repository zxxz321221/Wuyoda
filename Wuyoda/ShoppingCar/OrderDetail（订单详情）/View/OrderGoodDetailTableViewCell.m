//
//  OrderGoodDetailTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/26.
//

#import "OrderGoodDetailTableViewCell.h"

@interface OrderGoodDetailTableViewCell ()

@property (nonatomic , retain)UIImageView *goodImgV;

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
    
    UIView *goodBGV = [[UIView alloc]initWithFrame:CGRectMake(kWidth(10), kWidth(15), kWidth(355), kWidth(120))];
    goodBGV.backgroundColor = [ColorManager ColorF7F7F7];
    goodBGV.layer.cornerRadius = kWidth(5);
    [self.contentView addSubview:goodBGV];
    
    self.goodImgV = [[UIImageView alloc]init];
    self.goodImgV.backgroundColor = [ColorManager ColorF2F2F2];
    [self.goodImgV setImage:kGetImage(@"good_detail_top")];
    self.goodImgV.layer.cornerRadius = kWidth(10);
    [goodBGV addSubview:self.goodImgV];
    [self.goodImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(kWidth(10));
        make.width.height.mas_offset(kWidth(91));
    }];
    
    self.goodNameLab = [[UILabel alloc]init];
    //self.goodNameLab.text = @"【酱职人】国产黑豆荫油礼盒组...";
    self.goodNameLab.textColor = [ColorManager BlackColor];
    self.goodNameLab.font = kFont(14);
    self.goodNameLab.numberOfLines = 2;
    self.goodNameLab.lineBreakMode = NSLineBreakByTruncatingTail;
    [goodBGV addSubview:self.goodNameLab];
    [self.goodNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodImgV.mas_right).mas_offset(kWidth(10));
        make.right.mas_offset(kWidth(-110));
        make.top.mas_offset(kWidth(14));
    }];
    
    self.goodPriceLab = [[UILabel alloc]init];
    //self.goodPriceLab.text = @"￥349.00";
    self.goodPriceLab.textColor = [ColorManager BlackColor];
    self.goodPriceLab.font = kFont(14);
    [goodBGV addSubview:self.goodPriceLab];
    [self.goodPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-10));
        make.top.mas_offset(kWidth(21));
    }];
    
    self.goodUnitLab = [[UILabel alloc]init];
    self.goodUnitLab.text = @"规格：一个";
    self.goodUnitLab.textColor = [ColorManager ColorCCCCCC];
    self.goodUnitLab.font = kFont(12);
    [goodBGV addSubview:self.goodUnitLab];
    [self.goodUnitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodNameLab);
        make.top.equalTo(self.goodNameLab.mas_bottom).mas_offset(kWidth(25));
    }];
    
    self.goodNumLab = [[UILabel alloc]init];
    self.goodNumLab.text = @"数量：1";
    self.goodNumLab.textColor = [ColorManager ColorCCCCCC];
    self.goodNumLab.font = kFont(12);
    [goodBGV addSubview:self.goodNumLab];
    [self.goodNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodNameLab);
        make.top.equalTo(self.goodUnitLab.mas_bottom).mas_offset(kWidth(10));
    }];
    
    
}


-(void)setModel:(ShopCartModel *)model{
    _model = model;
    [self.goodImgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.goods_file1]]];
    self.goodNameLab.text = model.goods_name;
    self.goodPriceLab.text = [NSString stringWithFormat:@"%@%@",[CommonManager getPriceType:model.money_type],model.total_price];
    self.goodNumLab.text = [NSString stringWithFormat:@"数量：%@",model.cart_num];
}

-(void)setOrderGoodModel:(OrderGoodModel *)orderGoodModel{
    [self.goodImgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",orderGoodModel.goods_file1]]];
    self.goodNameLab.text = orderGoodModel.goods_name;
    self.goodPriceLab.text = [NSString stringWithFormat:@"%@%@",[CommonManager getPriceType:orderGoodModel.money_type],orderGoodModel.buy_total_price];
    self.goodNumLab.text = [NSString stringWithFormat:@"数量：%@",orderGoodModel.buy_number];
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
