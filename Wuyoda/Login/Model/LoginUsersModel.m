//
//  LoginUsersModel.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/12/15.
//

#import "LoginUsersModel.h"

#define kNSKeyedArchPath [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]      stringByAppendingPathComponent:@"LoginUsers.arch"]

@implementation LoginUsersModel

//存
+ (void)saveLoginUsers:(UserInfoModel *)user{
    
    NSMutableArray *users = [self getLoginUsers];
    if (!users) {
        users = [NSMutableArray array];
    }
    BOOL inArr = NO;
    for (int i = 0; i<users.count; i++) {
        UserInfoModel *model = [users objectAtIndex:i];
        if ([user.member_id isEqualToString:model.member_id]) {
            [users replaceObjectAtIndex:i withObject:user];
            inArr = YES;
            break;;
        }
    }
    
    if (!inArr) {
        [users addObject:user];
    }
    [NSKeyedArchiver archiveRootObject:users toFile:kNSKeyedArchPath];
}

//取
+ (NSMutableArray *)getLoginUsers{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:kNSKeyedArchPath]) {
    
        NSMutableArray *users = [NSKeyedUnarchiver unarchiveObjectWithFile:kNSKeyedArchPath];
        return users;
    }else {
        NSMutableArray *users = [NSMutableArray array];
        return users;
    }
}

//删
+ (void)deleteLoginUsers:(UserInfoModel *)user{
    
    NSMutableArray *users = [self getLoginUsers];
    for (int i = 0; i<users.count; i++) {
        UserInfoModel *model = [users objectAtIndex:i];
        if ([user.member_id isEqualToString:model.member_id]) {
            [users removeObjectAtIndex:i];
            break;;
        }
    }
    [NSKeyedArchiver archiveRootObject:users toFile:kNSKeyedArchPath];
}

@end
