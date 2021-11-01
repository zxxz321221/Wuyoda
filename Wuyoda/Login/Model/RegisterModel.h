//
//  RegisterModel.h
//  JiaHeOil
//
//  Created by longcai on 2020/11/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegisterModel : NSObject <NSCoding>

@property (nonatomic, copy)NSString             *user_id;
@property (nonatomic, copy)NSString             *user_token;


+ (void)saveUserInfoModel:(RegisterModel *)model;
+ (RegisterModel *)getUserInfoModel;
+ (void)clearUserInfo;

@end

NS_ASSUME_NONNULL_END
