//
//  PayInfoModel.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/11/11.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PayInfoModel : BaseModel

@property (nonatomic , copy)NSString *address;
@property (nonatomic , copy)NSString *addtime;
@property (nonatomic , copy)NSString *admin_memo;
@property (nonatomic , copy)NSString *card_source;
@property (nonatomic , copy)NSString *checktime;
@property (nonatomic , copy)NSString *code;
@property (nonatomic , copy)NSString *consignee;
@property (nonatomic , copy)NSString *delivery_code;
@property (nonatomic , copy)NSString *discount;
@property (nonatomic , copy)NSString *discount_name;
@property (nonatomic , copy)NSString *exp_code;
@property (nonatomic , copy)NSString *from_user;
@property (nonatomic , copy)NSString *goods_amount;
@property (nonatomic , copy)NSString *goods_point;
@property (nonatomic , copy)NSString *goods_rest_amount;
@property (nonatomic , copy)NSString *identify;
@property (nonatomic , copy)NSString *invoice;
@property (nonatomic , copy)NSString *istaobao;
@property (nonatomic , copy)NSString *mark;
@property (nonatomic , copy)NSString *mobile;
@property (nonatomic , copy)NSString *money_type;
@property (nonatomic , copy)NSString *order_amount;
@property (nonatomic , copy)NSString *ordersn;
@property (nonatomic , copy)NSString *original_price;
@property (nonatomic , copy)NSString *pay_id;
@property (nonatomic , copy)NSString *pay_name;
@property (nonatomic , copy)NSString *remark;
@property (nonatomic , copy)NSString *return_number;
@property (nonatomic , copy)NSString *salt;
@property (nonatomic , copy)NSString *sh_price;
@property (nonatomic , copy)NSString *sh_uid;
@property (nonatomic , copy)NSString *status;
@property (nonatomic , copy)NSString *supplier_id;
@property (nonatomic , copy)NSString *taobaoinfo;
@property (nonatomic , copy)NSString *uid;
@property (nonatomic , copy)NSString *username;
@property (nonatomic , copy)NSString *zipcode;



@end

NS_ASSUME_NONNULL_END
