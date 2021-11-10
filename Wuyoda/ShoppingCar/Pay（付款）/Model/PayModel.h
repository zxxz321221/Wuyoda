//
//  PayModel.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/11/10.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PayModel : BaseModel

@property (nonatomic , copy)NSString *ordersn;
@property (nonatomic , copy)NSString *total_price;

@end

NS_ASSUME_NONNULL_END
