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
    [self.selectBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
    [self.selectBtn setImage:kGetImage(@"选择") forState:UIControlStateNormal];
    [self.selectBtn setImage:kGetImage(@"选中") forState:UIControlStateSelected];
    self.selectBtn.titleLabel.font = kFont(14);
    [self addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(15));
        make.centerY.equalTo(self);
        make.width.mas_offset(kWidth(50));
        make.height.mas_offset(kWidth(15));
    }];
    
    self.deleteBtn = [[UIButton alloc]init];
    [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    self.deleteBtn.titleLabel.font = kFont(14);
    self.deleteBtn.backgroundColor = [ColorManager ColorD8001B];
    self.deleteBtn.layer.cornerRadius = kWidth(18);
    [self addSubview:self.deleteBtn];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.mas_offset(kWidth(-10));
        make.width.mas_offset(kWidth(90));
        make.height.mas_offset(kWidth(36));
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
