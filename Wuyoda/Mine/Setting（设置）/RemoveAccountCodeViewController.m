//
//  RemoveAccountCodeViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2022/3/8.
//

#import "RemoveAccountCodeViewController.h"
#import "RemoveAccountSuccessViewController.h"

@interface RemoveAccountCodeViewController ()

@property (nonatomic , retain)UITextField *phoneField;

@property (nonatomic , retain)UITextField *codeField;

@property (nonatomic , retain)UIButton *sendCodeBtn;

@end

@implementation RemoveAccountCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"确认注销"];
    [self.view addSubview:nav];
    
    UILabel *tipLab = [[UILabel alloc]init];
    tipLab.text = @"为了方便您跟进注销进度，请留下有效联系方式";
    tipLab.textColor = [UIColor blackColor];
    tipLab.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:tipLab];
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(10));
        make.top.mas_offset(kWidth(15)+kHeight_NavBar);
    }];
    
    self.phoneField = [[UITextField alloc]init];
    self.phoneField.placeholder = @"请输入手机号";
    self.phoneField.textColor = [UIColor blackColor];
    self.phoneField.text = [self.phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    [self.phoneField setEnabled:NO];
    [self.view addSubview:self.phoneField];
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(10));
        make.right.mas_offset(kWidth(-10));
        make.top.equalTo(tipLab.mas_bottom).mas_offset(kWidth(30));
        make.height.mas_offset(kWidth(25));
    }];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [ColorManager ColorF2F2F2];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.phoneField.mas_bottom).mas_offset(kWidth(15));
        make.height.mas_offset(kWidth(1));
    }];
    
    self.codeField = [[UITextField alloc]init];
    self.codeField.placeholder = @"请输入短信验证码";
    self.codeField.textColor = [UIColor blackColor];
    [self.view addSubview:self.codeField];
    [self.codeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(10));
        make.right.mas_offset(kWidth(-100));
        make.top.equalTo(line1.mas_bottom).mas_offset(kWidth(30));
        make.height.mas_offset(kWidth(25));
    }];
    
    self.sendCodeBtn = [[UIButton alloc]init];
    [self.sendCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [self.sendCodeBtn setTitleColor:[ColorManager Color999999] forState:UIControlStateNormal];
    self.sendCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.sendCodeBtn.backgroundColor = [ColorManager ColorF2F2F2];
    self.sendCodeBtn.layer.cornerRadius = kWidth(15);
    [self.sendCodeBtn addTarget:self action:@selector(senderCodeClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sendCodeBtn];
    [self.sendCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.codeField);
        make.right.mas_offset(kWidth(-15));
        make.width.mas_offset(kWidth(95));
        make.height.mas_offset(kWidth(30));
    }];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [ColorManager ColorF2F2F2];
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.codeField.mas_bottom).mas_offset(kWidth(15));
        make.height.mas_offset(kWidth(1));
    }];
    
    UIButton *logoffBtn = [[UIButton alloc]init];
    [logoffBtn setTitle:@"确认注销" forState:UIControlStateNormal];
    [logoffBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    logoffBtn.layer.cornerRadius = kWidth(25);
    logoffBtn.backgroundColor = [ColorManager MainColor];
    [logoffBtn addTarget:self action:@selector(logoffClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoffBtn];
    [logoffBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(line2).mas_offset(kWidth(30));
        make.width.mas_offset(kWidth(345));
        make.height.mas_offset(kWidth(50));
    }];
}

-(void)senderCodeClicked:(UIButton *)sender{
    
    [self startTime];
}

-(void)logoffClicked:(UIButton *)sender{
    if (!self.codeField.text.length) {
        return;
    }
    
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    
//    [GZMrequest postWithURLString:[GZMUrl get_accountCancelDone_url] parameters:@{@"customer":userInfo[@"member_id"],@"check":self.codeField.text} success:^(NSDictionary *data) {
//        if ([data[@"code"] isEqualToString:@"success"]) {
//            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userInfo"];
//            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"login"];
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"userLogoffDone" object:nil];
//            [self.navigationController popToRootViewControllerAnimated:YES];
//        }
//        
//            
//    } failure:^(NSError *error) {
//            
//    }];
    
    RemoveAccountSuccessViewController *vc = [[RemoveAccountSuccessViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
