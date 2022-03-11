//
//  OrderPriceTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/12/8.
//

#import "OrderPriceTableViewCell.h"

@implementation OrderPriceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    
    return self;
}

-(void)createUI{
    
    self.priceTitleLab = [[UILabel alloc]init];
    self.priceTitleLab.textColor = [ColorManager ColorCCCCCC];
    self.priceTitleLab.font = kFont(14);
    [self.contentView addSubview:self.priceTitleLab];
    [self.priceTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-265));
        make.centerY.equalTo(self.contentView);
    }];
    
    self.priceLab = [[UILabel alloc]init];
    //self.priceLab.text = @"￥349.00";
    self.priceLab.textColor = [ColorManager ColorCCCCCC];
    self.priceLab.font = kFont(14);
    [self.contentView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-13));
        make.centerY.equalTo(self.contentView);
    }];
    
    self.allPriceLab = [[UILabel alloc]init];
    //self.allPriceLab.text = @"￥349.00";
    self.allPriceLab.textColor = [UIColor redColor];
    self.allPriceLab.font = kFont(16);
    [self.contentView addSubview:self.allPriceLab];
    [self.allPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-13));
        make.centerY.equalTo(self.contentView);
    }];
    
    self.allPriceTitleLab = [[UILabel alloc]init];
    self.allPriceTitleLab.text = @"合计：";
    self.allPriceTitleLab.textColor = [ColorManager ColorCCCCCC];
    self.allPriceTitleLab.font = kFont(16);
    [self.contentView addSubview:self.allPriceTitleLab];
    [self.allPriceTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.allPriceLab.mas_left);
        make.centerY.equalTo(self.contentView);
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
