//
//  RegisterModel.m
//  JiaHeOil
//
//  Created by longcai on 2020/11/26.
//

#import "RegisterModel.h"
#define kNSKeyedArchPath [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]      stringByAppendingPathComponent:@"UserInfo.arch"]

@implementation RegisterModel

MJCodingImplementation
#pragma mark - 个人信息存储
//存
+ (void)saveUserInfoModel:(RegisterModel *)model{
    [NSKeyedArchiver archiveRootObject:model toFile:kNSKeyedArchPath];
}

//取
+ (RegisterModel *)getUserInfoModel{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:kNSKeyedArchPath]) {
       // DLog(@"%@",kNSKeyedArchPath);
        RegisterModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:kNSKeyedArchPath];
        return model;
    }else {
        RegisterModel *model = nil;
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
