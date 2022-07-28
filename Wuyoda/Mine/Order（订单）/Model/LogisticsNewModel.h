//
//  LogisticsNewModel.h
//  Wuyoda
//
//  Created by 赵祥 on 2022/7/13.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LogisticsNewModel : BaseModel

@property (nonatomic , copy)NSString *nu;
@property (nonatomic , copy)NSString *status;
@property (nonatomic , copy)NSString *ischeck;
@property (nonatomic , copy)NSString *condition;
@property (nonatomic , copy)NSString *message;
@property (nonatomic , copy)NSString *com;
//0在途，1揽收，2疑难，3签收，4退签，5派件，8清关，14拒签等10个基础物流状态
@property (nonatomic , copy)NSString *state;
@property (nonatomic , copy)NSString *file;
@property (nonatomic , copy)NSString *result;
@property (nonatomic , copy)NSString *returnCode;

@end

@interface LogisticsSubModel : BaseModel

@property (nonatomic , copy)NSString *status;
@property (nonatomic , copy)NSString *areaCode;
@property (nonatomic , copy)NSString *areaName;
@property (nonatomic , copy)NSString *context;
@property (nonatomic , copy)NSString *ftime;
@property (nonatomic , copy)NSString *time;

@end

NS_ASSUME_NONNULL_END
