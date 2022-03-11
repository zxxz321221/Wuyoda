//
//  HomeAttractionsCollectionViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/14.
//

#import "HomeAttractionsCollectionViewCell.h"

@interface HomeAttractionsCollectionViewCell ()

@property (nonatomic , retain)UIImageView *imgV;
@property (nonatomic , retain)UILabel *titleLab;

@end

@implementation HomeAttractionsCollectionViewCell

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
    self.imgV.backgroundColor = [ColorManager ColorF2F2F2];
    self.imgV.layer.cornerRadius = kWidth(5);
    self.imgV.layer.masksToBounds = YES;
    self.imgV.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.imgV];
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.height.equalTo(self.contentView);
    }];
    
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.text = @"高雄市";
    self.titleLab.textColor = [ColorManager WhiteColor];
    self.titleLab.font = kFont(14);
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(10));
        make.bottom.mas_offset(kWidth(-7));
    }];
}

-(void)setImgName:(NSString *)imgName{
    [self.imgV setImage:kGetImage(imgName)];
}

-(void)setModel:(HomeCityModel *)model{
    _model = model;
    self.titleLab.text = model.city;
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.cover]]];
}

@end
