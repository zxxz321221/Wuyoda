//
//  MineHeaderView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/28.
//

#import "MineHeaderView.h"
#import "UserInfoViewController.h"
#import "SettingViewController.h"

@interface MineHeaderView ()

@property (nonatomic , retain)UIButton *loginBtn;

@property (nonatomic , retain)UIButton *infoBtn;

@property (nonatomic , retain)UIButton *settingBtn;

@end

@implementation MineHeaderView

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
    
    self.iconImgV = [[UIImageView alloc]init];
    self.iconImgV.backgroundColor = [ColorManager ColorE2E2E2];
    self.iconImgV.layer.cornerRadius = kWidth(35);
    self.iconImgV.layer.masksToBounds = YES;
    [self addSubview:self.iconImgV];
    [self.iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.mas_offset(kWidth(26));
        make.width.height.mas_offset(kWidth(70));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.text = @"Wuyoda用户";
    self.nameLab.textColor = [ColorManager BlackColor];
    self.nameLab.font = kFont(20);
    [self addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(110));
        make.top.mas_offset(kWidth(26));
    }];
    
    self.signLab = [[UILabel alloc]init];
    self.signLab.text = @"今天是Wuyoda陪伴你的第0天";
    self.signLab.textColor = [ColorManager Color7F7F7F];
    self.signLab.font = kFont(14);
    [self addSubview:self.signLab];
    [self.signLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLab);
        make.centerY.equalTo(self.iconImgV);
    }];
    
    
    
    self.infoBtn = [[UIButton alloc]init];
    [self.infoBtn setTitle:@"查看并编辑个人资料" forState:UIControlStateNormal];
    [self.infoBtn setTitleColor:[ColorManager ColorFA8B18] forState:UIControlStateNormal];
    self.infoBtn.titleLabel.font = kFont(14);
    [self.infoBtn addTarget:self action:@selector(toUserInfoVCClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.infoBtn];
    [self.infoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLab);
        make.bottom.equalTo(self.iconImgV);
        make.width.mas_offset(kWidth(130));
        make.height.mas_offset(kWidth(15));
    }];
    
    self.settingBtn = [[UIButton alloc]init];
    [self.settingBtn setImage:kGetImage(@"设置") forState:UIControlStateNormal];
    [self.settingBtn addTarget:self action:@selector(settingClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.settingBtn];
    [self.settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-20));
        make.top.equalTo(self.iconImgV);
        make.width.height.mas_offset(kWidth(20));

    }];
    
    self.loginBtn = [[UIButton alloc]init];
    [self.loginBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[ColorManager MainColor] forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = kFont(14);
    self.loginBtn.layer.cornerRadius = kWidth(13);
    self.loginBtn.layer.borderColor = [ColorManager MainColor].CGColor;
    self.loginBtn.layer.borderWidth = kWidth(0.5);
    [self.loginBtn addTarget:self action:@selector(loginClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLab);
        make.top.equalTo(self.nameLab.mas_bottom).mas_offset(kWidth(15));
        make.width.mas_offset(kWidth(80));
        make.height.mas_offset(kWidth(26));
    }];
    
}

-(void)toUserInfoVCClicked{
    UserInfoViewController *vc = [[UserInfoViewController alloc]init];
    [self.CurrentViewController.navigationController pushViewController:vc animated:YES];
}

-(void)loginClicked{
    [CommonManager isLogin:self.CurrentViewController isPush:YES];
}

-(void)settingClicked{
    SettingViewController *vc = [[SettingViewController alloc]init];
    [self.CurrentViewController.navigationController pushViewController:vc animated:YES];
}

-(void)setIsLogin:(BOOL)isLogin{
    if (isLogin) {
        self.infoBtn.hidden = NO;
        self.signLab.hidden = NO;
        self.settingBtn.hidden = NO;
        self.loginBtn.hidden = YES;
    }else{
        self.loginBtn.hidden = NO;
        self.signLab.hidden = YES;
        self.infoBtn.hidden = YES;
        self.settingBtn.hidden = YES;
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
