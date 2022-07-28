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
    [self.selectBtn setTitleColor:[ColorManager Color666666] forState:UIControlStateNormal];
    [self.selectBtn setImage:kGetImage(@"未选中") forState:UIControlStateNormal];
    [self.selectBtn setImage:kGetImage(@"选中") forState:UIControlStateSelected];
    self.selectBtn.titleLabel.font = kFont(14);
    [self addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(15));
        make.centerY.equalTo(self);
        make.width.mas_offset(kWidth(50));
        make.height.mas_offset(kWidth(15));
    }];
    
    self.selectBtn.titleEdgeInsets = UIEdgeInsetsMake(0, kWidth(5), 0, 0);
    self.selectBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, kWidth(35));
    
    self.priceLab = [[UILabel alloc]init];
    self.priceLab.text = @"￥0.00";
    self.priceLab.textColor = [ColorManager ColorFE3C3D];
    self.priceLab.font = kBoldFont(20);
    [self addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-109));
        make.centerY.equalTo(self);
    }];
    
    self.allTitleLab = [[UILabel alloc]init];
    self.allTitleLab.text = @"合计：";
    self.allTitleLab.textColor = [ColorManager BlackColor];
    self.allTitleLab.font = kFont(14);
    [self addSubview:self.allTitleLab];
    [self.allTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.priceLab.mas_left).mas_offset(kWidth(-8));
    }];
    
    self.cleaningBtn = [[UIButton alloc]init];
    [self.cleaningBtn setTitle:@"结算" forState:UIControlStateNormal];
    [self.cleaningBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    self.cleaningBtn.titleLabel.font = kFont(14);
    [self.cleaningBtn setBackgroundImage:kGetImage(@"提交订单") forState:UIControlStateNormal];
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
    [self.deleteBtn setBackgroundImage:kGetImage(@"推荐按钮") forState:UIControlStateNormal];
    self.deleteBtn.layer.cornerRadius = kWidth(18);
    self.deleteBtn.layer.masksToBounds = YES;
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
    [self.likeBtn setTitleColor:[ColorManager ColorFB9A3A] forState:UIControlStateNormal];
    self.likeBtn.titleLabel.font = kFont(14);
    self.likeBtn.layer.cornerRadius = kWidth(18);
    self.likeBtn.layer.borderColor = [ColorManager ColorFB9A3A].CGColor;
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
