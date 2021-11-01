//
//  FJNetTool.h
//  FJFramework
//
//  Created by 樊静 on 2017/6/30.
//  Copyright © 2017年 樊静. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPNetworkHelper.h"

typedef void (^successHandle)(id responseObject);
typedef void (^progressHandle)(NSProgress *progress);
typedef void (^failureHandle)(NSError * error);


@interface FJNetTool : NSObject

// get 无缓存
+ (void)getWithParams:(id)params url:(NSString *)url loading:(BOOL)needloading success:(successHandle)success failure:(failureHandle)failure;

// post 无缓存
+ (void)postWithParams:(id)params url:(NSString *)url loading:(BOOL)needloading success:(successHandle)success failure:(failureHandle)failure;

// 带缓存的没有封装， 我懒


/**
*  上传图片文件
*
*  @param URL        请求地址
*  @param params 请求参数
*  @param images     图片数组
*  @param name       文件对应服务器上的字段
*  @param fileNames   文件名
 @param imageScale 图片文件压缩比 范围 (0.f ~ 1.f)
*  @param imageType   图片文件的类型,例:png、jpeg(默认类型)....
*  @param progres   上传进度信息
*  @param success    请求成功的回调
*  @param failure    请求失败的回调
*
*/
+ (void)uploadWithURL:(NSString *)URL
           params:(NSDictionary *)params
           images:(NSArray<UIImage *> *)images
                 name:(NSString *)name
             filename:(NSArray<NSString *> *)fileNames
              loading:(BOOL)needloading
             imageScale:(CGFloat)imageScale
            imageType:(NSString *)imageType
             progress:(progressHandle)progres
              success:(successHandle)success
              failure:(failureHandle)failure;

/**
 *  上传文件
 *
 *  @param URL        请求地址
 *  @param params 请求参数
 *  @param name       文件对应服务器上的字段
 *  @param filePath   文件本地的沙盒路径
 *  @param progres   上传进度信息
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
*/
+ (void)uploadFileWithURL:(NSString *)URL
              params:(NSDictionary *)params
                    name:(NSString *)name
                 filePath:(NSString *)filePath
                 loading:(BOOL)needloading
                progress:(progressHandle)progres
                 success:(successHandle)success
                 failure:(failureHandle)failure;

@end
