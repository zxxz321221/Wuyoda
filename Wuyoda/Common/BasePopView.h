//
//  BasePopView.h
//  JiaHeOil
//
//  Created by MAC02 on 2020/12/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^okBlock) (void);
typedef void(^canaleBlock) (void);

@interface BasePopView : UIView

@property(nonatomic, copy)okBlock block;
@property(nonatomic, copy)canaleBlock cancleBlock;
@property (nonatomic, strong) UIView *contentView;

- (instancetype)initWithFrame:(CGRect)frame titleStr:(NSString *)titleStr leftTitleStr:(NSString *)leftTitleStr rightTitleStr:(NSString *)rightTitleStr;
- (void)hasTitleLabel:(NSString *)titleStr;//有title
//显示
- (void)show;
//消失
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
