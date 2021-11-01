//
//  MineHeaderView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/28.
//

#import "MineHeaderView.h"
#import "UserInfoViewController.h"

@interface MineHeaderView ()

@property (nonatomic , retain)UILabel *nameLab;

@property (nonatomic , retain)UILabel *signLab;

@property (nonatomic , retain)UIImageView *iconImgV;

@property (nonatomic , retain)UIButton *infoBtn;

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
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.text = @"Wuyoda用户";
    self.nameLab.textColor = [ColorManager BlackColor];
    self.nameLab.font = kFont(28);
    [self addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.mas_offset(kWidth(26));
    }];
    
    self.signLab = [[UILabel alloc]init];
    self.signLab.text = @"今天是Wuyoda陪伴你的第361天";
    self.signLab.textColor = [ColorManager Color7F7F7F];
    self.signLab.font = kFont(16);
    [self addSubview:self.signLab];
    [self.signLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLab);
        make.top.equalTo(self.nameLab.mas_bottom).mas_offset(kWidth(10));
    }];
    
    self.iconImgV = [[UIImageView alloc]init];
    self.iconImgV.backgroundColor = [ColorManager RandomColor];
    self.iconImgV.layer.cornerRadius = kWidth(28);
    self.iconImgV.layer.masksToBounds = YES;
    [self.iconImgV setImage:kGetImage(@"normal_icon")];
    [self addSubview:self.iconImgV];
    [self.iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-20));
        make.top.mas_offset(kWidth(26));
        make.width.height.mas_offset(kWidth(56));
    }];
    
    self.infoBtn = [[UIButton alloc]init];
    [self.infoBtn setTitle:@"查看并编辑个人资料" forState:UIControlStateNormal];
    [self.infoBtn setTitleColor:[ColorManager MainColor] forState:UIControlStateNormal];
    self.infoBtn.titleLabel.font = kFont(14);
    [self.infoBtn addTarget:self action:@selector(toUserInfoVCClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.infoBtn];
    [self.infoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.bottom.mas_offset(kWidth(-24));
        make.width.mas_offset(kWidth(130));
        make.height.mas_offset(kWidth(20));
    }];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = [ColorManager ColorF2F2F2];
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.equalTo(self);
        make.width.mas_offset(kWidth(335));
        make.height.mas_offset(kWidth(1));
    }];
}

-(void)toUserInfoVCClicked{
    UserInfoViewController *vc = [[UserInfoViewController alloc]init];
    [self.CurrentViewController.navigationController pushViewController:vc animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
