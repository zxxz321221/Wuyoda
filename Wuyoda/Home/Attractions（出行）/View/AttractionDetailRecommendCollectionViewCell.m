//
//  AttractionDetailRecommendCollectionViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/18.
//

#import "AttractionDetailRecommendCollectionViewCell.h"
#import "CWStarRateView.h"

@interface AttractionDetailRecommendCollectionViewCell ()

@property (nonatomic , retain)UIImageView *imgV;
@property (nonatomic , retain)UILabel *titleLab;
@property (nonatomic , retain)UILabel *priceLab;
@property (nonatomic , retain)UILabel *oldPriceLab;
@property (nonatomic , retain)UILabel *unitLab;
@property (nonatomic , retain)CWStarRateView *starV;

@end

@implementation AttractionDetailRecommendCollectionViewCell

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
    //self.imgV.backgroundColor = [UIColor lightGrayColor];
    //self.imgV.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.imgV];
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(0);
        make.width.mas_offset(kWidth(161));
        make.height.mas_offset(kWidth(107));
    }];
    
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.text = @"旗津海水浴场";
    self.titleLab.textColor = [ColorManager BlackColor];
    self.titleLab.font = kFont(13);
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.imgV);
        make.top.equalTo(self.imgV.mas_bottom).mas_offset(kWidth(6));
    }];
    
    self.priceLab = [[UILabel alloc]init];
    self.priceLab.text = @"￥148";
    self.priceLab.textColor = [ColorManager BlackColor];
    self.priceLab.font = kFont(12);
    [self.contentView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
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
    self.unitLab.text = @"/人";
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
    
}

-(void)setModel:(AttractionModel *)model{
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    self.titleLab.text = model.scenic_title;
    self.priceLab.text = [NSString stringWithFormat:@"￥%@",model.scenic_price];
    NSMutableAttributedString *oldPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",model.scenic_price]];
    [oldPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, oldPrice.length)];
    self.oldPriceLab.attributedText = oldPrice;
}


@end
