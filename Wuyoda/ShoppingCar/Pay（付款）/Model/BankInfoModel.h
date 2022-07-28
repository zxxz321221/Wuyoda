//
//  BankInfoModel.h
//  Wuyoda
//
//  Created by 赵祥 on 2022/5/18.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BankInfoModel : BaseModel

@property (nonatomic , copy)NSString *uid;
@property (nonatomic , assign)BOOL is_buy;
@property (nonatomic , copy)NSString *remarks;
@property (nonatomic , copy)NSString *bank;
@property (nonatomic , copy)NSString *mobile;
@property (nonatomic , copy)NSString *m_uid;
@property (nonatomic , copy)NSString *name;
@property (nonatomic , copy)NSString *card;
@property (nonatomic , copy)NSString *bank_name;

@end

NS_ASSUME_NONNULL_END
