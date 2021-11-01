//
//  UserInfoModel.m
//  HuoZhiShop
//
//  Created by MAC02 on 2021/1/22.
//

#import "UserInfoModel.h"
#define kNSKeyedArchPath [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]      stringByAppendingPathComponent:@"UserDetailInfo.arch"]


@implementation UserInfoModel

MJCodingImplementation
#pragma mark - 个人信息存储
//存
+ (void)saveUserInfoModel:(UserInfoModel *)model{
    [NSKeyedArchiver archiveRootObject:model toFile:kNSKeyedArchPath];
}

//取
+ (UserInfoModel *)getUserInfoModel{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:kNSKeyedArchPath]) {
    
        UserInfoModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:kNSKeyedArchPath];
        return model;
    }else {
        UserInfoModel *model = nil;
        return model;
    }
}

//删
+ (void)clearUserInfo {
    NSFileManager * fileManager = [NSFileManager defaultManager];
    BOOL fileExists = [fileManager fileExistsAtPath:kNSKeyedArchPath];
    if (fileExists) {
        NSError *err;
        [fileManager removeItemAtPath:kNSKeyedArchPath error:&err];
    }
}

@end
