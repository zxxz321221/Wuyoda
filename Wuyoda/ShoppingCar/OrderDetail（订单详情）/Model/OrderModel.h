//
//  OrderModel.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/11/10.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderModel : BaseModel

@property (nonatomic , copy)NSString *abroad;
@property (nonatomic , copy)NSString *is_preorder;
@property (nonatomic , copy)NSString *money_sign;
@property (nonatomic , copy)NSString *money_type;
@property (nonatomic , copy)NSString *total_kg;
@property (nonatomic , copy)NSString *total_point;
@property (nonatomic , copy)NSString *total_price;
@property (nonatomic , copy)NSString *total_price_show;
@property (nonatomic , retain)NSDictionary *yunfei;

@end

NS_ASSUME_NONNULL_END
