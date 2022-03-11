//
//  OrderViewController.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/11.
//

#import "FJBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderViewController : FJBaseViewController

//1.全部订单；2.代付款；3.待收货；4.已完成
@property (nonatomic , copy)NSString *type;

@end

NS_ASSUME_NONNULL_END
