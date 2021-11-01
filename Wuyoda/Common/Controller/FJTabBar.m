//
//  FJTabBar.m
//  NewHotel
//
//  Created by 樊静 on 2018/8/30.
//  Copyright © 2018年 樊静. All rights reserved.
//

#import "FJTabBar.h"

@interface FJTabBar ()

@property (nonatomic,strong) UIView * midlV;

@end
@implementation FJTabBar
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        self.backgroundColor = [UIColor whiteColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTabbar:) name:@"changeTabbarImage" object:nil];
        [self addMiddleb];

    }
    return self;
}

- (void)addMiddleb;
{
    UIImageView *middleBtn = [[UIImageView alloc] init];
    middleBtn.userInteractionEnabled = YES;
    middleBtn.image = [UIImage imageNamed:@"middleAdd"];
    middleBtn.layer.cornerRadius = 17.5;
    middleBtn.layer.masksToBounds = YES;
//    [middleBtn setBackgroundImage:[UIImage imageNamed:@"middleAdd"] forState:UIControlStateNormal];
//    [middleBtn setBackgroundImage:[UIImage imageNamed:@"middleAdd"] forState:UIControlStateHighlighted];

//    [middleBtn setImage:[UIImage imageNamed:@"middleAdd"] forState:UIControlStateNormal];
//    [middleBtn setImage:[UIImage imageNamed:@"middleAdd"] forState:UIControlStateHighlighted];
    self.middlebBtn = middleBtn;


//    [self.middlebBtn addTarget:self action:@selector(middleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    //    [self addSubview:middleBtn];

    self.midlV = [[UIView alloc] init];
    [self addSubview:self.midlV];
    [self.midlV addSubview:middleBtn];

    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(midlVTap:)];
    [self.midlV addGestureRecognizer:tap];

}
- (void)midlVTap:(UITapGestureRecognizer *)tap {
    !self.midBlock?:self.midBlock();

}

- (void)layoutSubviews
{
    [super layoutSubviews];


    NSArray *tabbarButtons = [self getTabBarButtons];
    CGFloat btnW = self.width / (tabbarButtons.count + 1);

    self.middlebBtn.frame = CGRectMake(btnW*2, 0, 35, 35);

   // self.plusBtn.size = CGSizeMake(self.plusBtn.currentBackgroundImage.size.width, self.plusBtn.currentBackgroundImage.size.height);
  //  NSLog(@"%f======",self.height);
    self.middlebBtn.centerX = self.centerX;
    //调整发布按钮的中线点Y值
    self.middlebBtn.centerY = 49 * 0.5 + 5 ;


    //重新计算各个UITabBarButton的布局

    CGFloat btnH = self.height== 83?49:self.height;
    CGFloat tabbarBtnIndex = 0;

    for (UIView *view in tabbarButtons) {


        view.frame = CGRectMake(tabbarBtnIndex * btnW, 0, btnW, btnH);

        tabbarBtnIndex ++;

        if (tabbarBtnIndex == 2) {

            tabbarBtnIndex ++;
        }
    }

 //   [self changeTitleColor];

}

- (NSArray *) getTabBarButtons
{
    NSMutableArray *tabbarbuttons = [NSMutableArray array];

    for (UIView *subView in self.subviews) {

        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            //            UIButton * s = (UIButton *)subView;

            //            s.imageEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 0);

            [tabbarbuttons addObject:subView];
        }

        if ([subView isKindOfClass:[UIImageView class]]) {
            UIImageView * iamgev = (UIImageView *)subView;
            iamgev.image = [UIImage new];
            [subView removeFromSuperview];
        }

    }
    return tabbarbuttons;
}

- (void) changeTitleColor
{
    for (id subView in self.subviews) {

        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [self enumrateSubviewsInSuperView:subView];

        }

    }
}

- (void)enumrateSubviewsInSuperView:(UIView *)view
{
    for (id subView in view.subviews) {

        if ([subView isKindOfClass:NSClassFromString(@"UILabel")]) {
            UILabel *label = subView;

            if ([self.selectedItem.title isEqualToString:label.text]) {

                label.textColor = self.selectedColor;
                if (self.selectedFont) {
                    label.font = self.selectedFont;
                }
            } else
            {
                label.textColor = self.normalColor;
                if (self.normalFont) {
                    label.font = self.normalFont;
                }
            }

        }

    }
}

//- (void)setSelectedItem:(UITabBarItem *)selectedItem
//{
//    [super setSelectedItem:selectedItem];
//    [self changeTitleColor];
//
//}




- (void)middleBtnClicked:(UIButton *)btn {
    !self.midBlock?:self.midBlock();

}

//重写hitTest方法，去监听发布按钮的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

    //这一个判断是关键，不判断的话push到其他页面，点击发布按钮的位置也是会有反应的，这样就不好了
    //self.isHidden == NO 说明当前页面是有tabbar的，那么肯定是在导航控制器的根控制器页面
    //在导航控制器根控制器页面，那么我们就需要判断手指点击的位置是否在发布按钮身上
    //是的话让发布按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
    if (self.isHidden == NO) {

        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
        CGPoint newP = [self convertPoint:point toView:self.middlebBtn];

        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ( [self.middlebBtn pointInside:newP withEvent:event]) {
            return self.middlebBtn;
        }else{//如果点不在发布按钮身上，直接让系统处理就可以了
            return [super hitTest:point withEvent:event];
        }
    }
    else {//tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
}



@end
