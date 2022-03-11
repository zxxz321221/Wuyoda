//
//  FJNetTool.m
//  FJFramework
//
//  Created by 樊静 on 2017/6/30.
//  Copyright © 2017年 樊静. All rights reserved.
//

#import "FJNetTool.h"

@implementation FJNetTool
// get 无缓存
+ (void)getWithParams:(id)params url:(NSString *)url loading:(BOOL)needloading success:(successHandle)success failure:(failureHandle)failure {
    if (needloading) {
        [SVProgressHUD setInfoImage:kGetImage(@"下载")];
          [SVProgressHUD show];
      }

    if (![url containsString:@"http"]) {
        url = [NSString stringWithFormat:@"%@%@",HTTP,url];
    }

    [PPNetworkHelper GET:url parameters:params success:^(id responseObject) {
        if (success) {
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
            success(dic);
        }
        [self tocastWithResponseObject:responseObject with:url params:params loading:needloading];
        [SVProgressHUD dismiss];

    } failure:^(NSError *error)
     {
        dispatch_async(dispatch_get_main_queue(), ^{
                 [[CommonManager getCurrentViewController].view showHUDWithText:@"网络连接异常，请检查后重试!" withYOffSet:0];
                           if (needloading == YES) {
                               [SVProgressHUD dismiss];

                            };
                        });
        if (failure) {
            failure(error);
        }
    }];
}
// post 无缓存
+ (void)postWithParams:(id)params url:(NSString *)url loading:(BOOL)needloading success:(successHandle)success failure:(failureHandle)failure {

    if (needloading) {
        
//        [SVProgressHUD setImageViewSize:CGSizeMake(kWidth(90), kWidth(61))];
//        [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
//        NSData *gifData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"加载小象" ofType:@"gif"]]];
//
//        [SVProgressHUD showImage:[UIImage hx_animatedGIFWithData:gifData] status:@""];
        [SVProgressHUD show];
    }
    if (![url containsString:@"http"]) {
        url = [NSString stringWithFormat:@"%@%@",HTTP,url];
    }
    
    [PPNetworkHelper POST:url parameters:params success:^(id responseObject) {


     if (success) {
            NSError *err;
         if ([url containsString:Login_GetToken]) {
             success(responseObject);
         }else{
             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:&err];
             success(dic);
         }
             
            
        }
        
        [self tocastWithResponseObject:responseObject with:url params:params loading:needloading];
        [SVProgressHUD dismiss];
        


    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[CommonManager getCurrentViewController].view showHUDWithText:@"网络连接异常，请检查后重试!" withYOffSet:0];
                     if (needloading == YES) {
                         [SVProgressHUD dismiss];

                      };
                  });
   if (failure) {
             failure(error);
         }
    }];
}
#pragma mark - 上传图片
+(void)uploadWithURL:(NSString *)URL
               params:(NSDictionary *)params
               images:(NSArray<UIImage *> *)images
                 name:(NSString *)name
             filename:(NSArray<NSString *> *)fileNames
              loading:(BOOL)needloading
              imageScale:(CGFloat)imageScale
              imageType:(NSString *)imageType
             progress:(progressHandle)progres
              success:(successHandle)success
              failure:(failureHandle)failure {


      if (needloading == YES) {
          [SVProgressHUD show];
      }
    URL = [NSString stringWithFormat:@"%@%@",HTTP,URL];

    [PPNetworkHelper uploadImagesWithURL:URL parameters:params name:name images:images fileNames:fileNames imageScale:imageScale imageType:imageType progress:^(NSProgress *progress) {
        if (progress) {
            progres(progress);
            }
    } success:^(id responseObject) {

        if (success) {
                  success(responseObject);
              }
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (needloading == YES) {
                [SVProgressHUD dismiss];
            };
        });
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 上传文件
+ (void)uploadFileWithURL:(NSString *)URL
              params:(NSDictionary *)params
                    name:(NSString *)name
                 filePath:(NSString *)filePath
                 loading:(BOOL)needloading
                progress:(progressHandle)progres
                 success:(successHandle)success
                  failure:(failureHandle)failure {
    if (needloading == YES) {
        [SVProgressHUD show];
    }
  URL = [NSString stringWithFormat:@"%@%@",HTTP,URL];

    [PPNetworkHelper uploadFileWithURL:URL parameters:params name:name filePath:filePath progress:^(NSProgress *progress) {
        if (progress) {
            progres(progress);
            }
    } success:^(id responseObject) {
        if (success) {
                  success(responseObject);
              }
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (needloading == YES) {
                [SVProgressHUD dismiss];
            };
        });
        if (failure) {
            failure(error);
        }
    }];
}
+(void)tocastWithResponseObject:(id)responseObject  with:(NSString*)url params:(id)params  loading:(BOOL)needloading{

    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];

        if (code && ![code isEqualToString:CODE0]) {
            // 接口有错
            NSString *msg = responseObject[@"message"];
            if (msg && msg.length > 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[CommonManager getCurrentViewController].view showHUDWithText:msg withYOffSet:0];
                });
            }
        
//            if ([code isEqualToString:@"-201"]) {
//                // 退出登录
//                [[FJAppSetting appsetting] logoutAction];
//            }
            
        }

            dispatch_async(dispatch_get_main_queue(), ^{
                if (needloading == YES) {
  [SVProgressHUD dismiss];
                };
            });


#ifdef DEBUG
        if (![code isEqualToString:CODE0]) {
            NSLog(@"这个接口有问题 : %@\n params:%@===%@",url,params,code);
        }
#endif
    }


}


@end

