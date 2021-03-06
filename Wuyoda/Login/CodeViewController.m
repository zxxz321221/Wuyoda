//
//  CodeViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/10.
//

#import "CodeViewController.h"
#import "VerCodeView.h"
#import "ChangePassWordViewController.h"

@interface CodeViewController ()

@property (nonatomic, strong)VerCodeView *vercodeView;
@property (nonatomic, copy)NSString *vercode;

@property (nonatomic, strong)UIButton *sendCodeBtn;

@end

@implementation CodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@""];
    [self.view addSubview:nav];
    
    UILabel *titleLab = [[UILabel  alloc]init];
    titleLab.text = @"请输入6位验证码";
    titleLab.textColor = [ColorManager BlackColor];
    titleLab.font = kFont(28);
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.equalTo(nav.mas_bottom).mas_offset(kWidth(35));
    }];
    
    UILabel *tipLab = [[UILabel alloc]init];
    tipLab.text = [NSString stringWithFormat:@"验证码已发送至%@",self.phone];
    tipLab.textColor = [ColorManager Color7F7F7F];
    tipLab.font = kFont(16);
    [self.view addSubview:tipLab];
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.equalTo(titleLab.mas_bottom).mas_offset(kWidth(8));
    }];
    
    UILabel *codeLab = [[UILabel alloc]init];
    codeLab.text = @"6位验证码";
    codeLab.textColor = [ColorManager BlackColor];
    codeLab.font = kFont(14);
    [self.view addSubview:codeLab];
    [codeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.equalTo(tipLab.mas_bottom).mas_offset(kWidth(90));
    }];
    
//    self.phoneField = [[UITextField alloc]init];
//    self.phoneField.textColor = [ColorManager BlackColor];
//    self.phoneField.font = kFont(14);
//    self.phoneField.placeholder = @"请输入手机号码";
//    [self.view addSubview:self.phoneField];
//    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(kWidth(20));
//        make.centerY.height.equalTo(phoneTypeLab);
//        make.right.mas_offset(kWidth(-20));
//    }];
//
//    UIView *lineV = [[UIView alloc]init];
//    lineV.backgroundColor = [ColorManager ColorF7F7F7];
//    [self.view addSubview:lineV];
//    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(phoneTypeLab.mas_bottom).mas_offset(kWidth(5));
//        make.left.mas_offset(kWidth(20));
//        make.right.mas_offset(kWidth(-20));
//        make.height.mas_offset(kWidth(1));
//    }];
    
    self.vercodeView = [[VerCodeView alloc]init];
    [self.view addSubview:self.vercodeView];
    [self.vercodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.width.mas_offset(kWidth(335));
        make.top.equalTo(codeLab.mas_bottom).mas_offset(kWidth(10));
        make.height.mas_offset(kWidth(48));
    }];
    [self.vercodeView layoutIfNeeded];
    __weak __typeof(self)weakSelf = self;
    self.vercodeView.textBlock = ^(NSString *str) {//返回的内容
        weakSelf.vercode = str;
//        if (str.length>=6) {
//            weakSelf.nextBtn.backgroundColor = [ColorManager Colorgreen3EB034];
//            [weakSelf.nextBtn setTitleColor: [ColorManager WhiteColor] forState:(UIControlStateNormal)];
//            weakSelf.nextBtn.userInteractionEnabled = YES;
//        }else{
//            weakSelf.nextBtn.backgroundColor = [ColorManager ColorGrayD6];
//            [weakSelf.nextBtn setTitleColor:[ColorManager ColorDarkText28] forState:(UIControlStateNormal)];
//            weakSelf.nextBtn.userInteractionEnabled = NO;
//        }
        
    };
    self.vercodeView.showType = passShow5;//五种样式
    self.vercodeView.num = 6;//框框个数
    self.vercodeView.tintColor = [ColorManager ColorF7F7F7];//主题色
    self.vercodeView.textColor = [ColorManager BlackColor];
    [self.vercodeView show];
    [self.vercodeView.textF becomeFirstResponder];
    
    self.sendCodeBtn = [[UIButton alloc]init];
    [self.sendCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
    [self.sendCodeBtn setTitleColor:[ColorManager Color666666] forState:UIControlStateNormal];
    self.sendCodeBtn.titleLabel.font = kFont(14);
    [self.sendCodeBtn addTarget:self action:@selector(sendCodeClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.sendCodeBtn.userInteractionEnabled = NO;
    [self.view addSubview:self.sendCodeBtn];
    [self.sendCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.equalTo(self.vercodeView.mas_bottom).mas_offset(kWidth(10));
        make.width.mas_offset(kWidth(115));
        make.height.mas_offset(kWidth(22));
    }];
    
    UIButton *loginBtn = [[UIButton alloc]init];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = kFont(14);
    loginBtn.backgroundColor = [ColorManager MainColor];
    loginBtn.layer.cornerRadius = kWidth(5);
    [loginBtn addTarget:self action:@selector(loginClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sendCodeBtn.mas_bottom).mas_offset(kWidth(24));
        make.left.mas_offset(kWidth(20));
        make.right.mas_offset(kWidth(-20));
        make.height.mas_offset(kWidth(42));
    }];
    [self startTime];
}

-(void)sendCodeClicked:(UIButton *)sender{
    
    NSDictionary *dic = @{@"phone":self.phone,@"prefix":@"86",@"api_token":[RegisterModel getUserInfoModel].user_token};
    
    [FJNetTool postWithParams:dic url:Login_sendVerify loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            [self startTime];
            [self.view showHUDWithText:@"发送验证码成功" withYOffSet:0];
        }else{
            [self.view showHUDWithText:baseModel.msg withYOffSet:0];
        }
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)loginClicked:(UIButton *)sender{
    if (self.vercodeView.textF.text.length >= 6) {
        
        NSDictionary *dic = @{@"code":self.vercodeView.textF.text,@"phone":self.phone,@"api_token":[RegisterModel getUserInfoModel].user_token};
        
        [FJNetTool postWithParams:dic url:Login_phone_check loading:YES success:^(id responseObject) {
            BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
            if ([baseModel.code isEqualToString:CODE0]) {
                UserInfoModel *userModel = [UserInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
                
                RegisterModel *registerModel = [RegisterModel getUserInfoModel];
                registerModel.user_id = userModel.member_id;
                registerModel.user_token = userModel.token;
                [RegisterModel saveUserInfoModel:registerModel];
                if (!userModel.member_pass.length) {
                    ChangePassWordViewController *vc = [[ChangePassWordViewController alloc]init];
                    vc.userInfo = userModel;
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    [LoginUsersModel saveLoginUsers:userModel];
                    [UserInfoModel saveUserInfoModel:userModel];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"messageLogin" object:nil];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
                
            }else{
                [self.view showHUDWithText:baseModel.msg withYOffSet:0];
            }
        } failure:^(NSError *error) {
            
        }];
        
    }
}

-(void)startTime{
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置（倒计时结束后调用）
                [self.sendCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                //设置不可点击
                self.sendCodeBtn.userInteractionEnabled = YES;
                
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.sendCodeBtn setTitle:[NSString stringWithFormat:@"重新发送(%@s)",strTime] forState:UIControlStateNormal];
                //设置可点击
                self.sendCodeBtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    
    dispatch_resume(_timer);
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
