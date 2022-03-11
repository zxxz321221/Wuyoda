//
//  CityPresentCollectionViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/22.
//

#import "CityPresentCollectionViewCell.h"

@interface CityPresentCollectionViewCell ()

@property (nonatomic , retain)UIImageView *imgV;

@property (nonatomic , retain)UILabel *priceLab;

@property (nonatomic , retain)UILabel *oldPriceLab;

@property (nonatomic , retain)UILabel *unitLab;

@property (nonatomic , retain)UIImageView *selectImgV;

@end

@implementation CityPresentCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.imgV = [[UIImageView alloc]init];
    self.imgV.backgroundColor = [ColorManager ColorF2F2F2];
    [self.contentView addSubview:self.imgV];
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(0);
        make.width.height.mas_offset(kWidth(100));
    }];
    
    self.priceLab = [[UILabel alloc]init];
    self.priceLab.text = @"￥148";
    self.priceLab.textColor = [ColorManager BlackColor];
    self.priceLab.font = kFont(12);
    [self.contentView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.equalTo(self.imgV.mas_bottom).mas_offset(kWidth(10));
    }];
    
    self.oldPriceLab = [[UILabel alloc]init];
    self.oldPriceLab.textColor = [ColorManager ColorAAAAAA];
    self.oldPriceLab.font = kFont(10);
    NSMutableAttributedString *oldPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",@"158"]];
    [oldPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, oldPrice.length)];
    self.oldPriceLab.attributedText = oldPrice;
    [self.contentView addSubview:self.oldPriceLab];
    [self.oldPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLab.mas_right).mas_offset(kWidth(4));
        make.bottom.equalTo(self.priceLab);
    }];
    
    self.unitLab = [[UILabel alloc]init];
    self.unitLab.text = @"/盒";
    self.unitLab.textColor = [ColorManager BlackColor];
    self.unitLab.font = kFont(10);
    [self.contentView addSubview:self.unitLab];
    [self.unitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.oldPriceLab.mas_right);
        make.centerY.equalTo(self.oldPriceLab);
    }];
    
    self.selectImgV = [[UIImageView alloc]init];
    self.selectImgV.hidden = YES;
    [self.contentView addSubview:self.selectImgV];
    [self.selectImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kWidth(10));
        make.right.mas_offset(kWidth(-3));
        make.width.height.mas_offset(kWidth(15));
    }];
}

-(void)setModel:(HomeShopModel *)model{
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.goods_file1]];
    self.priceLab.text = [NSString stringWithFormat:@"￥%@",model.goods_sale_price];
    NSMutableAttributedString *oldPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",model.goods_sale_price_org]];
    [oldPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, oldPrice.length)];
    self.oldPriceLab.attributedText = oldPrice;
}

-(void)setFootPrintmodel:(FootPrintModel *)footPrintmodel{
    _footPrintmodel = footPrintmodel;
    
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:footPrintmodel.goods.goods_file1]];
    self.priceLab.text = [NSString stringWithFormat:@"%@%@",[CommonManager getPriceType:footPrintmodel.goods.money_type],footPrintmodel.goods.price];
    NSMutableAttributedString *oldPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",[CommonManager getPriceType:footPrintmodel.goods.money_type],footPrintmodel.goods.goods_market_price_org]];
    [oldPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, oldPrice.length)];
    self.oldPriceLab.attributedText = oldPrice;
    
    if ([footPrintmodel.isSelect isEqualToString:@"1"]) {
        [self.selectImgV setImage:kGetImage(@"选中")];
    }else{
        [self.selectImgV setImage:kGetImage(@"选择")];
    }
}

-(void)setIsEdit:(BOOL)isEdit{
    self.selectImgV.hidden = !isEdit;
}

@end
