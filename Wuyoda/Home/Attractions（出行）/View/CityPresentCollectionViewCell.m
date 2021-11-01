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
    self.imgV.backgroundColor = [ColorManager RandomColor];
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
}

-(void)setImgName:(NSString *)imgName{
    [self.imgV setImage:kGetImage(imgName)];
}

@end
