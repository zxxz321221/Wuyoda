//
//  OrderInfoViewController.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/27.
//

#import "FJBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderInfoViewController : FJBaseViewController

//1.待付款 2.已取消 3.已付款 4.已发货 5.已完成 6.已退货
//1.待支付，2.待收货，3.已完成 4.默认
@property (nonatomic , copy)NSString *type;

@property (nonatomic , copy)NSString *ordersn;

@end

NS_ASSUME_NONNULL_END
