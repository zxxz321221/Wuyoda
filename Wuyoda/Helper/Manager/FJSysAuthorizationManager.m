//
//  FJSysAuthorizationManager.m
//  DuiDianIMProject
//
//  Created by 樊静 on 2020/2/19.
//  Copyright © 2020 longcai. All rights reserved.
//

#import "FJSysAuthorizationManager.h"
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Contacts/Contacts.h>    // 通讯录
#import <CoreLocation/CoreLocation.h>

@implementation FJSysAuthorizationManager

static FJSysAuthorizationManager *instance;

+(instancetype)sharenInsatnce{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FJSysAuthorizationManager alloc]init];
    });
    return instance;
}
-(void)requestAuthorization:(SysAuthorizationType)type completion:(void(^)(NSError *error))completion;{
    switch (type) {
        case KAVMediaVideo:
            [self setVideoRequestCompletion:completion];
            break;
        case KAVMediaAudio:
            [self setAudioRequset:completion];
            break;
        case KCLLocation:
            [self setLocationRequest:completion];
            break;
        case KALAssetsLibary:
            [self setLibaryRequest:completion];
            break;
        case KABAddressBook:
            [self setAddressBook:completion];
            break;
        default:
            break;
    }
}

//请求相机权限
-(void)setVideoRequestCompletion:(void(^)(NSError *error))completion{
    //是否支持
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];

        switch (status) {
            case AVAuthorizationStatusNotDetermined://没有选择权限,就去请求
            {
                //The completion handler is called on an arbitrary dispatch queue. Is it the client's responsibility to ensure that any UIKit-related updates are called on the main queue or main thread as a result.
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {

                    dispatch_async(dispatch_get_main_queue(), ^{

                        if (granted) {
                            completion(nil);
                        }else{
                            NSError *error = [self customErrorWithDescription:@"AVAuthorizationStatusNotDetermined" reson:@"用户禁止访问相机" domain:@"VideoRequest" code:9999];
//                            completion(error);
                            [self showAlertToSet:@"提示" message:@"尚未开启相机权限,您可以去设置->隐私设置开启" completion:^{

                                completion(error);
                            }];
                        }
                    });
                }];
            }
                break;
            case AVAuthorizationStatusRestricted://禁止使用,且状态无法修改
            {
                NSError *error = [self customErrorWithDescription:@"AVAuthorizationStatusRestricted" reson:@"权限禁止使用相机,且状态无法修改" domain:@"VideoRequest" code:9999];
//                completion(error);
                [self showAlertToSet:@"提示" message:@"尚未开启相机权限,您可以去设置->隐私设置开启" completion:^{

                    completion(error);
                }];
            }
                break;
            case AVAuthorizationStatusDenied://禁止使用
            {
                NSError *error = [self customErrorWithDescription:@"AVAuthorizationStatusDenied" reson:@"禁止使用相机" domain:@"VideoRequest" code:9999];

                [self showAlertToSet:@"提示" message:@"尚未开启相机权限,您可以去设置->隐私设置开启" completion:^{
                completion(error);
                     }];
            }
                break;
            case AVAuthorizationStatusAuthorized://授权
                completion(nil);
                break;
            default:
                break;
        }

    }else{
        NSError *error = [self customErrorWithDescription:@"unavailableCamera" reson:@"未获取到相机" domain:@"VideoRequest" code:9999];
        completion(error);
    }
}

//请求相册权限
-(void)setLibaryRequest:(void(^)(NSError *error))completion{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        if ([[UIDevice currentDevice].systemVersion integerValue] >= 8.0) {
            PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
            switch (status) {
                case PHAuthorizationStatusNotDetermined://未知,请求相册权限
                {
                    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {

                        dispatch_async(dispatch_get_main_queue(), ^{

                            if (status == PHAuthorizationStatusAuthorized) {
                                completion(nil);


                            }else if(status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied){
                                NSError *error = [self customErrorWithDescription:@"AVAuthorizationStatusNotDetermined" reson:@"用户禁止访问相机" domain:@"VideoRequest" code:9999];

                                [self showAlertToSet:@"提示" message:@"禁止访问相册,您可以去设置->隐私设置开启" completion:^{

                                    completion(error);
                                }];
                            }
                        });


                    }];
                }
                    break;
                case PHAuthorizationStatusRestricted:
                {
                    NSError *error = [self customErrorWithDescription:@"PHAuthorizationStatusRestricted" reson:@"权限禁止访问相册,且状态无法修改" domain:@"VideoLibaryRequest" code:9999];

                    [self showAlertToSet:@"提示" message:@"禁止访问相册,您可以去设置->隐私设置开启" completion:^{

                        completion(error);
                    }];
                }
                    break;
                case PHAuthorizationStatusDenied:
                {
                    NSError *error = [self customErrorWithDescription:@"PHAuthorizationStatusDenied" reson:@"权限禁止访问相册" domain:@"VideoLibaryRequest" code:9999];
//                    completion(error);
                    [self showAlertToSet:@"提示" message:@"禁止访问相册,您可以去设置->隐私设置开启" completion:^{

                        completion(error);
                    }];
                }
                    break;
                case PHAuthorizationStatusAuthorized:
                    completion(nil);
                    break;
                default:
                    break;
            }
        }else{
            ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
            switch (status) {
                case ALAuthorizationStatusNotDetermined:
                    break;
                case ALAuthorizationStatusRestricted:
                {
                    NSError *error = [self customErrorWithDescription:@"PHAuthorizationStatusRestricted" reson:@"权限禁止访问相册,且状态无法修改" domain:@"VideoLibaryRequest" code:9999];
//                    completion(error);
                    [self showAlertToSet:@"提示" message:@"禁止访问相册,您可以去设置->隐私设置开启" completion:^{

                        completion(error);
                    }];
                }
                    break;
                case ALAuthorizationStatusDenied:
                {
                    NSError *error = [self customErrorWithDescription:@"PHAuthorizationStatusDenied" reson:@"权限禁止访问相册" domain:@"VideoLibaryRequest" code:9999];
//                    completion(error);
                    [self showAlertToSet:@"提示" message:@"禁止访问相册,您可以去设置->隐私设置开启" completion:^{

                        completion(error);
                    }];
                }
                    break;
                case ALAuthorizationStatusAuthorized:
                    completion(nil);
                    break;

                default:
                    break;
            }
        }
    }else{
        NSError *error = [self customErrorWithDescription:@"unavailableLibary" reson:@"未获取到相册" domain:@"VideoRequest" code:9999];
        completion(error);
    }
}

//请求地理定位权限
-(void)setLocationRequest:(void(^)(NSError *error))completion{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        {
            //未知
            NSError *error = [self customErrorWithDescription:@"kCLAuthorizationStatusNotDetermined" reson:@"需要请求定位授权" domain:@"LocationRequest" code:9999];
            [self showAlertToSet:@"提示" message:@"尚未开启定位权限,您可以去设置->隐私设置开启" completion:^{

                completion(error);
            }];

        }
            break;
        case kCLAuthorizationStatusRestricted:
        {
            //限制
            NSError *error = [self customErrorWithDescription:@"kCLAuthorizationStatusRestricted" reson:@"不允许定位授权" domain:@"LocationRequest" code:9999];
            [self showAlertToSet:@"提示" message:@"关闭定位,您可以去设置->隐私设置开启" completion:^{

                completion(error);
            }];

        }
            break;
        case kCLAuthorizationStatusDenied:
        {
            //限制
            if ([CLLocationManager locationServicesEnabled]) {
                //定位开启,但是被拒
                NSError *error = [self customErrorWithDescription:@"kCLAuthorizationStatusDenied" reson:@"已开启定位,不允许定位" domain:@"LocationRequest" code:9999];
                [self showAlertToSet:@"提示" message:@"关闭定位,您可以去设置->隐私设置开启" completion:^{

                    completion(error);
                }];
            }else{
                //定位关闭,不可用
                NSError *error = [self customErrorWithDescription:@"kCLAuthorizationStatusDenied" reson:@"定位关闭,不允许定位" domain:@"LocationRequest" code:9999];
                [self showAlertToSet:@"提示" message:@"关闭定位,您可以去设置->隐私设置开启" completion:^{

                    completion(error);
                }];
            }
        }
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
        {
            //前后台定位授权
            completion(nil);
        }
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            //前台定位授权
            completion(nil);
        }
            break;


        default:
            break;
    }
}

//请求音频权限
-(void)setAudioRequset:(void(^)(NSError *error))completion{
    [self canRecord:completion];
}

//请求通讯录权限
-(void)setAddressBook:(void(^)(NSError *error))completion{
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    switch (status) {
        case CNAuthorizationStatusNotDetermined:
        {
            //未知,请求通讯录权限
            CNContactStore *store = [[CNContactStore alloc] init];
                   [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError*  _Nullable error) {
                       if (error) {
                           //无权限
                           dispatch_async(dispatch_get_main_queue(), ^{

                                   NSError *error = [self customErrorWithDescription:@"CNAuthorizationStatusNotDetermined" reson:@"用户未请求通讯录授权" domain:@"addressRequest" code:9999];

                                   [self showAlertToSet:@"提示" message:@"尚未开启通讯录权限,您可以去设置->隐私设置开启" completion:^{

                                       completion(error);
                                   }];
                           });

                       } else {
                           //有权限
                          completion(nil);
                       }
                   }];

        }
            break;
        case CNAuthorizationStatusRestricted:
        {
            NSError *error = [self customErrorWithDescription:@"CNAuthorizationStatusRestricted" reson:@"禁止访问通讯录,状态不允许改变" domain:@"addressRequest" code:9999];
            [self showAlertToSet:@"提示" message:@"禁止访问通讯录,您可以去设置->隐私设置开启" completion:^{

                completion(error);
            }];
        }
            break;
        case CNAuthorizationStatusDenied:
        {
            NSError *error = [self customErrorWithDescription:@"CNAuthorizationStatusDenied" reson:@"禁止访问通讯录,状态可改变" domain:@"addressRequest" code:9999];

//            __weak typeof(self)wSelf = self;

            [self showAlertToSet:@"提示" message:@"禁止访问通讯录,您可以去设置->隐私设置开启" completion:^{

                completion(error);

            }];

        }
            break;
        case CNAuthorizationStatusAuthorized:
            completion(nil);
            break;
        default:
            break;
    }
}

-(void)showAlertToSet:(NSString *)title message:(NSString *)message completion:(void(^)())completion{
    UIAlertController *alert= [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {


        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];

        if ([UIDevice currentDevice].systemVersion.integerValue >= 10) {
            if ([[UIApplication sharedApplication] canOpenURL:url])
            {
                [[UIApplication sharedApplication]openURL:url options:@{}
                                        completionHandler:nil];
            }
        } else {
            if ([[UIApplication sharedApplication] canOpenURL:url])
            {
                [[UIApplication sharedApplication] openURL:url];
            }
        }
    }];
    [alert addAction:okAction];
    [alert addAction:cancelAction];


    [[CommonManager getCurrentViewController] presentViewController:alert animated:YES completion:completion];
}

-(void)canRecord:(void(^)(NSError *error))completion{

    if ([[UIDevice currentDevice].systemVersion integerValue] > 7.0) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        if ([session respondsToSelector:@selector(requestRecordPermission:)]) {
            [session performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted){
                if (granted) {
                    completion(nil);
                }else{
                    NSError *error = [self customErrorWithDescription:@"AudioRequsetFaled" reson:@"不允许访问麦克风" domain:@"AudioRequset" code:9999];

                    [self showAlertToSet:@"提示" message:@"不允许访问麦克风,您可以去设置->隐私设置开启" completion:^{

                        completion(error);
                    }];
                }
            }];
        }
    }
}

-(NSError *)customErrorWithDescription:(NSString *)desc reson:(NSString *)reson domain:(NSString *)domain code:(NSInteger)code{
    NSDictionary *dict = @{
                           NSLocalizedDescriptionKey:desc,//错误描述
                           NSLocalizedFailureReasonErrorKey:reson,//错误原因
                           };
    NSError *error = [NSError errorWithDomain:domain code:code userInfo:dict];
    return error;
}



@end
