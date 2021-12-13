//
//  BankModel.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/11/11.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BankModel : BaseModel

@property (nonatomic , copy)NSString *code;
@property (nonatomic , copy)NSString *logo_url;
@property (nonatomic , copy)NSString *name;
@property (nonatomic , copy)NSString *name_zh;

@end

NS_ASSUME_NONNULL_END
