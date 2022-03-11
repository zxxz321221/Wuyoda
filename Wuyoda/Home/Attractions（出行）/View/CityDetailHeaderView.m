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
    
    self.backgroundColor = [ColorManager WhiteColor];
    self.imgV = [[UIImageView alloc]init];
    //self.imgV.backgroundColor = [ColorManager RandomColor];
    [self addSubview:self.imgV];
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(16));
        make.right.mas_offset(-16);
        make.top.mas_offset(kWidth(5));
        make.height.mas_offset(kWidth(174));
    }];
    
//    self.introLab = [[UILabel alloc]init];
//    //self.introLab.text = @"高雄市的旅游风情：拥有大都市现代风格的高雄市，旅游景点的丰富让人目不暇给，在市区有高雄85大楼、城市光廊、玫瑰圣母院、驳二艺术特区、瑞丰夜市、爱河之心(如意湖)、梦时代购物中心等，而近郊的旗津风景区、莲池潭、西子湾风景区也都有秀丽的景致供前往旅游的民众观赏；除此之外，五都合并前的高雄县，占地相当广大且旅游资源相对丰富，不论您打算来趟访古之旅拜访旗山老街、美浓、桥头糖厂，亦或是山林寻幽之旅，如阿公店水库、观音山、荖浓溪、茂林国家风景区、关山越岭古道、宝来温泉等，都可依您想到高雄旅游的目的来安排；而甫于2010年全新开幕位于大树区观音山风景区旁的义大世界，九十余公顷的面积，区域内包含学校、星级饭店、游乐世界、购物广场等涵盖文化艺术、购物美食、休闲渡假等多元主题，在南台湾掀起渡假游憩新风潮，也是您探访高雄不可错过的新兴景点。";
//    self.introLab.textColor = [ColorManager Color333333];
//    self.introLab.font = kFont(16);
//    self.introLab.numberOfLines = 0;
//    self.introLab.lineBreakMode = NSLineBreakByCharWrapping;
//    [self addSubview:self.introLab];
//    [self.introLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(kWidth(20));
//        make.right.mas_offset(-20);
//        make.top.equalTo(self.imgV.mas_bottom).mas_offset(kWidth(14));
//    }];
    
//    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
//
//            WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//            WKUserContentController *wkUController = [[WKUserContentController alloc] init];
//            [wkUController addUserScript:wkUScript];
//
//            WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
//            wkWebConfig.userContentController = wkUController;
    
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
    [self.webView loadHTMLString:model.city_content baseURL:nil];
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
            self.webView.frame = CGRectMake(kWidth(20), kWidth(195), kScreenWidth-kWidth(40), height+30);
            if (self.delegate && [self.delegate respondsToSelector:@selector(updateCityHeaderHeight:)]) {
                [self.delegate updateCityHeaderHeight:height+30];
            }
           
        }
        
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
