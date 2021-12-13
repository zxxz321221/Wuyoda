//
//  FootHeaderView.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/9/16.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "FootHeaderView.h"
#import "FootHearModel.h"
@implementation FootHeaderView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [ColorManager ColorF2F2F2];
        
        self.readBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, kWidth(12), kWidth(16), kWidth(16))];
        [self.readBtn addTarget:self action:@selector(readClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.readBtn setImage:[UIImage imageNamed:@"选择"] forState:UIControlStateNormal];
        [self.readBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
        self.readBtn.hidden=YES;
        [self addSubview:self.readBtn];
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(kWidth(5), kWidth(10), kWidth(100), kWidth(20))];
        self.label.font = [UIFont systemFontOfSize:15.0];
        self.label.textAlignment = NSTextAlignmentLeft;
        self.label.textColor = [ColorManager Color666666];
        //        self.label.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
        [self addSubview:self.label];
        
    }
    return self;
}
- (void)setModel:(FootHearModel *)model{
    _model = model;
    self.readBtn.selected = model.isSelect;
    self.label.text = model.days;
}
- (void)configWithIsEdit:(BOOL)isEdit Section:(NSInteger)section{
    self.readBtn.tag = section+1000;
    if (isEdit) {
        self.readBtn.hidden=NO;
        self.label.frame = CGRectMake(5+kWidth(16)+kWidth(5), kWidth(10), kWidth(100), kWidth(20));
        return;
    }
    self.readBtn.hidden = YES;
    self.label.frame = CGRectMake(kWidth(5), kWidth(10), kWidth(100), kWidth(20));
}
- (void)readClick:(UIButton *)bt
{
    if([self.delegate respondsToSelector:@selector(shoppingCarHeaderViewDelegat:WithHeadView:)])
    {
        [self.delegate shoppingCarHeaderViewDelegat:bt WithHeadView:self.model];
    }
}
@end
