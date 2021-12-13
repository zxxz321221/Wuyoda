//
//  OrderDetailFooterView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/11/11.
//

#import "OrderDetailFooterView.h"

@implementation OrderDetailFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    UILabel *goodAllPriceTitleLab = [[UILabel alloc]init];
    goodAllPriceTitleLab.text = @"商品总价";
    goodAllPriceTitleLab.textColor = [ColorManager ColorCCCCCC];
    goodAllPriceTitleLab.font = kFont(14);
    [self addSubview:goodAllPriceTitleLab];
    [goodAllPriceTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(55));
        make.top.mas_offset(kWidth(14));
    }];
    
    self.goodAllPriceLab = [[UILabel alloc]init];
    self.goodAllPriceLab.text = @"￥349.00";
    self.goodAllPriceLab.textColor = [ColorManager ColorCCCCCC];
    self.goodAllPriceLab.font = kFont(14);
    [self addSubview:self.goodAllPriceLab];
    [self.goodAllPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-13));
        make.centerY.equalTo(goodAllPriceTitleLab);
    }];
    

    self.allPriceLab = [[UILabel alloc]init];
    self.allPriceLab.text = @"￥349.00";
    self.allPriceLab.textColor = [UIColor redColor];
    self.allPriceLab.font = kFont(16);
    [self addSubview:self.allPriceLab];
    [self.allPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-13));
        make.top.equalTo(goodAllPriceTitleLab.mas_bottom).mas_offset(kWidth(14));
    }];

    UILabel *allPriceTitleLab = [[UILabel alloc]init];
    allPriceTitleLab.text = @"合计：";
    allPriceTitleLab.textColor = [ColorManager ColorCCCCCC];
    allPriceTitleLab.font = kFont(16);
    [self addSubview:allPriceTitleLab];
    [allPriceTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.allPriceLab.mas_left);
        make.centerY.equalTo(self.allPriceLab);
    }];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = [ColorManager ColorF2F2F2];
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.width.equalTo(self);
        make.height.mas_offset(kWidth(1));
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
