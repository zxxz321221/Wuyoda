//
//  ShopCartModel.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/11/9.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShopCartModel : BaseModel

@property (nonatomic , copy)NSString *abroad;
@property (nonatomic , copy)NSString *attr;
@property (nonatomic , copy)NSString *cart_num;
@property (nonatomic , copy)NSString *cart_point;
@property (nonatomic , copy)NSString *cart_price;
@property (nonatomic , copy)NSString *cart_price_show;
@property (nonatomic , copy)NSString *g_type;
@property (nonatomic , copy)NSString *g_uid;
@property (nonatomic , copy)NSString *goods_file1;
@property (nonatomic , copy)NSString *goods_name;
@property (nonatomic , copy)NSString *goods_table;
@property (nonatomic , copy)NSString *goods_stock;
@property (nonatomic , copy)NSString *isup;
@property (nonatomic , copy)NSString *module;
@property (nonatomic , copy)NSString *money_type;
@property (nonatomic , copy)NSString *ori_price;
@property (nonatomic , copy)NSString *ori_rest_price;
@property (nonatomic , copy)NSString *refer_g_uid;
@property (nonatomic , copy)NSString *rest_price;
@property (nonatomic , copy)NSString *rest_price_show;
@property (nonatomic , copy)NSString *supplier_id;
@property (nonatomic , copy)NSString *taxes;
@property (nonatomic , copy)NSString *taxes_show;
@property (nonatomic , copy)NSString *total_price;
@property (nonatomic , copy)NSString *total_price_m;
@property (nonatomic , copy)NSString *total_price_show;
@property (nonatomic , copy)NSString *uid;
@property (nonatomic , copy)NSString *url;
@property (nonatomic , copy)NSString *isSelect;
@property (nonatomic , copy)NSString *isEdit;

@end

NS_ASSUME_NONNULL_END
