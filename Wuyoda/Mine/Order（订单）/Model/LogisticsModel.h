//
//  LogisticsModel.h
//  Wuyoda
//
//  Created by 赵祥 on 2022/2/22.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LogisticsModel : BaseModel

@property (nonatomic , copy)NSString *expressCode;
@property (nonatomic , copy)NSString *expressType;
@property (nonatomic , copy)NSString *orderNum;
@property (nonatomic , copy)NSString *productNum;
@property (nonatomic , copy)NSString *productWeight;
@property (nonatomic , copy)NSString *receiverCity;
@property (nonatomic , copy)NSString *senderArea;
@property (nonatomic , copy)NSString *status;
@property (nonatomic , copy)NSString *success;
@property (nonatomic , copy)NSString *action;
@property (nonatomic , copy)NSString *updateTime;
@property (nonatomic , copy)NSString *file;
@property (nonatomic , copy)NSString *message;

@end

NS_ASSUME_NONNULL_END
