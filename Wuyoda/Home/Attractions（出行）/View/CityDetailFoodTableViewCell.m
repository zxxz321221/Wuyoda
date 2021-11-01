//
//  CityDetailFoodTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/22.
//

#import "CityDetailFoodTableViewCell.h"

@interface CityDetailFoodTableViewCell ()

@property (nonatomic , retain)UIImageView *imgV;

@property (nonatomic , retain)UILabel *nameLab;

@property (nonatomic , retain)UILabel *branchLab;

@property (nonatomic , retain)UILabel *tagLab;

@property (nonatomic , retain)UILabel *introLab;

@property (nonatomic , retain)UILabel *addressLab;

@end

@implementation CityDetailFoodTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
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
    [self.contentView addSubview:self.imgV];
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(16));
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_offset(kWidth(80));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.text = @"纸箱王";
    self.nameLab.textColor = [ColorManager Color333333];
    self.nameLab.font = kBoldFont(14);
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgV).mas_offset(kWidth(3));
        make.left.equalTo(self.imgV.mas_right).mas_offset(kWidth(16));
    }];
    
    self.branchLab = [[UILabel alloc]init];
    self.branchLab.text = @"（西屯路店）";
    self.branchLab.textColor = [ColorManager Color333333];
    self.branchLab.font = kFont(13);
    [self.contentView addSubview:self.branchLab];
    [self.branchLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.nameLab);
        make.left.equalTo(self.nameLab.mas_right).mas_offset(kWidth(5));
    }];
    
    self.tagLab = [[UILabel alloc]init];
    self.tagLab.text = @"创意台湾菜";
    self.tagLab.textColor = [ColorManager WhiteColor];
    self.tagLab.font = kFont(10);
    self.tagLab.backgroundColor = [ColorManager Color008A70];
    self.tagLab.layer.cornerRadius = kWidth(3);
    self.tagLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.tagLab];
    [self.tagLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.branchLab);
        make.left.equalTo(self.branchLab.mas_right).mas_offset(kWidth(6));
        make.width.mas_offset(kWidth(60));
        make.height.mas_offset(kWidth(18));
    }];
    
    self.introLab = [[UILabel alloc]init];
    self.introLab.text = @"很有趣的创意餐厅，店内所有东西都是纸做的";
    self.introLab.textColor = [ColorManager Color333333];
    self.introLab.font = kFont(12);
    [self.contentView addSubview:self.introLab];
    [self.introLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLab.mas_bottom).mas_offset(kWidth(20));
        make.left.equalTo(self.nameLab);
        make.right.mas_offset(kWidth((-20)));
    }];
    
    self.addressLab = [[UILabel alloc]init];
    self.addressLab.text = @"位置：东海大学以北1.2公里";
    self.addressLab.textColor = [ColorManager Color333333];
    self.addressLab.font = kFont(12);
    [self.contentView addSubview:self.addressLab];
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.introLab.mas_bottom).mas_offset(kWidth(10));
        make.left.right.equalTo(self.introLab);
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
