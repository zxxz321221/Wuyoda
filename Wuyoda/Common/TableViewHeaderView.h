//
//  TableViewHeaderView.h
//  HuoZhiShop
//
//  Created by MAC02 on 2020/12/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewHeaderView : UIView

- (instancetype)initWithFrame:(CGRect)frame titleImg:(UIImage *)titleImg subTitleStr:(NSString *)subTitleStr subTitleColor:(UIColor *)subTitltColor subTitleFontSize:(CGFloat)subTitleFont;

@end

NS_ASSUME_NONNULL_END
