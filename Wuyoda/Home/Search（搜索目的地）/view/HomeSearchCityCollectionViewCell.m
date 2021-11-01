//
//  HomeSearchCityCollectionViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/16.
//

#import "HomeSearchCityCollectionViewCell.h"

@interface HomeSearchCityCollectionViewCell ()

@property (nonatomic , retain)UILabel *cityLab;

@end

@implementation HomeSearchCityCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.cityLab = [[UILabel alloc]initWithFrame:self.bounds];
        self.cityLab.text = @"台北市";
        self.cityLab.textColor = [ColorManager Color777777];
        self.cityLab.font = kFont(14);
        self.cityLab.layer.borderColor = [ColorManager ColorD7D7D7].CGColor;
        self.cityLab.layer.borderWidth = 1;
        self.cityLab.layer.cornerRadius = kWidth(5);
        self.cityLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.cityLab];
    }
    return self;
}

@end
