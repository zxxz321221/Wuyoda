//
//  OrderDetailViewController.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/26.
//

#import "FJBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailViewController : FJBaseViewController

@property (nonatomic , retain)NSMutableArray *cartArr;

@property (nonatomic , retain)NSDictionary *buyAgainDic;

@end

NS_ASSUME_NONNULL_END
