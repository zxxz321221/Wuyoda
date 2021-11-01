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

@property (nonatomic , retain)UILabel *cityLab;

@property (nonatomic , retain)UILabel *nameLab;

@property (nonatomic , retain)CWStarRateView *starV;

@property (nonatomic , retain)UILabel *priceLab;

@property (nonatomic , retain)UILabel *commentLab;

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
    self.imgV = [[UIImageView alloc]init];
    self.imgV.backgroundColor = [ColorManager RandomColor];
    self.imgV.layer.cornerRadius = kWidth(5);
    self.imgV.layer.masksToBounds = YES;
    [self.contentView addSubview:self.imgV];
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.centerY.equalTo(self.contentView);
        make.width.mas_offset(kWidth(112));
        make.height.mas_offset(kWidth(83));
    }];
    
    self.cityLab = [[UILabel alloc]init];
    self.cityLab.text = @"苗栗市";
    self.cityLab.textColor = [ColorManager BlackColor];
    self.cityLab.font = kFont(12);
    [self.contentView addSubview:self.cityLab];
    [self.cityLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgV);
        make.left.equalTo(self.imgV.mas_right).mas_offset(kWidth(15));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.text = @"擂茶";
    self.nameLab.textColor = [ColorManager Color7F7F7F];
    self.nameLab.font = kFont(14);
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cityLab.mas_bottom).mas_offset(kWidth(4));
        make.left.equalTo(self.imgV.mas_right).mas_offset(kWidth(15));
    }];
    
    self.starV = [[CWStarRateView alloc]initWithFrame:CGRectMake(kWidth(148), kWidth(58), kWidth(70), kWidth(10)) numberOfStars:5];
    self.starV.scorePercent = 0.8;
    [self.contentView addSubview:self.starV];
    
    self.commentLab = [[UILabel alloc]init];
    self.commentLab.text = @"172条评价 · 超赞商品";
    self.commentLab.textColor = [ColorManager Color7F7F7F];
    self.commentLab.font = kFont(12);
    [self.contentView addSubview:self.commentLab];
    [self.commentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.starV);
        make.left.equalTo(self.starV.mas_right).mas_offset(kWidth(10));
    }];
    
    self.priceLab = [[UILabel alloc]init];
    self.priceLab.text = @"￥615/盒";
    self.priceLab.textColor = [ColorManager BlackColor];
    self.priceLab.font = kFont(14);
    [self.contentView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.starV.mas_bottom).mas_offset(kWidth(7));
        make.left.equalTo(self.imgV.mas_right).mas_offset(kWidth(15));
    }];
}

-(void)setImgName:(NSString *)imgName{
    [self.imgV setImage:kGetImage(imgName)];
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
