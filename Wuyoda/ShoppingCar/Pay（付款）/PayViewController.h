//
//  PayViewController.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/28.
//

#import "FJBaseViewController.h"
#import "PayModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PayViewController : FJBaseViewController

@property (nonatomic , retain)NSDictionary *cartListDic;

@property (nonatomic , copy)NSString *memo;

@property (nonatomic , copy)NSString *fare;

@property (nonatomic , copy)NSString *addressid;

@property (nonatomic , retain)PayModel *payModel;

@end

NS_ASSUME_NONNULL_END
