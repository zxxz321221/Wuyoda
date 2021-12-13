//
//  SecurityPhoneViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/9.
//

#import "SecurityPhoneViewController.h"
#import "ChangePhoneViewController.h"
#import "ChangeEmailViewController.h"

@interface SecurityPhoneViewController ()

@end

@implementation SecurityPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"手机号"];
    [self.view addSubview:nav];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"当前绑定手机号";
    titleLab.textColor = [ColorManager Color333333];
    titleLab.font = kFont(14);
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(nav.mas_bottom).mas_offset(kWidth(48));
    }];
    
    UILabel *phoneLab = [[UILabel alloc]init];
    phoneLab.text = @"183****9031";
    phoneLab.textColor = [ColorManager Color333333];
    phoneLab.font = kBoldFont(18);
    [self.view addSubview:phoneLab];
    [phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(titleLab.mas_bottom).mas_offset(kWidth(18));
    }];
    
    UIButton *changeBtn = [[UIButton alloc]init];
    [changeBtn setTitle:@"修改手机号" forState:UIControlStateNormal];
    [changeBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    changeBtn.titleLabel.font = kFont(14);
    changeBtn.backgroundColor = [ColorManager MainColor];
    changeBtn.layer.cornerRadius = kWidth(24);
    [changeBtn addTarget:self action:@selector(changePhoneClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeBtn];
    [changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(phoneLab.mas_bottom).mas_offset(kWidth(50));
        make.width.mas_offset(kWidth(321));
        make.height.mas_offset(kWidth(48));
    }];
    
    UIButton *backBtn = [[UIButton alloc]init];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
    backBtn.titleLabel.font = kFont(14);
    backBtn.backgroundColor = [ColorManager ColorD7D7D7];
    backBtn.layer.cornerRadius = kWidth(24);
    [backBtn addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(changeBtn.mas_bottom).mas_offset(kWidth(10));
        make.width.mas_offset(kWidth(321));
        make.height.mas_offset(kWidth(48));
    }];
    
    if ([self.type isEqualToString:@"2"]) {
        [nav changeTitle:@"邮箱"];
        titleLab.text = @"当前绑定邮箱";
        phoneLab.text = @"1244247@qq.com";
        [changeBtn setTitle:@"修改邮箱" forState:UIControlStateNormal];
    }
}

-(void)changePhoneClicked{
    if ([self.type isEqualToString:@"1"]) {
        ChangePhoneViewController *vc = [[ChangePhoneViewController alloc]init];
        vc.type = @"1";
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        ChangeEmailViewController *vc = [[ChangeEmailViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

-(void)backClicked{
    [self.navigationController popViewControllerAnimated:YES];
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
