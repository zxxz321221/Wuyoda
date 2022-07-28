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
    
    UIView *bgV = [[UIView alloc]initWithFrame:CGRectMake(kWidth(0), 0, kWidth(320), kWidth(210))];
    bgV.backgroundColor = [ColorManager WhiteColor];
    bgV.layer.cornerRadius = kWidth(10);
    //定义view的阴影颜色
    bgV.layer.shadowColor = [ColorManager BlackColor].CGColor;
    //阴影偏移量
    bgV.layer.shadowOffset = CGSizeMake(0, 4);
    //定义view的阴影宽度，模糊计算的半径
    bgV.layer.shadowRadius = 6;
    //定义view的阴影透明度，注意:如果view没有设置背景色阴影也是不会显示的
    bgV.layer.shadowOpacity = 0.15;
    [self addSubview:bgV];
    
    
    self.imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWidth(320), kWidth(160))];
    self.imgV.backgroundColor = [ColorManager ColorF2F2F2];
    self.imgV.layer.masksToBounds = YES;
    self.imgV.contentMode = UIViewContentModeScaleAspectFill;
    [bgV addSubview:self.imgV];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.imgV.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(kWidth(10), kWidth(10))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame =  self.imgV.bounds;
    maskLayer.path = maskPath.CGPath;
    self.imgV.layer.mask = maskLayer;
    
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.textColor = [ColorManager BlackColor];
    self.titleLab.font = kFont(14);
    [bgV addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.equalTo(self.imgV.mas_bottom).mas_offset(kWidth(14));
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
