//
//  AppDelegate.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/9.
//

#import "AppDelegate.h"
#import "WelcomeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSDictionary *dic = [KeyChain load:KEY_USERNAME_PASSWORD];
    NSLog(@"%@",[dic objectForKey:KEY_PASSWORD]);
    if (![dic objectForKey:KEY_PASSWORD]) {
        NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
        [usernamepasswordKVPairs setObject:[KeyChain get32RandomDigit] forKey:KEY_PASSWORD];
        [KeyChain save:KEY_USERNAME_PASSWORD data:usernamepasswordKVPairs];
    }
    RegisterModel *registerModel = [RegisterModel getUserInfoModel];
    if (!registerModel) {
        registerModel = [[RegisterModel alloc]init];
    }
    
    if (@available(iOS 13.0, *)) {
        self.window.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
        } else {
            if ([UserInfoModel getUserInfoModel].member_id) {
                [[NSUserDefaults standardUserDefaults] setValue:@"none" forKey:@"firstOpen"];
            }
            NSString *openStatus = [[NSUserDefaults standardUserDefaults]objectForKey:@"firstOpen"];
            
            self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
            
            self.window.backgroundColor = [UIColor whiteColor];
            
            
            if ([openStatus isEqualToString:@"none"]) {
                self.window.rootViewController = [[FJTabBarViewController alloc]init];
            }else{
                WelcomeViewController *vc = [[WelcomeViewController alloc]init];
                self.window.rootViewController = vc;
            }
            [self.window makeKeyAndVisible];
            
            
        }
    
    [WXApi registerApp:WXPatient_App_ID universalLink:WXPatient_App_NIVERSAL_LINK];
    [self getAppleLoginHiden];
    sleep(2);
   
    return YES;
}

-(void)getAppleLoginHiden{
    [FJNetTool postWithParams:@{} url:AppleLogin_hiden loading:NO success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"msg"] forKey:@"appleLogin"];
        }
            
    } failure:^(NSError *error) {
            
    }];
}

//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//    return  [WXApi handleOpenURL:url delegate:self];
//}
//
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//    return [WXApi handleOpenURL:url delegate:self];
//}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return  [WXApi handleOpenURL:url delegate:self];
}

-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler{
    return [WXApi handleOpenUniversalLink:userActivity delegate:self];
}

-(void)onResp:(BaseResp *)resp{
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


    }
}


#pragma mark - UISceneSession lifecycle

//
//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}


@end
