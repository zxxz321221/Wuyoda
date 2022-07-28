//
//  AgreementAlertView.m
//  Wuyoda
//
//  Created by 赵祥 on 2022/5/19.
//

#import "AgreementAlertView.h"

@implementation AgreementAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    UIView *shadowView = [[UIView alloc]initWithFrame:self.bounds];
    shadowView.backgroundColor = [ColorManager BlackColor];
    shadowView.alpha = 0.5;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
    [shadowView addGestureRecognizer:tap];
    [self addSubview:shadowView];
    
    UIView *bgV = [[UIView alloc]init];
    bgV.backgroundColor = [ColorManager WhiteColor];
    bgV.layer.cornerRadius = kWidth(10);
    [self addSubview:bgV];
    [bgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.mas_offset(kWidth(254));
        make.width.mas_offset(kWidth(300));
        make.height.mas_offset(kWidth(193));
    }];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"同意隐私条款";
    titleLab.textColor = [ColorManager Color333333];
    titleLab.font = kBoldFont(18);
    [bgV addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgV);
        make.top.mas_offset(kWidth(24));
    }];
    
    UILabel *messageLab = [[UILabel alloc]init];
    NSString * showText = @"注册/登录即代表您年满18岁，已认真阅读并同意接受wuyoda《服务条款》、《隐私政策》";
    messageLab.attributedText = [NSString getAttributeWith:@[@"《服务条款》",@"《隐私政策》"] string:showText orginFont:kFont(13) orginColor:[ColorManager Color7F7F7F] attributeFont:kBoldFont(13) attributeColor:[ColorManager MainColor]];
    [bgV addSubview:messageLab];
    messageLab.numberOfLines = 0;
    [messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(30));
        make.right.mas_offset(kWidth(-30));
        make.top.mas_offset(kWidth(60));
    }];
    
    [messageLab yb_addAttributeTapActionWithStrings:@[@"《服务条款》",@"《隐私政策》"] tapClicked:^(UILabel *label, NSString *string, NSRange range, NSInteger index) {

        NSLog(@"%@",string);

    }];
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = [ColorManager ColorF2F2F2];
    [bgV addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bgV);
        make.bottom.mas_offset(kWidth(-40));
        make.height.mas_offset(kWidth(0.5));
    }];
    
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = [ColorManager ColorF2F2F2];
    [bgV addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.equalTo(bgV);
        make.width.mas_offset(kWidth(0.5));
        make.height.mas_offset(kWidth(40));
    }];
    
    UIButton *disagreementBtn = [[UIButton alloc]init];
    [disagreementBtn setTitle:@"不同意" forState:UIControlStateNormal];
    [disagreementBtn setTitleColor:[ColorManager Color333333] forState:UIControlStateNormal];
    disagreementBtn.titleLabel.font = kFont(18);
    [disagreementBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [bgV addSubview:disagreementBtn];
    [disagreementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(bgV);
        make.width.mas_offset(kWidth(150));
        make.height.mas_offset(kWidth(40));
    }];
    
    self.agreementBtn = [[UIButton alloc]init];
    [self.agreementBtn setTitle:@"我同意" forState:UIControlStateNormal];
    [self.agreementBtn setTitleColor:[ColorManager MainColor] forState:UIControlStateNormal];
    self.agreementBtn.titleLabel.font = kFont(18);
    [bgV addSubview:self.agreementBtn];
    [self.agreementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(bgV);
        make.width.mas_offset(kWidth(150));
        make.height.mas_offset(kWidth(40));
    }];
}


-(void)close{
    [self removeFromSuperview];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
