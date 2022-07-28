//
//  LoginUsersModel.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/12/15.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginUsersModel : BaseModel

+ (void)saveLoginUsers:(UserInfoModel *)user;

+ (NSMutableArray *)getLoginUsers;

+ (void)deleteLoginUsers:(UserInfoModel *)user;


+(void)savePasswordSetting:(UserInfoModel *)user;
+ (NSMutableArray *)getPasswordSettingUsers;
+(BOOL)userSetting:(UserInfoModel *)user;

@end

NS_ASSUME_NONNULL_END
