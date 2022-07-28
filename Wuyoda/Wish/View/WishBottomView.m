//
//  WishBottomView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/11/23.
//

#import "WishBottomView.h"

@implementation WishBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.selectBtn = [[UIButton alloc]init];
    [self.selectBtn setTitle:@"全选" forState:UIControlStateNormal];
    [self.selectBtn setTitleColor:[ColorManager Color666666] forState:UIControlStateNormal];
    [self.selectBtn setImage:kGetImage(@"未选中") forState:UIControlStateNormal];
    [self.selectBtn setImage:kGetImage(@"选中") forState:UIControlStateSelected];
    self.selectBtn.titleLabel.font = kFont(16);
    [self addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(15));
        make.centerY.equalTo(self);
        make.width.mas_offset(kWidth(60));
        make.height.mas_offset(kWidth(18));
    }];
    self.selectBtn.titleEdgeInsets = UIEdgeInsetsMake(0, kWidth(5), 0, 0);
    self.selectBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, kWidth(35));
    
    self.deleteBtn = [[UIButton alloc]init];
    [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:[ColorManager MainColor] forState:UIControlStateNormal];
    self.deleteBtn.titleLabel.font = kFont(14);
    self.deleteBtn.layer.cornerRadius = kWidth(20);
    self.deleteBtn.layer.borderColor = [ColorManager MainColor].CGColor;
    self.deleteBtn.layer.borderWidth = kWidth(0.5);
    [self addSubview:self.deleteBtn];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.mas_offset(kWidth(-20));
        make.width.mas_offset(kWidth(90));
        make.height.mas_offset(kWidth(40));
    }];
    
    UIView *topLine = [[UIView alloc]init];
    topLine.backgroundColor = [ColorManager ColorCCCCCC];
    [self addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.equalTo(self);
        make.height.mas_offset(kWidth(0.5));
    }];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = [ColorManager ColorCCCCCC];
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.width.equalTo(self);
        make.height.mas_offset(kWidth(0.5));
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
