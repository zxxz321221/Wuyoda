//
//  VideoCourseViewController.m
//  SoHappy
//
//  Created by mac on 2021/6/21.
//

#import "VideoCourseViewController.h"

@interface VideoCourseViewController ()

@end

@implementation VideoCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadWeb];
}


-(void)loadWeb {
    //创建网页配置对象
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];

    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    preferences.minimumFontSize = 30.0;
   configuration.preferences = preferences;
    configuration.allowsInlineMediaPlayback = YES;
    if (@available(iOS 10.0, *)) {
        // WKAudiovisualMediaTypeNone 音视频的播放不需要用户手势触发, 即为自动播放
        configuration.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeNone;
    } else {
        configuration.requiresUserActionForMediaPlayback = NO;
    }

  
      //自定义的WKScriptMessageHandler 是为了解决内存不释放的问题
     WeakWebViewScriptMessageDelegate *weakScriptMessageDelegate = [[WeakWebViewScriptMessageDelegate alloc] initWithDelegate:self];
  //   这个类主要用来做native与JavaScript的交互管理
     WKUserContentController * wkUController = [[WKUserContentController alloc] init];
  //   注册一个name为jsToOcNoPrams的js方法
    [wkUController addScriptMessageHandler:weakScriptMessageDelegate name:@"payResult"];

    configuration.userContentController = wkUController;
    

    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight) configuration:configuration];
    if (@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    //self.webView.allowsBackForwardNavigationGestures = YES;
    
    [self.view addSubview:self.webView];
    
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.courseUrl]]];

}

-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if ([message.name isEqualToString:@"payResult"]) {
        NSArray *arr = message.body;
        NSLog(@"arr:::%@",arr);
        //[self studyFinishFromServerWithType:@"1"];
    }
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
