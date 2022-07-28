//
//  TWProductListNormalTitleView.m
//  Wuyoda
//
//  Created by 赵祥 on 2022/5/30.
//

#import "TWProductListNormalTitleView.h"

@implementation TWProductListNormalTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"300优质推荐商品";
    titleLab.textColor = [ColorManager BlackColor];
    titleLab.font = kFont(24);
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(kWidth(20));
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
