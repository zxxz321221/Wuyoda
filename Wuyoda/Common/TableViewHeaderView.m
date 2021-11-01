//
//  TableViewHeaderView.m
//  HuoZhiShop
//
//  Created by MAC02 on 2020/12/31.
//

#import "TableViewHeaderView.h"

@implementation TableViewHeaderView

- (instancetype)initWithFrame:(CGRect)frame titleImg:(UIImage *)titleImg subTitleStr:(NSString *)subTitleStr subTitleColor:(UIColor *)subTitltColor subTitleFontSize:(CGFloat)subTitleFont {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *titleImV = [[UIImageView alloc] init];
        titleImV.image = titleImg;
        [self addSubview:titleImV];
        titleImV.contentMode = UIViewContentModeScaleAspectFill;
        [titleImV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.mas_offset(kWidth(80));
            make.height.mas_offset(kWidth(29));
        }];
        
        if (!kStringEmpty(subTitleStr)) {
            UILabel *subTitleLab = [UILabel kk_labelWithTitle:subTitleStr color:subTitltColor fontSize:subTitleFont];
            [self addSubview:subTitleLab];
            [subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.top.equalTo(titleImV.mas_bottom).mas_offset(kWidth(3));
                make.width.mas_offset(kWidth(300));
                make.height.mas_offset(kWidth(13));
            }];
        }
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
