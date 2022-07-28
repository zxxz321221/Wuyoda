//
//  PasswordSettingAlertView.m
//  Wuyoda
//
//  Created by 赵祥 on 2022/7/20.
//

#import "PasswordSettingAlertView.h"

@implementation PasswordSettingAlertView

-(instancetype)initWithFrame:(CGRect)frame{
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
        make.top.mas_offset(kWidth(274));
        make.width.mas_offset(kWidth(300));
        make.height.mas_offset(kWidth(170));
    }];
    
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setImage:kGetImage(@"关闭") forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.alpha = 0.6;
    [bgV addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kWidth(15));
        make.right.mas_offset(kWidth(-15));
        make.width.height.mas_offset(kWidth(15));
    }];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"提示";
    titleLab.textColor = [ColorManager Color333333];
    titleLab.font = kBoldFont(18);
    [bgV addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgV);
        make.top.mas_offset(kWidth(30));
    }];
    
    UILabel *messageLab = [[UILabel alloc]init];
    messageLab.text = @"跳过密码设置可能会对账号安全受到影响，是否跳过密码设置？";
    messageLab.textColor = [ColorManager Color7F7F7F];
    messageLab.numberOfLines = 0;
    messageLab.textAlignment = NSTextAlignmentCenter;
    messageLab.font = kBoldFont(13);
    [bgV addSubview:messageLab];
    [messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(30));
        make.right.mas_offset(kWidth(-30));
        make.top.mas_offset(kWidth(70));
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
    
    self.passBtn = [[UIButton alloc]init];
    [self.passBtn setTitle:@"跳过" forState:UIControlStateNormal];
    [self.passBtn setTitleColor:[ColorManager Color333333] forState:UIControlStateNormal];
    self.passBtn.titleLabel.font = kFont(18);
//    [self.passBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [bgV addSubview:self.passBtn];
    [self.passBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(bgV);
        make.width.mas_offset(kWidth(150));
        make.height.mas_offset(kWidth(40));
    }];
    
    self.settingBtn = [[UIButton alloc]init];
    [self.settingBtn setTitle:@"不再提示" forState:UIControlStateNormal];
    [self.settingBtn setTitleColor:[ColorManager MainColor] forState:UIControlStateNormal];
    self.settingBtn.titleLabel.font = kFont(18);
    [bgV addSubview:self.settingBtn];
    [self.settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
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
