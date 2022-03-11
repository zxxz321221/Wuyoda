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
    self.backgroundColor = [ColorManager Color008A70];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"在线客服";
    titleLab.textColor = [ColorManager WhiteColor];
    titleLab.font = kFont(18);
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(12));
        make.top.mas_offset(kWidth(19));
    }];
    
    UILabel *timeLab = [[UILabel alloc]init];
    timeLab.text = @"客服服务时间：9：00-18：00";
    timeLab.textColor = [ColorManager WhiteColor];
    timeLab.font = kFont(14);
    [self addSubview:timeLab];
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(12));
        make.top.mas_offset(kWidth(55));
    }];
    
    UIButton *connectBtn = [[UIButton alloc]init];
    [connectBtn setTitle:@"联系客服" forState:UIControlStateNormal];
    [connectBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    connectBtn.titleLabel.font = kFont(12);
    connectBtn.layer.cornerRadius = kWidth(5);
    connectBtn.layer.borderColor = [ColorManager WhiteColor].CGColor;
    connectBtn.layer.borderWidth = kWidth(1);
    [connectBtn addTarget:self action:@selector(connectServiceClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:connectBtn];
    [connectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(12));
        make.bottom.mas_offset(kWidth(-7));
        make.width.mas_offset(kWidth(70));
        make.height.mas_offset(kWidth(25));
    }];
}

-(void)connectServiceClicked:(id)sender{
    [self showHUDWithText:@"敬请期待" withYOffSet:0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
