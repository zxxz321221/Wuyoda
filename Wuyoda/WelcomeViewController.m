//
//  WelcomeViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2022/3/11.
//

#import "WelcomeViewController.h"
#import "AppDelegate.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *bgImgV = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [bgImgV setImage:kGetImage(@"WelcomeBG")];
    [self.view addSubview:bgImgV];
    
    UIImageView *logoImgV = [[UIImageView alloc]initWithImage:kGetImage(@"appLogo")];
    [self.view addSubview:logoImgV];
    [logoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kWidth(66));
        make.centerX.equalTo(self.view);
        make.width.height.mas_offset(kWidth(108));
    }];
    
    UILabel *nameLab = [[UILabel alloc]init];
    nameLab.text = @"无忧达";
    nameLab.textColor = [ColorManager Color555555];
    nameLab.font = kFont(18);
    [self.view addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(logoImgV.mas_bottom).mas_offset(kWidth(5));
    }];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"有我在便送到家";
    titleLab.textColor = [ColorManager Color008A70];
    titleLab.font = kFont(16);
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(nameLab.mas_bottom).mas_offset(kWidth(11));
    }];
    
    UIButton *registerBtn = [[UIButton alloc]init];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    registerBtn.titleLabel.font = kFont(14);
    registerBtn.backgroundColor = [ColorManager MainColor];
    registerBtn.layer.cornerRadius = kWidth(24);
    [registerBtn addTarget:self action:@selector(loginClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.mas_offset(kWidth(-80)-kHeight_SafeArea);
        make.width.mas_offset(kWidth(321));
        make.height.mas_offset(kWidth(48));
    }];
    
    UILabel *bottomLab = [[UILabel alloc]init];
    bottomLab.text = @"已经有账号了？";
    bottomLab.textColor = [ColorManager Color333333];
    bottomLab.font = kFont(16);
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
    
    FJTabBarViewController *VC = [[FJTabBarViewController alloc] init];
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    [window setRootViewController:VC];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"openFirst" object:nil];
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
