//
//  OrderExpressView.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/12/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol OrderExpressSelectDelegate <NSObject>

-(void)selectOrderExpress:(NSDictionary *)shipDic;

@end

@interface OrderExpressView : UIView

@property (nonatomic , retain)NSArray *shipList;

@property (nonatomic , weak)id <OrderExpressSelectDelegate>delegate;

-(void)show;
-(void)close;

@end

NS_ASSUME_NONNULL_END
