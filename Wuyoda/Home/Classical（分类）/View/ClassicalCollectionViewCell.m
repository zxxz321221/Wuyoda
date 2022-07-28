//
//  ClassicalCollectionViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2022/5/24.
//

#import "ClassicalCollectionViewCell.h"

@interface ClassicalCollectionViewCell ()

@property (nonatomic , retain)UIImageView *imgV;

@property (nonatomic , retain)UILabel *titleLab;

@end

@implementation ClassicalCollectionViewCell

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
    self.imgV.contentMode = UIViewContentModeScaleAspectFit;
    self.imgV.layer.cornerRadius = kWidth(5);
    [self.contentView addSubview:self.imgV];
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(self.contentView);
        make.width.height.mas_offset(kWidth(50));
    }];
    
    
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.textColor = [ColorManager Color333333];
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.font = kFont(12);
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.imgV.mas_bottom).mas_offset(kWidth(12));
        make.width.mas_offset(kWidth(55));
    }];
}

-(void)setModel:(ClassicalGoodsModel *)model{
    self.titleLab.text = model.category_name;
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.category_file1]];
    
}

@end
