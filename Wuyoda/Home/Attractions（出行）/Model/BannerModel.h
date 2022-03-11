//
//  BannerModel.h
//  Wuyoda
//
//  Created by 赵祥 on 2022/1/7.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BannerModel : BaseModel

@property (nonatomic , copy)NSString *goods_id;
@property (nonatomic , copy)NSString *imgbig;
@property (nonatomic , copy)NSString *imgid;
@property (nonatomic , copy)NSString *supplier_id;
@property (nonatomic , copy)NSString *thumb;

@end

NS_ASSUME_NONNULL_END
