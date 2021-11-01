//
//  NSLayoutConstraint+BSIBDesignable.h
//  Brush
//
//  Created by 王玉鑫 on 2019/11/6.
//  Copyright © 2019 闪电. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSLayoutConstraint (BSIBDesignable)
@property(nonatomic, assign) IBInspectable BOOL adapterScreen;

@end

NS_ASSUME_NONNULL_END
