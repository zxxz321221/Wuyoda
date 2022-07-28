//
//  SearchCollectionHeaderView.m
//  Wuyoda
//
//  Created by 赵祥 on 2022/5/24.
//

#import "SearchCollectionHeaderView.h"

@implementation SearchCollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.textColor = [ColorManager Color333333];
    self.titleLab.font = kFont(14);
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_offset(kWidth(20));
    }];
    
    self.delBtn = [[UIButton alloc]init];
    [self.delBtn setImage:kGetImage(@"搜索删除") forState:UIControlStateNormal];
    [self addSubview:self.delBtn];
    [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLab);
        make.right.mas_offset(kWidth(-20));
        make.width.height.mas_offset(kWidth(15));
    }];
}

@end
