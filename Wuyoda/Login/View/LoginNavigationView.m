//
//  LoginNavigationView.m
//  Wuyoda
//
//  Created by 赵祥 on 2022/6/20.
//

#import "LoginNavigationView.h"

@implementation LoginNavigationView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.textColor = [ColorManager WhiteColor];
    self.titleLab.font = kFont(18);
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.mas_offset(kWidth(-10));
    }];
    
    self.backBtn = [[UIButton alloc]init];
    [self.backBtn setImage:kGetImage(@"白色返回") forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLab);
        make.left.mas_offset(kWidth(24));
        make.width.height.mas_offset(kWidth(16));
    }];
}

-(void)backClicked{
    if (self.CurrentViewController.navigationController.viewControllers.count == 1) {
        [[NSUserDefaults standardUserDefaults] setValue:@"logout" forKey:@"firstOpen"];
        [self.CurrentViewController dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.CurrentViewController.navigationController popViewControllerAnimated:YES];
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
