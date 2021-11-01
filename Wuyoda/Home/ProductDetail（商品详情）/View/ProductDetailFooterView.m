//
//  ProductDetailFooterView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/16.
//

#import "ProductDetailFooterView.h"
#import "CWStarRateView.h"

@interface ProductDetailFooterView ()

@property (nonatomic , retain)UILabel *priceLab;
@property (nonatomic , retain)UILabel *oldPriceLab;
@property (nonatomic , retain)UILabel *unitLab;
@property (nonatomic , retain)CWStarRateView *starV;
@property (nonatomic , retain)UILabel *recommendLab;

@end

@implementation ProductDetailFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.priceLab = [[UILabel alloc]init];
    self.priceLab.text = @"￥211";
    self.priceLab.textColor = [ColorManager BlackColor];
    self.priceLab.font = kBoldFont(16);
    [self addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.mas_offset(kWidth(15));
    }];
    
    self.oldPriceLab = [[UILabel alloc]init];
    self.oldPriceLab.textColor = [ColorManager Color555555];
    self.oldPriceLab.font = kFont(12);
    NSMutableAttributedString *oldPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",@"264"]];
    [oldPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, oldPrice.length)];
    self.oldPriceLab.attributedText = oldPrice;
    [self addSubview:self.oldPriceLab];
    [self.oldPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLab.mas_right).mas_offset(kWidth(6));
        make.bottom.equalTo(self.priceLab);
    }];
    
    self.unitLab = [[UILabel alloc]init];
    self.unitLab.text = @"/盒";
    self.unitLab.textColor = [ColorManager Color555555];
    self.unitLab.font = kFont(12);
    [self addSubview:self.unitLab];
    [self.unitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.oldPriceLab.mas_right).mas_offset(kWidth(6));
        make.centerY.equalTo(self.oldPriceLab);
    }];
    
    [self layoutIfNeeded];
    
    self.starV = [[CWStarRateView alloc]initWithFrame:CGRectMake(kWidth(20), self.priceLab.frame.origin.y+self.priceLab.bounds.size.height+kWidth(7), kWidth(80), kWidth(15)) numberOfStars:5];
    self.starV.scorePercent = 0.8;
    [self addSubview:self.starV];
    
    self.recommendLab = [[UILabel alloc]init];
    self.recommendLab.text = @"98%客人推荐";
    self.recommendLab.textColor = [ColorManager Color555555];
    self.recommendLab.font = kFont(12);
    [self addSubview:self.recommendLab];
    [self.recommendLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.starV);
        make.top.equalTo(self.starV.mas_bottom).mas_offset(kWidth(7));
    }];
    
    UIButton *shoppingCartBtn = [[UIButton alloc]init];
    [shoppingCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [shoppingCartBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    shoppingCartBtn.titleLabel.font = kFont(14);
    shoppingCartBtn.backgroundColor = [ColorManager ColorD8001B];
    shoppingCartBtn.layer.cornerRadius = kWidth(5);
    [shoppingCartBtn addTarget:self action:@selector(addShoppingCartClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:shoppingCartBtn];
    [shoppingCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kWidth(28));
        make.right.mas_offset(kWidth(-22));
        make.width.mas_offset(kWidth(120));
        make.height.mas_offset(kWidth(40));
    }];
}

-(void)addShoppingCartClicked:(UIButton *)sender{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *shoppingCart = [[userDefaults valueForKey:@"shoppingCart"] mutableCopy];
    [shoppingCart addObject:@"0"];
    [userDefaults setObject:shoppingCart forKey:@"shoppingCart"];
    [userDefaults synchronize];
    
    [self showHUDWithText:@"加入购物车成功" withYOffSet:0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
