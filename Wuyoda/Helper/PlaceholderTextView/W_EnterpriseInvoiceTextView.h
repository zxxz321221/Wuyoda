//
//  W_EnterpriseInvoiceTextView.h
//  DLFramework
//
//  Created by longcai on 2019/8/15.
//  Copyright © 2019 樊静. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface W_EnterpriseInvoiceTextView : UITextView
/// 占位符提示语（默认无）
@property (nonatomic, strong) NSString *placeHolderText;

/// 占位符提示语字体大小（默认与textview的系统字体大小一致）
@property (nonatomic, strong) UIFont *placeHolderFont;

/// 占位符提示语字体颜色（默认灰色）
@property (nonatomic, strong) UIColor *placeHolderColor;

/// 限制字数（默认无限制）
@property (nonatomic, assign) NSInteger limitNumber;

/// 回车时结束编辑
@property (nonatomic, assign) BOOL isEndReturn;

@property (nonatomic, strong) NSString *inputText;

/// 回调
- (void)textViewStart:(void (^)(UITextView *textview))start
    changeTextInRange:(void (^)(UITextView *textview, NSRange range, NSString *text))changeTextInRange
   changeNotification:(void (^)(UITextView *textview))changeNotification
                  end:(void (^)(UITextView *textview))end;

@end

NS_ASSUME_NONNULL_END
