//
//  BasePopView.m
//  JiaHeOil
//
//  Created by MAC02 on 2020/12/18.
//

#import "BasePopView.h"

#define PopViewWitdh  kWidth(260)
#define popViewHeight kWidth(139)

@interface BasePopView ()

@property (nonatomic, strong) UILabel *contentLab;

@end

@implementation BasePopView

- (instancetype)initWithFrame:(CGRect)frame titleStr:(NSString *)titleStr leftTitleStr:(NSString *)leftTitleStr rightTitleStr:(NSString *)rightTitleStr {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        //self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        self.backgroundColor = kColorAlpha(0, 0, 0, 0.4);
        self.alpha = 1;
        
        self.contentView = [[UIView alloc] init];
        self.contentView.backgroundColor = [ColorManager WhiteColor];
        self.contentView.layer.shadowColor = [UIColor colorWithRed:14/255.0 green:23/255.0 blue:3/255.0 alpha:0.5].CGColor;
        self.contentView.layer.shadowOffset = CGSizeMake(0,0);
        self.contentView.layer.shadowOpacity = 1;
        self.contentView.layer.shadowRadius = 5;
        self.contentView.layer.cornerRadius = 1;
        self.contentView.clipsToBounds = YES;
        [self addSubview:self.contentView];
        self.contentView.sd_layout.centerXEqualToView(self).centerYEqualToView(self).widthIs(PopViewWitdh).heightIs(popViewHeight);

        _contentLab = [[UILabel alloc] init];
        _contentLab.textColor = [ColorManager ColorBlackText33];
        _contentLab.text = titleStr;
        _contentLab.font = kFont(14);
        _contentLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_contentLab];
        _contentLab.sd_layout.centerXEqualToView(self.contentView).topSpaceToView(self.contentView, kWidth(42)).heightIs(kWidth(15)).widthIs(PopViewWitdh - kWidth(40));
        
        //线
        UIView *lineVlew = [[UIView alloc] init];
        lineVlew.backgroundColor = [ColorManager ColorGrayEEEEEE];
        [self.contentView addSubview:lineVlew];
        lineVlew.sd_layout.leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, kWidth(44)).heightIs(1);
        
        //取消
        UIButton *cancleBtn = [UIButton kk_buttonWithTitle:leftTitleStr titleColor:[ColorManager ColorBlackTextbbbbbb] titleFont:kFont(15) backGroundColor:[ColorManager WhiteColor]];
        [cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:cancleBtn];
        cancleBtn.sd_layout.leftSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).heightIs(kWidth(44)).rightSpaceToView(self.contentView, PopViewWitdh/2);
        
        //确认
        UIButton *okBtn = [UIButton kk_buttonWithTitle:rightTitleStr titleColor:[ColorManager ColorBlackText33] titleFont:kFont(15) backGroundColor:[ColorManager WhiteColor]];
        [okBtn addTarget:self action:@selector(okBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:okBtn];
        okBtn.sd_layout.leftSpaceToView(cancleBtn, 0).bottomSpaceToView(self.contentView, 0).heightIs(kWidth(44)).rightSpaceToView(self.contentView, 0);
    }
    return self;
}

- (void)hasTitleLabel:(NSString *)titleStr {
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.textColor = [UIColor blackColor];
    titleLab.text = titleStr;
    titleLab.font = kFont(15);
    titleLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleLab];
    titleLab.sd_layout.centerXEqualToView(self.contentView).topSpaceToView(self.contentView, kWidth(18)).heightIs(kWidth(18)).widthIs(PopViewWitdh - kWidth(40));
    
    _contentLab.sd_layout.topSpaceToView(titleLab, kWidth(18));
    [_contentLab updateLayout];
}

- (void)cancleBtnClick {
    
    [self dismiss];
    if (self.cancleBlock) {
        self.cancleBlock();
    }
}

- (void)okBtnClick:(UIButton *)btn {
    
    [self dismiss];
    if (self.block) {
        self.block();
    }
}

//显示
- (void)show {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[CommonManager getCurrentViewController].view addSubview:self];
    });
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

//消失
- (void)dismiss {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
