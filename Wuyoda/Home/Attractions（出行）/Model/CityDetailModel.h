//
//  CityDetailModel.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/11/22.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CityDetailModel : BaseModel

@property (nonatomic , copy)NSString *author;
@property (nonatomic , copy)NSString *city;
@property (nonatomic , copy)NSString *city_content;
@property (nonatomic , copy)NSString *county;
@property (nonatomic , copy)NSString *cover;
@property (nonatomic , retain)NSArray *custom;
@property (nonatomic , retain)NSArray *event;
@property (nonatomic , retain)NSArray *goods_table;
@property (nonatomic , copy)NSString *od;
@property (nonatomic , copy)NSString *province;
@property (nonatomic , copy)NSString *register_date;
@property (nonatomic , retain)NSArray *scenic;
@property (nonatomic , retain)NSArray *trip;
@property (nonatomic , copy)NSString *uid;

@end

@interface CityCustomModel : BaseModel

@end

@interface CityEventModel : BaseModel

@end

NS_ASSUME_NONNULL_END
