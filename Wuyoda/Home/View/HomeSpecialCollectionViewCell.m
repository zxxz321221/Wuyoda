//
//  HomeSpecialCollectionViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/14.
//

#import "HomeSpecialCollectionViewCell.h"
#import "CWStarRateView.h"

@interface HomeSpecialCollectionViewCell ()

@property (nonatomic , retain)UIImageView *imgV;
@property (nonatomic , retain)UILabel *subLab;
@property (nonatomic , retain)UILabel *titleLab;
@property (nonatomic , retain)UILabel *priceLab;
@property (nonatomic , retain)UILabel *oldPriceLab;
@property (nonatomic , retain)UILabel *unitLab;
@property (nonatomic , retain)CWStarRateView *starV;
@property (nonatomic , retain)UILabel *addressLab;

@end


@implementation HomeSpecialCollectionViewCell

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
    self.imgV.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.imgV];
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(0);
        make.width.mas_offset(kWidth(161));
        make.height.mas_offset(kWidth(107));
    }];
    
    self.subLab = [[UILabel alloc]init];
    self.subLab.text = @"补充的营养圣品";
    self.subLab.textColor = [ColorManager Color7F7F7F];
    self.subLab.font = kFont(10);
    [self.contentView addSubview:self.subLab];
    [self.subLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.imgV);
        make.top.equalTo(self.imgV.mas_bottom).mas_offset(kWidth(6));
    }];
    
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.text = @"擂茶客家人招待贵宾茶点";
    self.titleLab.textColor = [ColorManager BlackColor];
    self.titleLab.font = kFont(13);
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.subLab);
        make.top.equalTo(self.subLab.mas_bottom).mas_offset(kWidth(6));
    }];
    
    self.priceLab = [[UILabel alloc]init];
    self.priceLab.text = @"￥148";
    self.priceLab.textColor = [ColorManager BlackColor];
    self.priceLab.font = kFont(12);
    [self.contentView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subLab);
        make.top.equalTo(self.titleLab.mas_bottom).mas_offset(kWidth(6));
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
        make.centerY.equalTo(self.priceLab);
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
    
    [self.contentView layoutIfNeeded];
    
    self.starV = [[CWStarRateView alloc]initWithFrame:CGRectMake(0, self.priceLab.frame.origin.y+self.priceLab.bounds.size.height+kWidth(4), kWidth(80), kWidth(15)) numberOfStars:5];
    self.starV.scorePercent = 0.8;
    [self.contentView addSubview:self.starV];
    
    self.addressLab = [[UILabel alloc]init];
    self.addressLab.text = @"苗栗";
    self.addressLab.textColor = [ColorManager ColorAAAAAA];
    self.addressLab.font = kFont(12);
    [self.contentView addSubview:self.addressLab];
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subLab);
        make.top.equalTo(self.starV.mas_bottom).mas_offset(kWidth(6));
    }];
}

-(void)setImgName:(NSString *)imgName{
    [self.imgV setImage:kGetImage(imgName)];
}

-(void)setModel:(HomeShopModel *)model{
    _model = model;
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTTP,model.goods_file1]]];
    self.titleLab.text = model.goods_name;
    self.priceLab.text = model.goods_sale_price;
    self.oldPriceLab.text = model.goods_sale_price_org;
    self.addressLab.text = model.belong_city;
}

@end
