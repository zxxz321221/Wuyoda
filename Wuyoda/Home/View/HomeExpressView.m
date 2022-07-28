//
//  HomeExpressView.m
//  Wuyoda
//
//  Created by 赵祥 on 2022/5/20.
//

#import "HomeExpressView.h"

@interface HomeExpressView ()

@property (nonatomic , retain)UIButton *expressBtn;
@property (nonatomic , retain)UIButton *currentBtn;

@property (nonatomic , retain)UIImageView *expressImgV;

@end

@implementation HomeExpressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    UIView *bgV = [[UIView alloc]initWithFrame:self.bounds];
    bgV.backgroundColor = [ColorManager WhiteColor];
    bgV.layer.cornerRadius = kWidth(20);
    //定义view的阴影颜色
    bgV.layer.shadowColor = [ColorManager BlackColor].CGColor;
    //阴影偏移量
    bgV.layer.shadowOffset = CGSizeMake(0, 4);
    //定义view的阴影宽度，模糊计算的半径
    bgV.layer.shadowRadius = 6;
    //定义view的阴影透明度，注意:如果view没有设置背景色阴影也是不会显示的
    bgV.layer.shadowOpacity = 0.15;
    [self addSubview:bgV];
    
    self.expressBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kWidth(168), kWidth(40))];
    [self.expressBtn setTitle:@"邮寄" forState:UIControlStateNormal];
    [self.expressBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    self.expressBtn.titleLabel.font = kFont(14);
    [self.expressBtn setBackgroundImage:kGetImage(@"邮寄") forState:UIControlStateNormal];
    [self.expressBtn addTarget:self action:@selector(changeExpressTypeClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bgV addSubview:self.expressBtn];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.expressBtn.bounds byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(kWidth(15), kWidth(15))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame =  self.expressBtn.bounds;
    maskLayer.path = maskPath.CGPath;
    self.expressBtn.layer.mask = maskLayer;
    
    self.currentBtn = [[UIButton alloc]initWithFrame:CGRectMake(kWidth(168), 0, kWidth(168), kWidth(40))];
    [self.currentBtn setTitle:@"当地配送" forState:UIControlStateNormal];
    [self.currentBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
    self.currentBtn.titleLabel.font = kFont(14);
    [self.currentBtn addTarget:self action:@selector(changeExpressTypeClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bgV addSubview:self.currentBtn];
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:self.currentBtn.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomLeft cornerRadii:CGSizeMake(kWidth(15), kWidth(15))];
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame =  self.currentBtn.bounds;
    maskLayer1.path = maskPath1.CGPath;
    self.currentBtn.layer.mask = maskLayer1;
    
    self.expressImgV = [[UIImageView alloc]init];
    [self.expressImgV setImage:kGetImage(@"首页邮寄配图")];
    self.expressImgV.backgroundColor = [ColorManager RandomColor];
    self.expressImgV.layer.cornerRadius = kWidth(10);
    self.expressImgV.layer.masksToBounds = YES;
    [bgV addSubview:self.expressImgV];
    [self.expressImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.width.equalTo(bgV);
        make.height.mas_offset(kWidth(170));
    }];
    
}

-(void)changeExpressTypeClicked:(UIButton *)sender{
    if (sender == self.expressBtn) {
        self.expressType = @"express";
        
        [self.currentBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
        [self.currentBtn setBackgroundImage:kGetImage(@"") forState:UIControlStateNormal];
        [self.expressBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
        [self.expressBtn setBackgroundImage:kGetImage(@"邮寄") forState:UIControlStateNormal];
 
    }else{
        self.expressType = @"current";
        
        [self.expressBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
        [self.expressBtn setBackgroundImage:kGetImage(@"") forState:UIControlStateNormal];
        [self.currentBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
        [self.currentBtn setBackgroundImage:kGetImage(@"当地配送") forState:UIControlStateNormal];

    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
