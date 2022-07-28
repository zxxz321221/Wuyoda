//
//  HelperHeaderView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/14.
//

#import "HelperHeaderView.h"

@implementation HelperHeaderView

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
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(kWidth(10), kWidth(10), kWidth(355), kWidth(127))];
    bgView.backgroundColor = [ColorManager WhiteColor];
    bgView.layer.cornerRadius = kWidth(10);
    [self addSubview:bgView];
    
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"在线客服";
    titleLab.textColor = [ColorManager BlackColor];
    titleLab.font = kFont(18);
    [bgView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(10));
        make.top.mas_offset(kWidth(19));
    }];
    
    UILabel *timeLab = [[UILabel alloc]init];
    timeLab.text = @"客服服务时间：9：00-18：00";
    timeLab.textColor = [ColorManager BlackColor];
    timeLab.font = kFont(14);
    [bgView addSubview:timeLab];
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(10));
        make.top.mas_offset(kWidth(48));
    }];
    
    UIButton *connectBtn = [[UIButton alloc]init];
    [connectBtn setTitle:@"联系客服" forState:UIControlStateNormal];
    [connectBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
    connectBtn.titleLabel.font = kFont(12);
    connectBtn.layer.cornerRadius = kWidth(3);
    connectBtn.layer.borderColor = [ColorManager Color666666].CGColor;
    connectBtn.layer.borderWidth = kWidth(1);
    [connectBtn addTarget:self action:@selector(connectServiceClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:connectBtn];
    [connectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(10));
        make.bottom.mas_offset(kWidth(-20));
        make.width.mas_offset(kWidth(70));
        make.height.mas_offset(kWidth(25));
    }];
    
//    UILabel *mailLab = [[UILabel alloc]init];
//    mailLab.text = @"联系客服：wyd001@24shipping.com";
//    mailLab.textColor = [ColorManager WhiteColor];
//    mailLab.font = kFont(12);
//    [self addSubview: mailLab];
//    [mailLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(kWidth(12));
//        make.bottom.mas_offset(kWidth(-10));
//    }];
}

-(void)connectServiceClicked:(id)sender{
    FJWebViewController *vc = [[FJWebViewController alloc]init];
    vc.url = @"http://new.wuyoda.com/public/help/wuyoda_help.html";
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
