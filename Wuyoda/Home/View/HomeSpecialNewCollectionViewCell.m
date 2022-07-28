//
//  HomeSpecialNewCollectionViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2022/5/23.
//

#import "HomeSpecialNewCollectionViewCell.h"

@interface HomeSpecialNewCollectionViewCell ()

@property (nonatomic , retain)UIImageView *imgV;

@property (nonatomic , retain)UILabel *introLab;

@property (nonatomic , retain)UILabel *nameLab;

@property (nonatomic , retain)UILabel *priceLab;

@property (nonatomic , retain)UILabel *oldPriceLab;

@property (nonatomic , retain)UILabel *unityLab;

@end

@implementation HomeSpecialNewCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    UIView *bgV = [[UIView alloc]initWithFrame:CGRectMake(kWidth(0), 0, kWidth(160), kWidth(240))];
    bgV.backgroundColor = [ColorManager WhiteColor];
    bgV.layer.cornerRadius = kWidth(10);
    //定义view的阴影颜色
    bgV.layer.shadowColor = [ColorManager BlackColor].CGColor;
    //阴影偏移量
    bgV.layer.shadowOffset = CGSizeMake(0, 4);
    //定义view的阴影宽度，模糊计算的半径
    bgV.layer.shadowRadius = 6;
    //定义view的阴影透明度，注意:如果view没有设置背景色阴影也是不会显示的
    bgV.layer.shadowOpacity = 0.15;
    [self addSubview:bgV];
    
    
    self.imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWidth(160), kWidth(160))];
    self.imgV.contentMode = UIViewContentModeScaleAspectFit;
    [bgV addSubview:self.imgV];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.imgV.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(kWidth(10), kWidth(10))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame =  self.imgV.bounds;
    maskLayer.path = maskPath.CGPath;
    self.imgV.layer.mask = maskLayer;
    
    self.introLab = [[UILabel alloc]init];
    self.introLab.text = @"自种金钻凤梨与麦芽糖手工熬煮自种金钻凤梨与麦芽糖手工熬煮";
    self.introLab.textColor = [ColorManager Color7F7F7F];
    self.introLab.font = kFont(10);
    [bgV addSubview:self.introLab];
    [self.introLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(10));
        make.right.mas_offset(kWidth(-10));
        make.top.equalTo(self.imgV.mas_bottom).mas_offset(kWidth(10));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.text = @"土凤梨酥 阿里山木盒";
    self.nameLab.textColor = [ColorManager Color333333];
    self.nameLab.font = kFont(14);
    [bgV addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(10));
        make.right.mas_offset(kWidth(-10));
        make.top.equalTo(self.imgV.mas_bottom).mas_offset(kWidth(30));
    }];
    
    self.priceLab = [[UILabel alloc]init];
    self.priceLab.text = @"￥128";
    self.priceLab.textColor = [ColorManager MainColor];
    self.priceLab.font = kFont(12);
    [bgV addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(10));
        make.top.equalTo(self.nameLab.mas_bottom).mas_offset(kWidth(10));
    }];
    
    self.oldPriceLab = [[UILabel alloc]init];
    self.oldPriceLab.textColor = [ColorManager ColorAAAAAA];
    self.oldPriceLab.font = kFont(12);
    
    NSMutableAttributedString *oldPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",@"238"]];
    [oldPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, oldPrice.length)];
    self.oldPriceLab.attributedText = oldPrice;
    
    [bgV addSubview:self.oldPriceLab];
    [self.oldPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLab.mas_right).mas_offset(kWidth(5));
        make.centerY.equalTo(self.priceLab);
    }];
    
    self.unityLab = [[UILabel alloc]init];
    self.unityLab.textColor = [ColorManager BlackColor];
    self.unityLab.font = kFont(12);
    [bgV addSubview:self.unityLab];
    [self.unityLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.oldPriceLab.mas_right).mas_offset(kWidth(2));
        make.centerY.equalTo(self.priceLab);
    }];
    
}

-(void)setModel:(HomeShopModel *)model{
    _model = model;
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.goods_file1]];
    self.introLab.text = [model.detail objectForKey:@"goods_advance"];
    self.nameLab.text = model.goods_name;
    //self.priceLab.text = [NSString stringWithFormat:@"%@%@",[CommonManager getPriceType:model.money_type],model.price];
    self.priceLab.text = [CommonManager getShowPrice:model.money_type Price:model.price];
    //NSMutableAttributedString *oldPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",[CommonManager getPriceType:model.money_type],model.detail[@"goods_market_price_org"]]];
    NSMutableAttributedString *oldPrice = [[NSMutableAttributedString alloc] initWithString:[CommonManager getShowPrice:model.money_type Price:model.detail[@"goods_market_price_org"]]];
    [oldPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, oldPrice.length)];
    self.oldPriceLab.attributedText = oldPrice;
    
    if (![model.unit isEqualToString:@"0"] && model.unit.length) {
        self.unityLab.text = [NSString stringWithFormat:@"/%@",model.unit];
    }else{
        self.unityLab.text = @"";
    }
    
}

@end
