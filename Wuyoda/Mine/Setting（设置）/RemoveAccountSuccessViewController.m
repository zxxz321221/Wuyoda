//
//  RemoveAccountSuccessViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2022/3/8.
//

#import "RemoveAccountSuccessViewController.h"

@interface RemoveAccountSuccessViewController ()

@end

@implementation RemoveAccountSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"账号注销"];
    [self.view addSubview:nav];
    
    UIImageView *successImgV = [[UIImageView alloc]initWithImage:kGetImage(@"选中")];
    [self.view addSubview:successImgV];
    [successImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_offset(kWidth(70)+kHeight_NavBar);
        make.width.height.mas_offset(kWidth(64));
    }];
    
    UILabel *msgLab = [[UILabel alloc]init];
    msgLab.text = @"您的账号注销申请提交成功！";
    msgLab.textColor = [ColorManager BlackColor];
    msgLab.font = kBoldFont(20);
    [self.view addSubview:msgLab];
    [msgLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(successImgV.mas_bottom).mas_offset(kWidth(35));
    }];
    
    UILabel *tipLab = [[UILabel alloc]init];
    tipLab.text = @"人工审核需要2-7天，联系人工客服";
    tipLab.textColor = [ColorManager Color666666];
    tipLab.font = kFont(14);
    [self.view addSubview:tipLab];
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(msgLab.mas_bottom).mas_offset(kWidth(15));
    }];
    
    UIButton *cancelBtn = [[UIButton alloc]init];
    [cancelBtn setTitle:@"撤销注销" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelBtn.layer.cornerRadius = kWidth(25);
    cancelBtn.backgroundColor = [ColorManager MainColor];
    [cancelBtn addTarget:self action:@selector(cancelRemoveClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.mas_offset(-kHeight_SafeArea);
        make.width.mas_offset(kScreenWidth-kWidth(30));
        make.height.mas_offset(kWidth(50));
    }];
}

-(void)cancelRemoveClicked:(id)sender{
    
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
