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

@property (nonatomic , retain)UILabel *goodAllPriceLab;

@property (nonatomic , retain)UILabel *goodFreightLab;

@property (nonatomic , retain)UILabel *allPriceLab;

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
    
    UIView *topLine = [[UIView alloc]init];
    topLine.backgroundColor = [ColorManager ColorF2F2F2];
    [self.contentView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.equalTo(self.contentView);
        make.height.mas_offset(kWidth(1));
    }];
    
    UIView *goodBGV = [[UIView alloc]initWithFrame:CGRectMake(kWidth(10), kWidth(22), kWidth(355), kWidth(120))];
    goodBGV.backgroundColor = [ColorManager ColorF7F7F7];
    goodBGV.layer.cornerRadius = kWidth(5);
    [self.contentView addSubview:goodBGV];
    
    self.goodImgV = [[UIImageView alloc]init];
    self.goodImgV.backgroundColor = [ColorManager RandomColor];
    [self.goodImgV setImage:kGetImage(@"good_detail_top")];
    self.goodImgV.layer.cornerRadius = kWidth(10);
    [goodBGV addSubview:self.goodImgV];
    [self.goodImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(kWidth(10));
        make.width.height.mas_offset(kWidth(91));
    }];
    
    self.goodNameLab = [[UILabel alloc]init];
    self.goodNameLab.text = @"【酱职人】国产黑豆荫油礼盒组...";
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
    self.goodPriceLab.text = @"￥349.00";
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
    
    UILabel *goodAllPriceTitleLab = [[UILabel alloc]init];
    goodAllPriceTitleLab.text = @"商品总价";
    goodAllPriceTitleLab.textColor = [ColorManager ColorCCCCCC];
    goodAllPriceTitleLab.font = kFont(14);
    [self.contentView addSubview:goodAllPriceTitleLab];
    [goodAllPriceTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(55));
        make.top.equalTo(goodBGV.mas_bottom).mas_offset(kWidth(14));
    }];
    
    self.goodAllPriceLab = [[UILabel alloc]init];
    self.goodAllPriceLab.text = @"￥349.00";
    self.goodAllPriceLab.textColor = [ColorManager ColorCCCCCC];
    self.goodAllPriceLab.font = kFont(14);
    [self.contentView addSubview:self.goodAllPriceLab];
    [self.goodAllPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-13));
        make.centerY.equalTo(goodAllPriceTitleLab);
    }];
    
    UILabel *goodFreightTitleLab = [[UILabel alloc]init];
    goodFreightTitleLab.text = @"运费";
    goodFreightTitleLab.textColor = [ColorManager ColorCCCCCC];
    goodFreightTitleLab.font = kFont(14);
    [self.contentView addSubview:goodFreightTitleLab];
    [goodFreightTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(goodAllPriceTitleLab);
        make.top.equalTo(goodAllPriceTitleLab.mas_bottom).mas_offset(kWidth(10));
    }];

    self.goodFreightLab = [[UILabel alloc]init];
    self.goodFreightLab.text = @"￥0.00";
    self.goodFreightLab.textColor = [ColorManager ColorCCCCCC];
    self.goodFreightLab.font = kFont(14);
    [self.contentView addSubview:self.goodFreightLab];
    [self.goodFreightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-13));
        make.centerY.equalTo(goodFreightTitleLab);
    }];

    self.allPriceLab = [[UILabel alloc]init];
    self.allPriceLab.text = @"￥349.00";
    self.allPriceLab.textColor = [UIColor redColor];
    self.allPriceLab.font = kFont(16);
    [self.contentView addSubview:self.allPriceLab];
    [self.allPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-13));
        make.top.equalTo(goodFreightTitleLab.mas_bottom).mas_offset(kWidth(14));
    }];

    UILabel *allPriceTitleLab = [[UILabel alloc]init];
    allPriceTitleLab.text = @"合计：";
    allPriceTitleLab.textColor = [ColorManager ColorCCCCCC];
    allPriceTitleLab.font = kFont(16);
    [self.contentView addSubview:allPriceTitleLab];
    [allPriceTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.allPriceLab.mas_left);
        make.centerY.equalTo(self.allPriceLab);
    }];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = [ColorManager ColorF2F2F2];
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.width.equalTo(self.contentView);
        make.height.mas_offset(kWidth(1));
    }];
    
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
