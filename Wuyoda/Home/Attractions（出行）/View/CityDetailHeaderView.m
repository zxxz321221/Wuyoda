//
//  CityDetailHeaderView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/22.
//

#import "CityDetailHeaderView.h"
#import <WebKit/WebKit.h>

@interface CityDetailHeaderView ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic , retain)UIImageView *imgV;

@property (nonatomic , retain)WKWebView *webView;

@property (nonatomic , assign)CGFloat webH;

@end

@implementation CityDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    self.backgroundColor = [ColorManager ColorF2F2F2];
    
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [ColorManager WhiteColor];
    bgView.layer.cornerRadius = kWidth(10);
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.height.equalTo(self);
    }];
    
    self.imgV = [[UIImageView alloc]init];
    //self.imgV.backgroundColor = [ColorManager RandomColor];
    self.imgV.contentMode = UIViewContentModeScaleAspectFit;
    self.imgV.layer.cornerRadius = kWidth(10);
    self.imgV.layer.masksToBounds = YES;
    [self addSubview:self.imgV];
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.top.mas_offset(0);
        make.height.mas_offset(kWidth(188));
    }];
    
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";

            WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
            WKUserContentController *wkUController = [[WKUserContentController alloc] init];
            [wkUController addUserScript:wkUScript];

            WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
            wkWebConfig.userContentController = wkUController;
    self.webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:wkWebConfig];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    self.webView.opaque = NO;
    self.webView.multipleTouchEnabled = YES;
    
    [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    [self addSubview:self.webView];
}

-(void)setModel:(CityDetailModel *)model{
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.title_cover]];
    //self.introLab.text = model.city_content;
//    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
//    [self.webView loadRequest:request];
//    [self.webView loadHTMLString:model.city_content baseURL:nil];
    [self loadHtml:model.city_content];
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    // 不执行前段界面弹出列表的JS代码，关闭系统的长按保存图片
        [self.webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
        
       
        //    document.body.scrollHeight（不准）   document.body.offsetHeight;(好)
        [webView evaluateJavaScript:@"document.body.offsetHeight;" completionHandler:^(id Result, NSError * error) {
          //NSString *heightStr = [NSString stringWithFormat:@"%@",Result];

                //必须加上一点
                //CGFloat height = heightStr.floatValue+15.00;
                //网页加载完成

            CGFloat height = webView.scrollView.contentSize.height/3;
            NSLog(@"新闻加载完成网页高度2222222：%f",height);
            //self.webView.frame = CGRectMake(kWidth(20), kWidth(195), kScreenWidth-kWidth(40), height+kWidth(30));
//            if (self.delegate && [self.delegate respondsToSelector:@selector(updateCityHeaderHeight:)]) {
//                [self.delegate updateCityHeaderHeight:height+kWidth(30)];
//            }

        }];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    UIScrollView *scrollView = object;
        NSLog(@"%@", @(scrollView.contentSize.height));
    if ([keyPath isEqualToString:@"contentSize"]) {
        
        CGFloat height = self.webView.scrollView.contentSize.height;
        if ((int)height-30 != (int)self.webH) {
            NSLog(@"新闻加载完成网页高度：%f--%f",height,self.webH);
            self.webH = height;
            self.webView.frame = CGRectMake(kWidth(20), kWidth(198), kScreenWidth-kWidth(40), height+30);
            if (self.delegate && [self.delegate respondsToSelector:@selector(updateCityHeaderHeight:)]) {
                [self.delegate updateCityHeaderHeight:height+30];
            }
           
        }
        
    }
}

-(void)loadHtml:(NSString *)str {
    NSString *htmlString = [NSString stringWithFormat:@"<html> \n"
        "<head> \n"
        "<style type=\"text/css\"> \n"
        "body {font-size:14px;}\n"
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
    [self.webView loadHTMLString:htmlString baseURL:nil];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
