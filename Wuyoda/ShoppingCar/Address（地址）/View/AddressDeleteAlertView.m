//
//  AddressDeleteAlertView.m
//  Wuyoda
//
//  Created by 赵祥 on 2022/6/6.
//

#import "AddressDeleteAlertView.h"

@implementation AddressDeleteAlertView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    UIView *shadowV = [[UIView alloc]initWithFrame:self.bounds];
    shadowV.backgroundColor = [ColorManager BlackColor];
    shadowV.alpha = 0.5;
    [self addSubview:shadowV];
    
    UIView *bgV = [[UIView alloc]init];
    bgV.backgroundColor = [ColorManager WhiteColor];
    bgV.layer.cornerRadius = kWidth(5);
    [self addSubview:bgV];
    [bgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.mas_offset(kWidth(236));
        make.width.mas_offset(kWidth(270));
        make.height.mas_offset(kWidth(128));
    }];
    
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"确认删除该地址吗？";
    titleLab.textColor = [ColorManager BlackColor];
    titleLab.font = kFont(16);
    [bgV addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kWidth(19));
        make.centerX.equalTo(bgV);
    }];
    
    UIButton *cancelBtn = [[UIButton alloc]init];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[ColorManager MainColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = kFont(14);
    cancelBtn.layer.cornerRadius = kWidth(20);
    cancelBtn.layer.borderColor = [ColorManager MainColor].CGColor;
    cancelBtn.layer.borderWidth = kWidth(1);
    [cancelBtn addTarget:self action:@selector(cancelClicked) forControlEvents:UIControlEventTouchUpInside];
    [bgV addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(kWidth(-15));
        make.left.mas_offset(kWidth(20));
        make.width.mas_offset(kWidth(100));
        make.height.mas_offset(kWidth(40));
    }];
    
    self.deleteBtn = [[UIButton alloc]init];
    [self.deleteBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    self.deleteBtn.titleLabel.font = kFont(14);
    self.deleteBtn.layer.cornerRadius = kWidth(20);
    self.deleteBtn.layer.masksToBounds = YES;
    [self.deleteBtn setBackgroundImage:kGetImage(@"推荐按钮") forState:UIControlStateNormal];
    [bgV addSubview:self.deleteBtn];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(kWidth(-15));
        make.right.mas_offset(kWidth(-20));
        make.width.mas_offset(kWidth(100));
        make.height.mas_offset(kWidth(40));
    }];
}

-(void)cancelClicked{
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
