//
//  VerCodeView.h
//  KeMaiApp
//
//  Created by 大连龙采 on 2020/8/30.
//  Copyright © 2020 王阳阳. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum:NSUInteger {
    passShow1 = 1,//黑点,框,没间隔
    passShow2,//显示数字,框,没间隔
    passShow3,//黑点,框,有间隔
    passShow4,//显示数字,框,有间隔
    passShow5,//显示数字,下划线,一般用做验证码
} passShowType;

NS_ASSUME_NONNULL_BEGIN
typedef void(^textBlock) (NSString *str);

@interface VerCodeView : UIView
@property(nonatomic,strong)UITextField *textF;
@property(nonatomic,strong)UIColor *tintColor;//主题色
@property(nonatomic,strong)UIColor *textColor;//字体颜色
@property(nonatomic, copy)textBlock textBlock;
@property(nonatomic,assign)passShowType showType;
@property(nonatomic,assign)NSInteger num;//格子数
-(void)show;
-(void)cleanPassword;
@end

NS_ASSUME_NONNULL_END
