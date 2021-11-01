//
//  ShoppingCarBottomView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/24.
//

#import "ShoppingCarBottomView.h"



@implementation ShoppingCarBottomView

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
    
    self.allTitleLab = [[UILabel alloc]init];
    self.allTitleLab.text = @"合计：";
    self.allTitleLab.textColor = [ColorManager BlackColor];
    self.allTitleLab.font = kFont(14);
    [self addSubview:self.allTitleLab];
    [self.allTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.mas_offset(kWidth(163));
    }];
    
    self.priceLab = [[UILabel alloc]init];
    self.priceLab.text = @"￥0";
    self.priceLab.textColor = [UIColor redColor];
    self.priceLab.font = kFont(14);
    [self addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-109));
        make.centerY.equalTo(self);
    }];
    
    self.cleaningBtn = [[UIButton alloc]init];
    [self.cleaningBtn setTitle:@"结算" forState:UIControlStateNormal];
    [self.cleaningBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    self.cleaningBtn.titleLabel.font = kFont(14);
    self.cleaningBtn.backgroundColor = [ColorManager MainColor];
    self.cleaningBtn.layer.cornerRadius = kWidth(18);
    [self addSubview:self.cleaningBtn];
    [self.cleaningBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.mas_offset(kWidth(-10));
        make.width.mas_offset(kWidth(90));
        make.height.mas_offset(kWidth(36));
    }];
    
    self.deleteBtn = [[UIButton alloc]init];
    [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    self.deleteBtn.titleLabel.font = kFont(14);
    self.deleteBtn.backgroundColor = [ColorManager ColorD8001B];
    self.deleteBtn.layer.cornerRadius = kWidth(18);
    self.deleteBtn.hidden = YES;
    [self addSubview:self.deleteBtn];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.mas_offset(kWidth(-10));
        make.width.mas_offset(kWidth(90));
        make.height.mas_offset(kWidth(36));
    }];
    
    self.likeBtn = [[UIButton alloc]init];
    [self.likeBtn setTitle:@"移入心愿单" forState:UIControlStateNormal];
    [self.likeBtn setTitleColor:[ColorManager MainColor] forState:UIControlStateNormal];
    self.likeBtn
        .titleLabel.font = kFont(14);
    self.likeBtn.layer.cornerRadius = kWidth(18);
    self.likeBtn.layer.borderColor = [ColorManager MainColor].CGColor;
    self.likeBtn.layer.borderWidth = kWidth(1);
    self.likeBtn.hidden = YES;
    [self addSubview:self.likeBtn];
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.mas_offset(kWidth(-109));
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
