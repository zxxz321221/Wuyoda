//
//  LogoffDoneView.m
//  TakeThings-iOS
//
//  Created by 赵祥 on 2022/2/10.
//  Copyright © 2022 GUIZM. All rights reserved.
//

#import "LogoffDoneView.h"

@implementation LogoffDoneView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    UIView *shadowV = [[UIView alloc]initWithFrame:self.bounds];
    shadowV.backgroundColor = [UIColor blackColor];
    shadowV.alpha = 0.5;
    [self addSubview:shadowV];
    
    UIView *alertBG = [[UIView alloc]init];
    alertBG.backgroundColor = [UIColor whiteColor];
    alertBG.layer.cornerRadius = kWidth(10);
    [self addSubview:alertBG];
    [alertBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_offset(kWidth(345));
        make.height.mas_offset(kWidth(210));
    }];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"账户注销确认";
    titleLab.textColor = [ColorManager Color333333];
    titleLab.font = [UIFont systemFontOfSize:16];
    [alertBG addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(alertBG);
        make.top.mas_offset(kWidth(30));
    }];
    
    UILabel *msgLab = [[UILabel alloc]init];
    msgLab.text = @"提交申请后，将不能再进行购买、委托等交易行为，账户注销后，您在平台等所有权益也将一并失效";
    msgLab.textColor = [ColorManager Color666666];
    msgLab.font = [UIFont systemFontOfSize:14];
    msgLab.numberOfLines = 0;
    msgLab.lineBreakMode = NSLineBreakByCharWrapping;
    [alertBG addSubview:msgLab];
    [msgLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLab.mas_bottom).mas_offset(kWidth(15));
        make.left.mas_offset(kWidth(50));
        make.right.mas_offset(kWidth(-50));
    }];
    
    UIButton *cancelBtn = [[UIButton alloc]init];
    [cancelBtn setTitle:@"暂不注销" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelBtn.layer.cornerRadius = kWidth(20);
    cancelBtn.backgroundColor = [ColorManager MainColor];
    [cancelBtn addTarget:self action:@selector(cancelClicked:) forControlEvents:UIControlEventTouchUpInside];
    [alertBG addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(15));
        make.top.equalTo(msgLab.mas_bottom).mas_offset(kWidth(20));
        make.width.mas_offset(kWidth(145));
        make.height.mas_offset(kWidth(40));
    }];
    
    self.doneBtn = [[UIButton alloc]init];
    [self.doneBtn setTitle:@"确认注销" forState:UIControlStateNormal];
    [self.doneBtn setTitleColor:[ColorManager MainColor] forState:UIControlStateNormal];
    self.doneBtn.layer.cornerRadius = kWidth(20);
    self.doneBtn.backgroundColor = [UIColor whiteColor];
    self.doneBtn.layer.borderColor = [ColorManager MainColor].CGColor;
    self.doneBtn.layer.borderWidth = kWidth(1);
    [alertBG addSubview:self.doneBtn];
    [self.doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-15));
        make.top.equalTo(msgLab.mas_bottom).mas_offset(kWidth(20));
        make.width.mas_offset(kWidth(145));
        make.height.mas_offset(kWidth(40));
    }];
    
}

-(void)cancelClicked:(id)sender{
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
