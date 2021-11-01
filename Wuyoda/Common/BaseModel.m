//
//  BaseModel.m
//  SunflowerFramework
//
//  Created by 樊静 on 2020/6/4.
//  Copyright © 2020 Sunflower. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id"//前边的是你想用的key，后边的是返回的key
             };
}
@end
