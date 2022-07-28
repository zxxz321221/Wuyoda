//
//  SceneDelegate.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/9.
//

#import "SceneDelegate.h"
#import "WelcomeViewController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    
    if (@available(iOS 13.0, *)) {
        UIWindowScene *windowScene = (UIWindowScene *)scene;
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
        [self.window setWindowScene:windowScene];
        [self.window setBackgroundColor:[UIColor whiteColor]];
        //[self.window setRootViewController:[FJTabBarViewController new]];
        if ([UserInfoModel getUserInfoModel].member_id) {
            [[NSUserDefaults standardUserDefaults] setValue:@"none" forKey:@"firstOpen"];
        }
        NSString *openStatus = [[NSUserDefaults standardUserDefaults]objectForKey:@"firstOpen"];
        
        if ([openStatus isEqualToString:@"none"]) {
            self.window.rootViewController = [[FJTabBarViewController alloc]init];
        }else{
            WelcomeViewController *vc = [[WelcomeViewController alloc]init];
            self.window.rootViewController = vc;
        }
        
        [self.window makeKeyAndVisible];
    } else {
        // Fallback on earlier versions
    }
    
}



-(void) onResp:(BaseResp*)resp{
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *temp = (SendAuthResp *)resp;
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"text/plain", @"application/json", @"text/json", @"text/javascript", @"text/html", @"image/png", nil];
        NSString *accessUrlStr = [NSString stringWithFormat:@"%@/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code", WX_BASE_URL, WXPatient_App_ID, WXPatient_App_Secret, temp.code];
        [manager GET:accessUrlStr parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"请求access的response = %@", responseObject);
            NSString *openid = responseObject[@"openid"];
            NSString *unionid = responseObject[@"unionid"];
            NSString *access_token = responseObject[@"access_token"];
            if (openid == nil || unionid == nil) {
                return ;
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"weixinLoginSuccess" object:responseObject];
// 微信登录成功

//            NSString *vcName =  NSStringFromClass([[self currentViewController] class]);
//            if ( [vcName isEqualToString :@"MyViewController"]) {
//                // 从个人资料页绑定微信
//
//                [self PersonInfoWithWXLoginWithOpenid:openid withUnionid:unionid];
//
//
//            }else {
////
////                // 从登录页进行微信登录
//            NSString* urlStr = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",access_token,openid];
//
//            [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//
//            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                NSString *nickname = responseObject[@"nickname"];
//                NSString *headimgurl = responseObject[@"headimgurl"];
//                [self WXLoginWithOpenId:openid withUnionid:unionid userName:nickname wxHeadImg:headimgurl];
//            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                NSLog(@"error ==%@",error);
//            }];
//
//
//           }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
            }];
    }else if ([resp isKindOfClass:[PayResp class]]){
        PayResp*response=(PayResp*)resp;

        switch(response.errCode){
            case WXSuccess:
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"payResultCallBack" object:nil];
            }

                break;
            default:
                NSLog(@"支付失败，retcode=%d",resp.errCode);
                UIView *view = [[UIApplication sharedApplication].delegate window];
                if (resp.errStr.length) {
                    [view showHUDWithText:resp.errStr withYOffSet:0];
                }else{
                    [view showHUDWithText:@"支付失败" withYOffSet:0];
                }
                
                break;
        }
    }
}

//- (void)scene:(UIScene *)scene continueUserActivity:(NSUserActivity *)userActivity  API_AVAILABLE(ios(13.0)){
//    [WXApi handleOpenUniversalLink:userActivity delegate:self];
//}

- (void)scene:(UIScene *)scene openURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts
{
    if (@available(iOS 13.0, *)) {
        UIOpenURLContext *urlContext = URLContexts.allObjects.firstObject;
        if (urlContext) {
            [WXApi handleOpenURL:urlContext.URL delegate:self];
        }
    } else {
        // Fallback on earlier versions
    }
    
}

- (void)sceneDidDisconnect:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene API_AVAILABLE(ios(13.0)){
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene API_AVAILABLE(ios(13.0)){
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene API_AVAILABLE(ios(13.0)){
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene API_AVAILABLE(ios(13.0)){
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
