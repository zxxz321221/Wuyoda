//
//  ClassicalProductListHeaderView.m
//  Wuyoda
//
//  Created by 赵祥 on 2022/6/16.
//

#import "ClassicalProductListHeaderView.h"

@interface ClassicalProductListHeaderView ()

@end

@implementation ClassicalProductListHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.backgroundColor = [ColorManager WhiteColor];
    self.addressBtn = [[UIButton alloc]init];
    [self.addressBtn setTitle:@"产地:默认" forState:UIControlStateNormal];
    [self.addressBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
    self.addressBtn.titleLabel.font = kFont(14);
    [self.addressBtn setImage:kGetImage(@"下拉icon") forState:UIControlStateNormal];
    [self.addressBtn setImage:kGetImage(@"") forState:UIControlStateSelected];
    self.addressBtn.imageEdgeInsets = UIEdgeInsetsMake(0, kWidth(90), 0, 0);
    self.addressBtn.titleEdgeInsets = UIEdgeInsetsMake(0, kWidth(-30), 0, 0);
    self.addressBtn.layer.cornerRadius = kWidth(5);
    self.addressBtn.backgroundColor = [ColorManager ColorF2F2F2];
    [self addSubview:self.addressBtn];
    [self.addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.centerY.equalTo(self);
        make.width.mas_offset(kWidth(110));
        make.height.mas_offset(kWidth(36));
    }];
    
    self.priceBtn = [[UIButton alloc]init];
    [self.priceBtn setTitle:@"价格" forState:UIControlStateNormal];
    [self.priceBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
    self.priceBtn.titleLabel.font = kFont(14);
    [self.priceBtn setImage:kGetImage(@"下拉icon") forState:UIControlStateNormal];
    [self.priceBtn setImage:kGetImage(@"") forState:UIControlStateSelected];
//    [self.priceBtn addTarget:self action:@selector(selectTypeClicekd:) forControlEvents:UIControlEventTouchUpInside];
    self.priceBtn.imageEdgeInsets = UIEdgeInsetsMake(0, kWidth(80), 0, 0);
    self.priceBtn.titleEdgeInsets = UIEdgeInsetsMake(0, kWidth(-30), 0, 0);
    self.priceBtn.layer.cornerRadius = kWidth(5);
    self.priceBtn.backgroundColor = [ColorManager ColorF2F2F2];
    [self addSubview:self.priceBtn];
    [self.priceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self).mas_offset(kWidth(10));
        make.width.mas_offset(kWidth(100));
        make.height.mas_offset(kWidth(36));
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
