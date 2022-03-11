//
//  HomeSearchField.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/12/20.
//

#import "HomeSearchField.h"

@implementation HomeSearchField

-(CGRect) leftViewRectForBounds:(CGRect)bounds {
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += kWidth(10);// 右偏10
    return iconRect;
}

-(CGRect)textRectForBounds:(CGRect)bounds{
    CGRect rect = [super textRectForBounds:bounds];
    rect.origin.x += kWidth(10);// 右偏10
    return rect;
}

-(CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect rect = [super editingRectForBounds:bounds];
    rect.origin.x += kWidth(10);// 右偏10
    return rect;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
