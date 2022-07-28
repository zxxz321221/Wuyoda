//
//  SearchModel.h
//  Wuyoda
//
//  Created by 赵祥 on 2022/5/26.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchModel : BaseModel

@property (nonatomic , copy)NSString *uid;
@property (nonatomic , copy)NSString *addtime;
@property (nonatomic , copy)NSString *name;
@property (nonatomic , copy)NSString *search;

@end

NS_ASSUME_NONNULL_END
