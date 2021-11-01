//
//  FJSysAuthorizationManager.h
//  DuiDianIMProject
//
//  Created by 樊静 on 2020/2/19.
//  Copyright © 2020 longcai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    KAVMediaVideo = 0, //相机
    KALAssetsLibary,        //相册
    KCLLocation,            //地理定位
    KAVMediaAudio,        //音频
    KABAddressBook,         //通讯录
} SysAuthorizationType;

@interface FJSysAuthorizationManager : NSObject

+(instancetype)sharenInsatnce;

/*
 * 设置权限
 * type:类型
 * completion:Blook,error:禁止权限则有值
 */
-(void)requestAuthorization:(SysAuthorizationType)type completion:(void(^)(NSError *error))completion;




@end

NS_ASSUME_NONNULL_END
