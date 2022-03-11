//
//  FJWebViewController.m
//  LotteryTicketNews
//
//  Created by 樊静 on 2017/6/7.
//  Copyright © 2017年 樊静. All rights reserved.
//

#import "FJWebViewController.h"
#import <WebKit/WebKit.h>
#import "MessageModel.h"
#import "PaySuccessViewController.h"
#import "WeakWebViewScriptMessageDelegate.h"

@interface FJWebViewController ()<WKNavigationDelegate,WKScriptMessageHandler>
@property (nonatomic,strong) WKWebView * myWebView;

//顶部进度
@property (nonatomic, strong) UIProgressView *myProgressView;

@property (nonatomic,copy) NSString * payResultUrl;

@end




@implementation FJWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ColorManager WhiteColor];

    FJNormalNavView *nav = [[FJNormalNavView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:self.title];
         [self.view addSubview:nav];
    if (self.ordersn.length) {
        nav.isInitBackBtn = YES;
        nav.block = ^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        };
    }

    [self.view addSubview:self.myProgressView];

//    UIView *bgView = [[UIView alloc] init];
//    bgView.backgroundColor = [ColorManager WhiteColor];
//    bgView.layer.shadowColor = [UIColor colorWithRed:14/255.0 green:23/255.0 blue:3/255.0 alpha:0.1].CGColor;
//    bgView.layer.shadowOffset = CGSizeMake(0,0);
//    bgView.layer.shadowOpacity = 1;
//    bgView.layer.shadowRadius = 5;
//    bgView.layer.cornerRadius = 10;
//    [self.view addSubview:bgView];
//    bgView.sd_layout.leftSpaceToView(self.view, kWidth(12)).rightSpaceToView(self.view, kWidth(12)).topSpaceToView(self.view, kWidth(14)+kHeight_NavBar).bottomSpaceToView(self.view, kWidth(14)+kHeight_SafeArea);
//

    [self.view addSubview:self.myWebView];

    //self.myWebView.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).topSpaceToView(self.view,kHeight_NavBar).bottomSpaceToView(self.view, kHeight_SafeArea);
    [self.myWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_offset(kHeight_NavBar);
        make.bottom.mas_offset(-kHeight_SafeArea);
    }];
    if (self.url.length>0) {
        
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    }else{
        [self request];
    }
    



}
// 记得取消监听
- (void)dealloc
{
    [self.myWebView removeObserver:self forKeyPath:@"estimatedProgress"];
//    self.myWebView.navigationDelegate = nil;
}

#pragma mark - WKNavigationDelegate method
// 如果不添加这个，那么wkwebview跳转不了AppStore
//payresult=success?ordersn=xxxxx&userid=xxxxx
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    if ([webView.URL.absoluteString hasPrefix:@"https://itunes.apple.com"]) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else if ([webView.URL.absoluteString containsString:@"orderId"] && [webView.URL.absoluteString containsString:@"payResult"] && [webView.URL.absoluteString containsString:@"/mobile/Receivepg/index"]){
        
        self.payResultUrl = webView.URL.absoluteString;

    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - event response
// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.myWebView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        self.myProgressView.alpha = 1.0f;
        [self.myProgressView setProgress:newprogress animated:YES];
        if (newprogress >= 1.0f) {
            [UIView animateWithDuration:0.3f
                                  delay:0.3f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.myProgressView.alpha = 0.0f;
                             }
                             completion:^(BOOL finished) {
                                 [self.myProgressView setProgress:0 animated:NO];
                             }];
        }

    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    if (self.payResultUrl.length) {
        NSString *dataStr = [[self.payResultUrl componentsSeparatedByString:@"?"] lastObject];
        NSArray *dataArr = [dataStr componentsSeparatedByString:@"&"];
        NSString *orderId = @"";
        BOOL isSuccess = NO;
        
        for (NSString *parameter in dataArr) {
            if ([parameter hasPrefix:@"payResult"]) {
                if ([parameter containsString:@"10"]) {
                    isSuccess = YES;
                }
            }
            
            if ([parameter hasPrefix:@"orderId"]) {
                orderId = [[parameter componentsSeparatedByString:@"="] lastObject];
            }
        }
        
        if (isSuccess && orderId.length) {
            [self getOrderStatusFromServer:orderId];
        }
    }
}

#pragma mark - getter and setter
- (UIProgressView *)myProgressView
{
    if (_myProgressView == nil) {
        _myProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, kHeight_NavBar, [UIScreen mainScreen].bounds.size.width, 0)];
        _myProgressView.tintColor = [ColorManager MainColor];
        _myProgressView.trackTintColor = [UIColor whiteColor];
    }

    return _myProgressView;
}

- (WKWebView *)myWebView
{
    if(_myWebView == nil)
    {
        
        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
        
        NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";

                WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
                WKUserContentController *wkUController = [[WKUserContentController alloc] init];
                [wkUController addUserScript:wkUScript];
        
        WeakWebViewScriptMessageDelegate *weakScriptMessageDelegate = [[WeakWebViewScriptMessageDelegate alloc] initWithDelegate:self];
        [wkUController addScriptMessageHandler:weakScriptMessageDelegate  name:@"payResult"];

            
        WKPreferences *preferences = [WKPreferences new];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        wkWebConfig.preferences = preferences;
        
                wkWebConfig.userContentController = wkUController;
        
        _myWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:wkWebConfig];
        _myWebView.navigationDelegate = self;
        _myWebView.opaque = NO;
        _myWebView.multipleTouchEnabled = YES;
        [_myWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    }

    return _myWebView;
}
-(void)request{
    NSString *url;
    NSMutableDictionary *pardic = [NSMutableDictionary dictionary];
    [pardic setValue:[RegisterModel getUserInfoModel].user_token forKey:@"api_token"];
    if (self.type ==  0 ) {
        url = Store_notice_list;
        [pardic setValue:self.uid forKey:@"uid"];
    }
    else if (self.type ==  1 ){
        url = Store_shopprocess;
    }else if (self.type  == 2){
        url = Store_deliveryfaq;
    }else if (self.type  == 3){
        url = Store_return_policy;
    }else if (self.type  == 4){
        url = Store_aboutus;
    }else if (self.type  == 5){
        url = Store_recruitment;
    }else if (self.type  == 6){
        url = Store_brand_list;
    }
    
    [FJNetTool postWithParams:pardic url:url loading:YES success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        BaseModel *model = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([model.code isEqualToString:CODE0]) {
            if (self.type ==  0 ) {
                MessageModel *msgModel = [MessageModel mj_objectWithKeyValues:responseObject[@"data"]];
                [self loadHtml:msgModel.board_body];
                
            }
            if (self.type ==  1 || self.type ==  2) {
                [self loadHtml:responseObject[@"data"][@"page_body"]];
                
            }
            if (self.type ==  3 || self.type == 4 || self.type == 5 || self.type == 6) {
                NSDictionary *dataDic = responseObject[@"data"];
                [self loadHtml:dataDic[@"page_body"]];
            }
        }else{
            [self.view showHUDWithText:model.msg withYOffSet:0];
        }
    } failure:^(NSError *error) {
        
    }];

}
-(void)loadHtml:(NSString *)str {
    NSString *htmlString = [NSString stringWithFormat:@"<html> \n"
        "<head> \n"
        "<style type=\"text/css\"> \n"
        "body {font-size:40px;}\n"
        "</style> \n"
        "</head> \n"
        "<body>"
        "<script type='text/javascript'>"
        "window.onload = function(){\n"
        "var $img = document.getElementsByTagName('img');\n"
        "for(var p in  $img){\n"
        " $img[p].style.width = '100%%';\n"
        "$img[p].style.height ='auto'\n"
        "}\n"
        "}"
        "</script>%@"
        "</body>"
        "</html>", str];
    [self.myWebView loadHTMLString:htmlString baseURL:nil];

}

-(void)getOrderStatusFromServer:(NSString *)orderId{
    NSDictionary *dic = @{@"ordersn":orderId,@"api_token":[RegisterModel getUserInfoModel].user_token};
    
    [FJNetTool postWithParams:dic url:Special_pay_result loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            
            PaySuccessViewController *vc = [[PaySuccessViewController alloc]init];
            vc.type = @"1";
            vc.ordersn = orderId;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            [self.view showHUDWithText:baseModel.msg withYOffSet:0];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        
    }];
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
