//
//  OrderRemarkView.m
//  Wuyoda
//
//  Created by 赵祥 on 2022/6/9.
//

#import "OrderRemarkView.h"

@interface OrderRemarkView ()<UITextViewDelegate>

@property (nonatomic , retain)UIView *bgView;

@property (nonatomic , retain)UITextView *textV;

@property (nonatomic , retain)UILabel *placeholderLab;

@end

@implementation OrderRemarkView

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
    
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height, kScreenWidth, kScreenHeight-kWidth(392))];
    self.bgView.cornerRadius = kWidth(10);
    self.bgView.backgroundColor = [ColorManager ColorF7F7F7];
    [self addSubview:self.bgView];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"订单备注";
    titleLab.textColor = [ColorManager BlackColor];
    titleLab.font = kFont(16);
    [self.bgView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView);
        make.top.mas_offset(kWidth(20));
    }];
    
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setImage:kGetImage(@"关闭") forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-17));
        make.top.mas_offset(kWidth(20));
        make.width.height.mas_offset(kWidth(18));
    }];
    
    UIView *textBgV = [[UIView alloc]initWithFrame:CGRectMake(kWidth(20), kWidth(58), kWidth(336), kWidth(120))];
    textBgV.backgroundColor = [ColorManager ColorF2F2F2];
    textBgV.layer.cornerRadius = kWidth(10);
    [self.bgView addSubview:textBgV];
    
    self.textV = [[UITextView alloc]init];
    self.textV.textColor = [ColorManager Color333333];
    self.textV.font = kFont(14);
    self.textV.backgroundColor = [ColorManager ColorF2F2F2];
    self.textV.delegate = self;
    [textBgV addSubview:self.textV];
    [self.textV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(14));
        make.top.mas_offset(kWidth(12));
        make.right.mas_offset(kWidth(-20));
        make.bottom.mas_offset(kWidth(-20));
    }];
    
    self.placeholderLab = [[UILabel alloc]init];
    self.placeholderLab.text = @"选填，请填写您的要求";
    self.placeholderLab.textColor = [ColorManager Color666666];
    self.placeholderLab.font = kFont(14);
    [textBgV addSubview:self.placeholderLab];
    [self.placeholderLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(18));
        make.top.mas_offset(kWidth(18));
    }];
    
    UIButton *doneBtn = [[UIButton alloc]init];
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    [doneBtn setBackgroundImage:kGetImage(@"login_按钮") forState:UIControlStateNormal];
    doneBtn.titleLabel.font = kFont(16);
    [doneBtn addTarget:self action:@selector(doneClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:doneBtn];
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView);
        make.bottom.mas_offset(kWidth(-20)-kHeight_SafeArea);
        make.width.mas_offset(kWidth(335));
        make.height.mas_offset(kWidth(48));
    }];
    
}

- (void)show{
    [UIView animateWithDuration:0.5 animations:^{
        self.bgView.frame = CGRectMake(0, self.bounds.size.height-kWidth(382), kScreenWidth, kWidth(392));
    }];
}

-(void)close{
    [UIView animateWithDuration:0.5 animations:^{
        CGRectMake(0, self.bounds.size.height, kScreenWidth, kScreenHeight-kWidth(392));
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
}

-(void)doneClicked{
    if (self.delegate && [self.delegate respondsToSelector:@selector(insertOrderRemark:)]) {
        [self.delegate insertOrderRemark:self.textV.text];
        [self close];
    }
}

-(void)textViewDidChange:(UITextView *)textView{
    self.placeholderLab.hidden = textView.text.length;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
