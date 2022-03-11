//
//  ProductDetailIntroduceTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/15.
//

#import "ProductDetailIntroduceTableViewCell.h"
#import <WebKit/WebKit.h>

@interface ProductDetailIntroduceTableViewCell ()<WKUIDelegate,WKNavigationDelegate>

//@property (nonatomic , retain)UILabel *introLab;



@property (nonatomic , retain)UIButton *moreBtn;

@property (nonatomic , assign)CGFloat webH;
@property (nonatomic , assign)BOOL webFinish;

@end

@implementation ProductDetailIntroduceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
//    self.introLab = [[UILabel alloc]init];
//    self.introLab.text = @"味荣于丰原耕耘七十余年，致力于结合在地农产与人文。葫芦墩(丰原旧名)自古以「水清、米白、查某水」闻名。\n「水清」意指大甲溪引进的水清澈无比，「米白」指的曾受天皇称赞的葫芦墩米。味荣酱油采用葫芦墩圳水与米、并承袭老师傅的酿造工艺，成就了滴滴亮亮的好味道。且以精致味噌、有机酿造的专家为经营指标，多年累积的特殊口味与专业生产经验，奠定台湾中部第一品牌的地位及信誉，以客户的满意为依归，贯彻品质目标。";
//    self.introLab.textColor= [ColorManager BlackColor];
//    self.introLab.font = kFont(14);
//    self.introLab.numberOfLines = 0;
//    self.introLab.lineBreakMode = NSLineBreakByCharWrapping;
//    [self.contentView addSubview:self.introLab];
//    [self.introLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(kWidth(20));
//        make.right.mas_offset(kWidth(-20));
//        make.top.mas_offset(kWidth(5));
//    }];
    
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
    self.webView.scrollView.scrollEnabled = NO;
    [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    //self.webView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.webView];
    
//    self.moreBtn = [[UIButton alloc]init];
//    [self.moreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
//    [self.moreBtn setTitleColor:[ColorManager MainColor] forState:UIControlStateNormal];
//    self.moreBtn.titleLabel.font = kFont(14);
//    [self.contentView addSubview:self.moreBtn];
//    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(kWidth(20));
//        make.bottom.mas_offset(-20);
//        make.width.mas_offset(kWidth(70));
//        make.height.mas_offset(kWidth(20));
//    }];
    self.webFinish = NO;
}

-(void)setModel:(HomeShopModel *)model{

    if (model.goods_main.length) {
        NSString *headerString = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>";
            [self.webView loadHTMLString:[headerString stringByAppendingString:model.goods_main] baseURL:nil];
    }
    

//    [self.webView loadHTMLString:model.goods_main baseURL:nil];
 
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    // 不执行前段界面弹出列表的JS代码，关闭系统的长按保存图片
//        [self.webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
        
    //self.webFinish = YES;
        //    document.body.scrollHeight（不准）   document.body.offsetHeight;(好)
        [webView evaluateJavaScript:@"document.body.offsetHeight;" completionHandler:^(id Result, NSError * error) {
          //NSString *heightStr = [NSString stringWithFormat:@"%@",Result];

                //必须加上一点
                //CGFloat height = heightStr.floatValue+15.00;
                //网页加载完成
               

            CGFloat height = webView.scrollView.contentSize.height;
            //NSLog(@"新闻加载完成网页高度2222222：%f",height);

            //self.webView.frame = CGRectMake(kWidth(20), kWidth(5), kScreenWidth-kWidth(40), height+kWidth(100));
//            if (self.delegate && [self.delegate respondsToSelector:@selector(updateProductInftoduceHeight:)]) {
//                [self.delegate updateProductInftoduceHeight:height+kWidth(100)];
//            }

        }];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    UIScrollView *scrollView = object;
        //NSLog(@"%@", @(scrollView.contentOffset));
    if (scrollView.contentOffset.y < 0 ) {
        self.webFinish = YES;
    }
    if ([keyPath isEqualToString:@"contentSize"]) {
        
        CGFloat height = scrollView.contentSize.height;
        NSInteger heightInt = height;
        NSInteger currentH = self.webH;
        if (heightInt-30 != currentH && !self.webFinish) {
            NSLog(@"新闻加载完成网页高度：%ld--%ld",heightInt,currentH);
            self.webH = height;
//            self.webView.frame = CGRectMake(kWidth(20), kWidth(5), kScreenWidth-kWidth(40), height+30);
//            if (self.delegate && [self.delegate respondsToSelector:@selector(updateProductInftoduceHeight:)]) {
//                [self.delegate updateProductInftoduceHeight:height+30];
//            }
            self.webView.frame = CGRectMake(kWidth(20), kWidth(5), kScreenWidth-kWidth(40), height+30);
            if (self.delegate && [self.delegate respondsToSelector:@selector(updateProductInftoduceHeight:)]) {
                [self.delegate updateProductInftoduceHeight:height+30];
            }

        }
        
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
