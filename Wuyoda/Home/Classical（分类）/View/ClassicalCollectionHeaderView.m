//
//  ClassicalCollectionHeaderView.m
//  Wuyoda
//
//  Created by 赵祥 on 2022/5/24.
//

#import "ClassicalCollectionHeaderView.h"

@interface ClassicalCollectionHeaderView ()

@property (nonatomic , retain)UILabel *titleLab;

@end

@implementation ClassicalCollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [ColorManager ColorF2F2F2];
    bgView.layer.cornerRadius = kWidth(5);
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(10));
        make.top.mas_offset(kWidth(10));
        make.right.mas_offset(kWidth(-20));
        make.height.mas_offset(kWidth(26));
    }];
    
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.text = @"休闲零食";
    self.titleLab.textColor = [ColorManager Color333333];
    self.titleLab.font = kFont(14);
    [bgView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView);
        make.left.mas_offset(kWidth(10));
    }];
}

-(void)setModel:(ClassicalGoodsModel *)model{
    self.titleLab.text = model.category_name;
}

@end
