//
//  CityDetailHeaderView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/22.
//

#import "CityDetailHeaderView.h"

@interface CityDetailHeaderView ()

@property (nonatomic , retain)UIImageView *imgV;

@property (nonatomic , retain)UILabel *introLab;

@end

@implementation CityDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    self.backgroundColor = [ColorManager WhiteColor];
    
    self.imgV = [[UIImageView alloc]initWithImage:kGetImage(@"地图单张")];
    //self.imgV.backgroundColor = [ColorManager RandomColor];
    [self addSubview:self.imgV];
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(16));
        make.right.mas_offset(-16);
        make.top.mas_offset(kWidth(5));
        make.height.mas_offset(kWidth(174));
    }];
    
    self.introLab = [[UILabel alloc]init];
    self.introLab.text = @"台中市，别名中市，是台湾省中部的经济、交通、文化中心，始建于清朝，公元1886年（清光绪十二年）曾一度为台湾府的府治。\n全市下辖29个区，总面积约2215平方公里，设籍人口279.4万人（2018年），为台湾省人口排名第四的城市，也是台中都会区的核心都市。 2016年GaWC所公布之世界级城市名单中，台中市被列为Gamma-等级之城市。";
    self.introLab.textColor = [ColorManager Color333333];
    self.introLab.font = kFont(16);
    self.introLab.numberOfLines = 0;
    self.introLab.lineBreakMode = NSLineBreakByCharWrapping;
    [self addSubview:self.introLab];
    [self.introLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.right.mas_offset(-20);
        make.top.equalTo(self.imgV.mas_bottom).mas_offset(kWidth(14));
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
