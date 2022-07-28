//
//  MineOrderCollectionViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/28.
//

#import "MineOrderCollectionViewCell.h"

@implementation MineOrderCollectionViewCell

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
    self.imgV.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.imgV];
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(self.contentView);
        make.width.mas_offset(kWidth(24));
        make.height.mas_offset(kWidth(24));
    }];
    
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.textColor = [ColorManager Color7F7F7F];
    self.titleLab.font = kFont(16);
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.imgV.mas_bottom).mas_offset(kWidth(16));
    }];
}

@end
