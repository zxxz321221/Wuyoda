//
//  WelcomeViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2022/3/11.
//

#import "WelcomeViewController.h"
#import "AppDelegate.h"

@interface WelcomeViewController ()<UIScrollViewDelegate>

@property (nonatomic , retain)UIScrollView *scrollV;

@property (nonatomic , retain)UIPageControl *pageC;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *openStatus = [[NSUserDefaults standardUserDefaults]objectForKey:@"firstOpen"];
    if (openStatus.length) {
        [self loginUI];
    }else{
        [self welcomeUI];
    }
    
}

-(void)welcomeUI{
    self.scrollV = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.scrollV.contentSize = CGSizeMake(kScreenWidth*3, 0);
    self.scrollV.pagingEnabled = YES;
    self.scrollV.showsHorizontalScrollIndicator = YES;
    self.scrollV.delegate = self;
    [self.view addSubview:self.scrollV];
    
    self.pageC = [[UIPageControl alloc]initWithFrame:CGRectMake(0, kScreenHeight-kHeight_SafeArea-kWidth(40), kScreenWidth, kWidth(40))];
    self.pageC.pageIndicatorTintColor = [ColorManager Color999999];
    self.pageC.currentPageIndicatorTintColor = [ColorManager ColorFD817C];
    self.pageC.numberOfPages = 3;
    self.pageC.currentPage = 0;
    [self.view addSubview:self.pageC];
    
    for (int i = 0; i<3; i++) {
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, kScreenHeight)];
        imgV.contentMode = UIViewContentModeScaleAspectFit;
        NSString *imgName = [NSString stringWithFormat:@"引导页%d",i+1];
        
        [imgV setImage:kGetImage(imgName)];
        [self.scrollV addSubview:imgV];
        if (i == 2) {
            imgV.userInteractionEnabled = YES;
            UIButton *welcomeBtn = [[UIButton alloc]init];
            [welcomeBtn setTitle:@"立即体验" forState:UIControlStateNormal];
            [welcomeBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
            welcomeBtn.titleLabel.font = kFont(18);
            welcomeBtn.backgroundColor = [ColorManager ColorFB9A3A];
            welcomeBtn.layer.cornerRadius = kWidth(20);
            [welcomeBtn addTarget:self action:@selector(loginUI) forControlEvents:UIControlEventTouchUpInside];
            [imgV addSubview:welcomeBtn];
            [welcomeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(imgV);
                make.bottom.mas_offset(-kHeight_SafeArea-kWidth(110));
                make.width.mas_offset(kWidth(150));
                make.height.mas_offset(kWidth(40));
            }];
        }
        
        
    }
}

-(void)loginUI{
    
    [self.scrollV removeFromSuperview];
    [self.pageC removeFromSuperview];
    [[NSUserDefaults standardUserDefaults] setValue:@"welcome" forKey:@"firstOpen"];
    
    UIImage *bgImg = kGetImage(@"WelcomeBG");
    if (kHeight_SafeArea==0) {
        bgImg = kGetImage(@"WelcomeBG2");
    }
    
    NSLog(@"welcom:%lf---%lf---%lf--%lf",bgImg.size.width,bgImg.size.height,kScreenWidth,kScreenHeight);
    UIImageView *bgImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, bgImg.size.height/(bgImg.size.width/kScreenWidth))];
    [bgImgV setImage:bgImg];
    //bgImgV.backgroundColor = [UIColor redColor];
    //bgImgV.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:bgImgV];
    
    UIImageView *logoImgV = [[UIImageView alloc]initWithImage:kGetImage(@"appLogo")];
    [self.view addSubview:logoImgV];
    [logoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(kWidth(-118)-kHeight_SafeArea);
        make.centerX.equalTo(self.view);
        make.width.height.mas_offset(kWidth(120));
    }];
    
//    UILabel *nameLab = [[UILabel alloc]init];
//    nameLab.text = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleDisplayName"];
//    nameLab.textColor = [ColorManager Color555555];
//    nameLab.font = kFont(18);
//    [self.view addSubview:nameLab];
//    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//        make.top.equalTo(logoImgV.mas_bottom).mas_offset(kWidth(5));
//    }];
//
//    UILabel *titleLab = [[UILabel alloc]init];
//    titleLab.text = @"有我在便送到家";
//    titleLab.textColor = [ColorManager Color008A70];
//    titleLab.font = kFont(16);
//    [self.view addSubview:titleLab];
//    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//        make.top.equalTo(nameLab.mas_bottom).mas_offset(kWidth(11));
//    }];
    
    UIButton *registerBtn = [[UIButton alloc]init];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    registerBtn.titleLabel.font = kFont(14);
    registerBtn.backgroundColor = [ColorManager ColorFA8B18];
    registerBtn.layer.cornerRadius = kWidth(24);
    [registerBtn addTarget:self action:@selector(registerClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.mas_offset(kWidth(-50)-kHeight_SafeArea);
        make.width.mas_offset(kWidth(321));
        make.height.mas_offset(kWidth(48));
    }];
    
    UILabel *bottomLab = [[UILabel alloc]init];
    bottomLab.text = @"已经有账号了？";
    bottomLab.textColor = [ColorManager Color333333];
    bottomLab.font = kFont(14);
    [self.view addSubview:bottomLab];
    [bottomLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(125));
        make.top.equalTo(registerBtn.mas_bottom).mas_offset(kWidth(24));
    }];
    
    UIButton *loginBtn = [[UIButton alloc]init];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[ColorManager MainColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = kFont(14);
    [loginBtn addTarget:self action:@selector(loginClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomLab);
        make.left.equalTo(bottomLab.mas_right);
        make.width.mas_offset(kWidth(30));
        make.height.mas_offset(kWidth(20));
    }];
}

-(void)loginClicked{
    [[NSUserDefaults standardUserDefaults] setValue:@"login" forKey:@"firstOpen"];
    FJTabBarViewController *VC = [[FJTabBarViewController alloc] init];
    
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    if ([UIApplication sharedApplication].keyWindow) {
        window = [UIApplication sharedApplication].keyWindow;
    }
    
    [window setRootViewController:VC];
    
}

-(void)registerClicked{
    
    [[NSUserDefaults standardUserDefaults] setValue:@"register" forKey:@"firstOpen"];
    FJTabBarViewController *VC = [[FJTabBarViewController alloc] init];
    
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    if ([UIApplication sharedApplication].keyWindow) {
        window = [UIApplication sharedApplication].keyWindow;
    }
    
    [window setRootViewController:VC];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.pageC.currentPage = scrollView.contentOffset.x/kScreenWidth;
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
