//
//  FJNormalNavView.h
//  TaiYouHui
//
//  Created by 樊静 on 2020/7/2.
//  Copyright © 2020 Sunflower. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^backBlock) (void);

@interface FJNormalNavView : UIView
// 带有返回和标题的导航View
// @param frame 带有返回和标题的导航View
// @param controller 添加的ViewController
// @param titleStr 标题
- (instancetype)initWithFrame:(CGRect)frame controller:(nonnull UIViewController *)controller titleStr:(NSString *)titleStr;

-(void)leftBtnHidden:(BOOL)ishidden;
//改变title
- (void)changeTitle:(NSString *)titleStr;
@property (nonatomic, assign) BOOL isInitBackBtn;
@property(nonatomic, copy)backBlock block;
@end

NS_ASSUME_NONNULL_END
