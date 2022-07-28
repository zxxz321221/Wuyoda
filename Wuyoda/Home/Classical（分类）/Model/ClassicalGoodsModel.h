//
//  ClassicalGoodsModel.h
//  Wuyoda
//
//  Created by 赵祥 on 2022/5/25.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ClassicalGoodsModel : BaseModel

@property (nonatomic , copy)NSString *category_name;
@property (nonatomic , copy)NSString *uid;
@property (nonatomic , copy)NSArray *category_list;
@property (nonatomic , copy)NSString *category_file1;


@end

NS_ASSUME_NONNULL_END
