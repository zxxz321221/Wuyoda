//
//  WishListTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/23.
//

#import "WishListTableViewCell.h"
#import "CWStarRateView.h"

@interface WishListTableViewCell ()

@property (nonatomic , retain)UIImageView *imgV;

@property (nonatomic , retain)UIImageView *statusImgV;

//@property (nonatomic , retain)UILabel *cityLab;

@property (nonatomic , retain)UILabel *introLab;

@property (nonatomic , retain)UILabel *nameLab;

//@property (nonatomic , retain)CWStarRateView *starV;

@property (nonatomic , retain)UILabel *priceLab;

//@property (nonatomic , retain)UILabel *commentLab;

@property (nonatomic , retain)UIImageView *selectImgV;

@end

@implementation WishListTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    
    return self;
}

-(void)createUI{
    
    self.selectImgV = [[UIImageView alloc]init];
    self.selectImgV.hidden = YES;
    [self.contentView addSubview:self.selectImgV];
    [self.selectImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_offset(kWidth(1));
    }];
    
    self.imgV = [[UIImageView alloc]init];
    self.imgV.backgroundColor = [ColorManager ColorF2F2F2];
    self.imgV.layer.cornerRadius = kWidth(5);
    self.imgV.layer.masksToBounds = YES;
    self.imgV.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.imgV];
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectImgV.mas_right).mas_offset(kWidth(10));
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_offset(kWidth(100));
    }];
    
    self.statusImgV = [[UIImageView alloc]initWithImage:kGetImage(@"商品已下架")];
    self.statusImgV.layer.cornerRadius = kWidth(5);
    self.statusImgV.layer.masksToBounds = YES;
    [self.contentView addSubview:self.statusImgV];
    [self.statusImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectImgV.mas_right).mas_offset(kWidth(10));
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_offset(kWidth(100));
    }];
    
    
    self.introLab = [[UILabel alloc]init];
    self.introLab.textColor = [ColorManager Color7F7F7F];
    self.introLab.font = kFont(10);
    [self.contentView addSubview:self.introLab];
    [self.introLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgV).mas_offset(kWidth(3));
        make.left.equalTo(self.imgV.mas_right).mas_offset(kWidth(20));
        make.right.mas_offset(kWidth(-15));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.text = @"擂茶";
    self.nameLab.textColor = [ColorManager BlackColor];
    self.nameLab.font = kFont(14);
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.introLab.mas_bottom).mas_offset(kWidth(4));
        make.left.equalTo(self.imgV.mas_right).mas_offset(kWidth(20));
        make.right.mas_offset(kWidth(-15));
    }];
    
//    self.starV = [[CWStarRateView alloc]initWithFrame:CGRectMake(kWidth(158), kWidth(58), kWidth(70), kWidth(10)) numberOfStars:5];
//    self.starV.scorePercent = 0.8;
//    [self.contentView addSubview:self.starV];
//
//    self.commentLab = [[UILabel alloc]init];
//    self.commentLab.text = @"172条评价";
//    self.commentLab.textColor = [ColorManager Color7F7F7F];
//    self.commentLab.font = kFont(12);
//    [self.contentView addSubview:self.commentLab];
//    [self.commentLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.starV);
//        make.left.equalTo(self.starV.mas_right).mas_offset(kWidth(10));
//        make.right.mas_offset(kWidth(-15));
//    }];
    
    self.priceLab = [[UILabel alloc]init];
    self.priceLab.text = @"￥0.00";
    self.priceLab.textColor = [ColorManager ColorFE3C3D];
    self.priceLab.font = kFont(14);
    [self.contentView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLab.mas_bottom).mas_offset(kWidth(25));
        make.left.equalTo(self.imgV.mas_right).mas_offset(kWidth(20));
    }];
}

-(void)setModel:(WishModel *)model{
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.goods_file1]];
    if ([model.isup isEqualToString:@"0"]) {
        self.statusImgV.hidden = NO;
    }else{
        self.statusImgV.hidden = YES;
    }
    self.introLab.text = model.goods_advance;
    self.nameLab.text = model.goods_name;
    self.priceLab.text = [CommonManager getShowPrice:model.money_type Price:model.goods_sale_price];
    //self.priceLab.text = [NSString stringWithFormat:@"%@%@",[CommonManager getPriceType:model.money_type],model.goods_sale_price];
    if ([model.isSelect isEqualToString:@"1"]) {
        [self.selectImgV setImage:kGetImage(@"选中")];
    }else{
        [self.selectImgV setImage:kGetImage(@"未选中")];
    }
}

-(void)setIsEdit:(BOOL)isEdit{
    if (isEdit) {
        self.selectImgV.hidden = NO;
        [self.selectImgV mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.height.mas_offset(kWidth(20));
        }];
    }else{
        self.selectImgV.hidden = YES;
        [self.selectImgV mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.height.mas_offset(kWidth(1));
        }];
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
