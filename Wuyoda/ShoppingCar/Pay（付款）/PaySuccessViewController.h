//
//  PaySuccessViewController.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/28.
//

#import "FJBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PaySuccessViewController : FJBaseViewController

//1.付款成功，2.收货成功，3.评价成功
@property (nonatomic , copy)NSString *type;

@property (nonatomic , copy)NSString *ordersn;

@end

NS_ASSUME_NONNULL_END
