//
//  OrderInfoGoodTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/27.
//

#import "OrderInfoGoodTableViewCell.h"

@interface OrderInfoGoodTableViewCell ()

@property (nonatomic , retain)UIImageView *goodImgV;

@property (nonatomic , retain)UILabel *goodNameLab;

@property (nonatomic , retain)UILabel *goodPriceLab;

@property (nonatomic , retain)UILabel *goodUnitLab;

@property (nonatomic , retain)UILabel *goodNumLab;

@property (nonatomic , retain)UILabel *goodAllPriceLab;

@property (nonatomic , retain)UILabel *goodFreightLab;

@property (nonatomic , retain)UILabel *allPriceLab;

@end

@implementation OrderInfoGoodTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    
    return self;
}

-(void)createUI{
    
    UIView *goodBGV = [[UIView alloc]initWithFrame:CGRectMake(kWidth(10), kWidth(10), kWidth(355), kWidth(120))];
    goodBGV.backgroundColor = [ColorManager ColorF7F7F7];
    goodBGV.layer.cornerRadius = kWidth(5);
    [self.contentView addSubview:goodBGV];
    
    self.goodImgV = [[UIImageView alloc]init];
    self.goodImgV.backgroundColor = [ColorManager RandomColor];
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
    goodAllPriceTitleLab.text = @"商品小计";
    goodAllPriceTitleLab.textColor = [ColorManager Color333333];
    goodAllPriceTitleLab.font = kFont(14);
    [self.contentView addSubview:goodAllPriceTitleLab];
    [goodAllPriceTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(12));
        make.top.equalTo(goodBGV.mas_bottom).mas_offset(kWidth(27));
    }];
    
    self.goodAllPriceLab = [[UILabel alloc]init];
    self.goodAllPriceLab.text = @"￥349.00";
    self.goodAllPriceLab.textColor = [ColorManager Color333333];
    self.goodAllPriceLab.font = kFont(14);
    [self.contentView addSubview:self.goodAllPriceLab];
    [self.goodAllPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-13));
        make.centerY.equalTo(goodAllPriceTitleLab);
    }];
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = [ColorManager ColorF2F2F2];
    [self.contentView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(12));
        make.right.mas_offset(kWidth(-12));
        make.top.equalTo(goodAllPriceTitleLab.mas_bottom).mas_offset(kWidth(14));
        make.height.mas_offset(kWidth(1));
    }];
    
    UILabel *goodFreightTitleLab = [[UILabel alloc]init];
    goodFreightTitleLab.text = @"运费";
    goodFreightTitleLab.textColor = [ColorManager Color333333];
    goodFreightTitleLab.font = kFont(14);
    [self.contentView addSubview:goodFreightTitleLab];
    [goodFreightTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(goodAllPriceTitleLab);
        make.top.equalTo(goodAllPriceTitleLab.mas_bottom).mas_offset(kWidth(19));
    }];

    self.goodFreightLab = [[UILabel alloc]init];
    self.goodFreightLab.text = @"￥0.00";
    self.goodFreightLab.textColor = [ColorManager Color333333];
    self.goodFreightLab.font = kFont(14);
    [self.contentView addSubview:self.goodFreightLab];
    [self.goodFreightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-13));
        make.centerY.equalTo(goodFreightTitleLab);
    }];
    
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = [ColorManager ColorF2F2F2];
    [self.contentView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(12));
        make.right.mas_offset(kWidth(-12));
        make.top.equalTo(goodFreightTitleLab.mas_bottom).mas_offset(kWidth(14));
        make.height.mas_offset(kWidth(1));
    }];
    
    UILabel *allPriceTitleLab = [[UILabel alloc]init];
    allPriceTitleLab.text = @"应付金额合计";
    allPriceTitleLab.textColor = [ColorManager ColorCCCCCC];
    allPriceTitleLab.font = kFont(16);
    [self.contentView addSubview:allPriceTitleLab];
    [allPriceTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(goodAllPriceTitleLab);
        make.top.equalTo(goodFreightTitleLab.mas_bottom).mas_offset(kWidth(27));
    }];

    self.allPriceLab = [[UILabel alloc]init];
    self.allPriceLab.text = @"￥349.00";
    self.allPriceLab.textColor = [UIColor redColor];
    self.allPriceLab.font = kFont(14);
    [self.contentView addSubview:self.allPriceLab];
    [self.allPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-13));
        make.centerY.equalTo(allPriceTitleLab);
    }];
    
}

-(void)setModel:(OrderListModel *)model{
    
    NSDictionary *orderGoodDic = model.order_goods;
    NSArray *allKey = orderGoodDic.allKeys;
    OrderGoodModel *goodModel = [OrderGoodModel mj_objectWithKeyValues:[orderGoodDic valueForKey:allKey.firstObject]];
    [self.goodImgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",goodModel.goods_file1]]];
    self.goodNameLab.text = goodModel.goods_name;
    self.goodNumLab.text = [NSString stringWithFormat:@"数量：%@",goodModel.buy_number];
    self.goodPriceLab.text = [NSString stringWithFormat:@"￥%@",goodModel.buy_price];
    self.goodAllPriceLab.text = [NSString stringWithFormat:@"￥%@",model.original_price];
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
