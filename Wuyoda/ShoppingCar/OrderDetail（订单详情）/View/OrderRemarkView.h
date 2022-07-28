//
//  OrderRemarkView.h
//  Wuyoda
//
//  Created by 赵祥 on 2022/6/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol OrderRemarkDelegate <NSObject>

-(void)insertOrderRemark:(NSString *)remark;

@end

@interface OrderRemarkView : UIView

@property (nonatomic , weak)id <OrderRemarkDelegate>delegate;

-(void)show;
-(void)close;

@end

NS_ASSUME_NONNULL_END
