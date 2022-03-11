//
//  EvaluateImageCollectionViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/13.
//

#import "EvaluateImageCollectionViewCell.h"

@implementation EvaluateImageCollectionViewCell

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
    [self.contentView addSubview:self.imgV];
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(0);
        make.width.mas_offset(kWidth(100));
        make.height.mas_offset(kWidth(80));
    }];
}
@end
