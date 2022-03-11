//
//  BaseWebAIViewController.m
//  SoHappy
//
//  Created by 大连龙采 on 2021/4/1.
//

#import "BaseWebAIViewController.h"
#import "AppDelegate.h"


@interface BaseWebAIViewController ()

@end

@implementation BaseWebAIViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    AICourseDownloadView *downloadV = [[AICourseDownloadView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width)];
//    [self.view addSubview:downloadV];
//    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}



-(void) goMicroPhoneSet
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"您还没有允许麦克风权限" message:@"去设置一下吧" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

    }];
    UIAlertAction * setAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if (@available(iOS 10.0, *)) {
                [UIApplication.sharedApplication openURL:url options:nil completionHandler:^(BOOL success) {
                    
                }];
            } else {
                // Fallback on earlier versions
            }
        });
    }];

    [alert addAction:cancelAction];
    [alert addAction:setAction];

    [self presentViewController:alert animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL * url = navigationAction.request.URL;
    NSString * scheme = [url scheme];
    decisionHandler(WKNavigationActionPolicyAllow);
//    decisionHandler(WKNavigationActionPolicyCancel);
}

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"xuow%@",error);
    [SVProgressHUD dismiss];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'" completionHandler:nil];

    [SVProgressHUD dismiss];
}

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    NSLog(@"message == %@", message);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            //completionHandler();
            
        }]];
    [self presentViewController:alertController animated:YES completion:^{}]; 
    completionHandler();
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"+++++%@++++%@", message.body, message.name);
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
