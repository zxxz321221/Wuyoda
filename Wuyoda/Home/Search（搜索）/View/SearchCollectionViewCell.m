//
//  SearchCollectionViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2022/5/24.
//

#import "SearchCollectionViewCell.h"

@implementation SearchCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    self.titleLab = [[UILabel alloc]initWithFrame:self.contentView.bounds];
    self.titleLab.textColor = [ColorManager Color666666];
    self.titleLab.font = kFont(12);
    self.titleLab.backgroundColor = [ColorManager ColorF2F2F2];
    self.titleLab.layer.cornerRadius = kWidth(12);
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.layer.masksToBounds = YES;
    [self.contentView addSubview:self.titleLab];
    
}

@end
