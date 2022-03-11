//
//  BaseWebAIViewController.h
//  SoHappy
//
//  Created by 大连龙采 on 2021/4/1.
//

#import "FJBaseViewController.h"
#import <WebKit/WebKit.h>
#import "WeakWebViewScriptMessageDelegate.h"
NS_ASSUME_NONNULL_BEGIN
// WKWebView 内存不释放的问题解决

@interface BaseWebAIViewController : FJBaseViewController<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property(nonatomic,strong)WKWebViewConfiguration *configuration;
@property(nonatomic,strong)WKWebView *webView;

@property(nonatomic , retain)UIImageView *loadingImgV;

@property (nonatomic , copy)NSString *courseID;

-(void)studyFinishFromServerWithType:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
