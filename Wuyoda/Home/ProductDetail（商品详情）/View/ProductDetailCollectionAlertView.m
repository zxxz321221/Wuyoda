//
//  ProductDetailCollectionAlertView.m
//  Wuyoda
//
//  Created by 赵祥 on 2022/7/5.
//

#import "ProductDetailCollectionAlertView.h"

@implementation ProductDetailCollectionAlertView

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
        make.top.mas_offset(kWidth(274));
        make.width.mas_offset(kWidth(300));
        make.height.mas_offset(kWidth(153));
    }];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"提示";
    titleLab.textColor = [ColorManager Color333333];
    titleLab.font = kBoldFont(18);
    [bgV addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgV);
        make.top.mas_offset(kWidth(24));
    }];
    
    UILabel *messageLab = [[UILabel alloc]init];
    messageLab.text = @"是否移出心愿单";
    messageLab.textColor = [ColorManager Color7F7F7F];
    messageLab.numberOfLines = 0;
    messageLab.textAlignment = NSTextAlignmentCenter;
    messageLab.font = kBoldFont(13);
    [bgV addSubview:messageLab];
    [messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(30));
        make.right.mas_offset(kWidth(-30));
        make.top.mas_offset(kWidth(65));
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
    
    UIButton *cancelBtn = [[UIButton alloc]init];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[ColorManager Color333333] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = kFont(18);
    [cancelBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [bgV addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(bgV);
        make.width.mas_offset(kWidth(150));
        make.height.mas_offset(kWidth(40));
    }];
    
    self.doneBtn = [[UIButton alloc]init];
    [self.doneBtn setTitle:@"确认" forState:UIControlStateNormal];
    [self.doneBtn setTitleColor:[ColorManager MainColor] forState:UIControlStateNormal];
    self.doneBtn.titleLabel.font = kFont(18);
    [bgV addSubview:self.doneBtn];
    [self.doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
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
