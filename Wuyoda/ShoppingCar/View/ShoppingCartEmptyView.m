//
//  ShoppingCartEmptyView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/14.
//

#import "ShoppingCartEmptyView.h"

@implementation ShoppingCartEmptyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    UIImageView *emptyImgV = [[UIImageView alloc]initWithImage:kGetImage(@"购物车_空")];
    [self addSubview:emptyImgV];
    [emptyImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.mas_offset(kWidth(64));
        make.width.height.mas_offset(kWidth(90));
    }];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"购物车为空";
    titleLab.textColor = [ColorManager BlackColor];
    titleLab.font = kFont(18);
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(emptyImgV.mas_bottom).mas_offset(kWidth(20));
    }];
    
    UILabel *subLab = [[UILabel alloc]init];
    subLab.text = @"“赶紧慰劳一下自己吧”";
    subLab.textColor = [ColorManager BlackColor];
    subLab.font = kFont(14);
    [self addSubview:subLab];
    [subLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(titleLab.mas_bottom).mas_offset(kWidth(8));
    }];
    
    UIButton *shoppingBtn = [[UIButton alloc]init];
    [shoppingBtn setTitle:@"去逛逛" forState:UIControlStateNormal];
    [shoppingBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
    shoppingBtn.titleLabel.font = kFont(14);
    shoppingBtn.layer.cornerRadius = kWidth(14);
    shoppingBtn.layer.borderColor = [ColorManager ColorCCCCCC].CGColor;
    shoppingBtn.layer.borderWidth = kWidth(1);
    shoppingBtn.backgroundColor = [ColorManager WhiteColor];
    [shoppingBtn addTarget:self action:@selector(shoppingClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:shoppingBtn];
    [shoppingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(subLab.mas_bottom).mas_offset(kWidth(14));
        make.width.mas_offset(kWidth(78));
        make.height.mas_offset(kWidth(28));
    }];
}

-(void)shoppingClicked{
    [self.CurrentViewController.tabBarController setSelectedIndex:0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
