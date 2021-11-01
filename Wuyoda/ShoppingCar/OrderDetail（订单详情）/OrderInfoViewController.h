//
//  OrderInfoViewController.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/27.
//

#import "FJBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderInfoViewController : FJBaseViewController

//1.待支付，2.待收货，3.已完成 4.默认
@property (nonatomic , copy)NSString *type;

@end

NS_ASSUME_NONNULL_END
