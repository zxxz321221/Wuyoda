//
//  FJNormalNavView.m
//  TaiYouHui
//
//  Created by 樊静 on 2020/7/2.
//  Copyright © 2020 Sunflower. All rights reserved.
//

#import "FJNormalNavView.h"
@interface FJNormalNavView()
@property (nonatomic, strong) UIViewController *controller;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *titleLab;
@end

@implementation FJNormalNavView
- (instancetype)initWithFrame:(CGRect)frame controller:(nonnull UIViewController *)controller titleStr:(NSString *)titleStr {
    self = [super initWithFrame:frame];
    if (self) {
        self.controller = controller;
        self.backgroundColor = [UIColor whiteColor];
        
        self.backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self addSubview:_backBtn];
        [_backBtn setImage:kGetImage(@"返回") forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backBtnClickAction) forControlEvents:UIControlEventTouchUpInside];
//        self.backBtn.sd_layout.leftSpaceToView(self, 0).widthIs(kWidth(45)).bottomSpaceToView(self, 0).heightIs(kHeight_NavBar-kHeight_StatusBar);
        [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(kWidth(10));
            make.bottom.mas_offset(kWidth(0));
            make.width.mas_offset(kWidth(45));
            make.height.mas_offset(kHeight_NavBar-kHeight_StatusBar);
        }];
        
        self.titleLab = [[UILabel alloc] init];
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLab];
        _titleLab.textColor = [ColorManager BlackColor];
        _titleLab.text = titleStr;
        _titleLab.font = kFont(17);
//        self.titleLab.sd_layout.widthIs(kWidth(200)).heightIs(kHeight_NavBar-kHeight_StatusBar).bottomSpaceToView(self, 0).centerXEqualToView(self);
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.centerX.equalTo(self);
                    make.width.mas_offset(kWidth(200));
                    make.height.mas_offset(kHeight_NavBar-kHeight_StatusBar);
        }];
    }
    return self;
}
- (void)backBtnClickAction {
    if (!self.isInitBackBtn) {
        [_controller.navigationController popViewControllerAnimated:YES];
        [_controller dismissViewControllerAnimated:YES completion:^{
                   
        }];
    }else {
        if (self.block) {
            self.block();
        }
    }
}
-(void)leftBtnHidden:(BOOL)ishidden {
    self.backBtn.hidden = ishidden;
}

//改变title
- (void)changeTitle:(NSString *)titleStr {
    self.titleLab.text = titleStr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
