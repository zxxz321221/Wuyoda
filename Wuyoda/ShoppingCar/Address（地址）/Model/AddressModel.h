//
//  AddressModel.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/11/10.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddressModel : BaseModel

@property (nonatomic , copy)NSString *address;
@property (nonatomic , copy)NSString *card;
@property (nonatomic , copy)NSString *city;
@property (nonatomic , copy)NSString *consignee;
@property (nonatomic , copy)NSString *county;
@property (nonatomic , copy)NSString *front_ID;
@property (nonatomic , copy)NSString *is_buy;
@property (nonatomic , copy)NSString *m_uid;
@property (nonatomic , copy)NSString *mobile;
@property (nonatomic , copy)NSString *name;
@property (nonatomic , copy)NSString *province;
@property (nonatomic , copy)NSString *reverse_ID;
@property (nonatomic , copy)NSString *uid;
@property (nonatomic , copy)NSString *zipcode;


@end

NS_ASSUME_NONNULL_END
