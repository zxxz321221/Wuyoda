//
//  BankCardListView.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/11/12.
//

#import <UIKit/UIKit.h>
#import "BankModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol selectPayBankDelegate <NSObject>

-(void)selectPayBank:(BankModel *)model;

@end

@interface BankCardListView : UIView

@property (nonatomic , retain)NSArray *bankArr;

@property (nonatomic , weak)id <selectPayBankDelegate>delegate;

- (void)show;
- (void)close;

@end

NS_ASSUME_NONNULL_END
