//
//  HomeModel.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/11/4.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeModel : BaseModel

@end

@interface HomeCityModel : BaseModel

@property (nonatomic , copy)NSString *city;
@property (nonatomic , copy)NSString *county;
@property (nonatomic , copy)NSString *cover;
@property (nonatomic , copy)NSString *province;
@property (nonatomic , copy)NSString *uid;

@end

@interface HomeShopModel : BaseModel

@property (nonatomic , copy)NSString *attr_store;
@property (nonatomic , copy)NSString *attr_val;
@property (nonatomic , copy)NSString *bag_number;
@property (nonatomic , copy)NSString *bdlh;
@property (nonatomic , copy)NSString *belong_area;
@property (nonatomic , copy)NSString *belong_city;
@property (nonatomic , copy)NSString *belong_county;
@property (nonatomic , copy)NSString *belong_shop;
@property (nonatomic , copy)NSString *ddp;
@property (nonatomic , copy)NSString *down_payment;
@property (nonatomic , copy)NSString *down_payment_org;
@property (nonatomic , copy)NSString *filter_attr;
@property (nonatomic , copy)NSString *g_uid;
@property (nonatomic , copy)NSString *goods_advance;
@property (nonatomic , copy)NSString *goods_brand;
@property (nonatomic , copy)NSString *goods_category;
@property (nonatomic , copy)NSString *goods_code;
@property (nonatomic , copy)NSString *goods_cost;
@property (nonatomic , copy)NSString *goods_cost_org;
@property (nonatomic , copy)NSString *goods_file1;
@property (nonatomic , copy)NSString *goods_hit;
@property (nonatomic , copy)NSString *goods_key;
@property (nonatomic , copy)NSString *goods_kg;
@property (nonatomic , copy)NSString *goods_main;
@property (nonatomic , copy)NSString *goods_name;
@property (nonatomic , copy)NSString *goods_sale_price;
@property (nonatomic , copy)NSString *goods_sale_price_org;
@property (nonatomic , copy)NSString *goods_market_price;
@property (nonatomic , copy)NSString *goods_market_price_org;
@property (nonatomic , copy)NSString *goods_status;
@property (nonatomic , copy)NSString *goods_stock;
@property (nonatomic , copy)NSString *is_makeup;
@property (nonatomic , copy)NSString *isup;
@property (nonatomic , copy)NSString *money_type;
@property (nonatomic , copy)NSString *register_date;
@property (nonatomic , copy)NSString *star_struct;
@property (nonatomic , copy)NSString *subpackage;
@property (nonatomic , copy)NSString *supplier_cat;
@property (nonatomic , copy)NSString *supplier_cat2;
@property (nonatomic , copy)NSString *supplier_cat3;
@property (nonatomic , copy)NSString *supplier_id;
@property (nonatomic , copy)NSString *taxes_types;
@property (nonatomic , copy)NSString *twmp;
@property (nonatomic , copy)NSString *type;
@property (nonatomic , copy)NSString *uid;
@property (nonatomic , copy)NSString *update_date;
@property (nonatomic , copy)NSString *wholesale_price;

@end

NS_ASSUME_NONNULL_END
