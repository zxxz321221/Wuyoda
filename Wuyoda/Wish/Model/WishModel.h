//
//  WishModel.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/11/22.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WishModel : BaseModel

@property (nonatomic , copy)NSString *belong_area;
@property (nonatomic , copy)NSString *belong_city;
@property (nonatomic , copy)NSString *belong_county;
@property (nonatomic , copy)NSString *f_uid;
@property (nonatomic , copy)NSString *goods_file1;
@property (nonatomic , copy)NSString *goods_name;
@property (nonatomic , copy)NSString *goods_sale_price;
@property (nonatomic , copy)NSString *goods_table;
@property (nonatomic , copy)NSString *m_uid;
@property (nonatomic , copy)NSString *module;
@property (nonatomic , copy)NSString *supplier_id;
@property (nonatomic , copy)NSString *t;
@property (nonatomic , copy)NSString *isSelect;

@end

NS_ASSUME_NONNULL_END
