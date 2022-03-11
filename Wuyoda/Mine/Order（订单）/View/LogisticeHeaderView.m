//
//  LogisticeHeaderView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/14.
//

#import "LogisticeHeaderView.h"

@interface LogisticeHeaderView ()

@property (nonatomic , retain)UIImageView *goodImgV;

@property (nonatomic , retain)UILabel *statusLab;

@property (nonatomic , retain)UIImageView *logisticsImgV;

@property (nonatomic , retain)UILabel *logisticsNumLab;

@property (nonatomic , retain)UIButton *numCopyBtn;

@end

@implementation LogisticeHeaderView

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
    
    UIView *bgV = [[UIView alloc]initWithFrame:CGRectMake(0, kWidth(10), kScreenWidth, kWidth(116))];
    bgV.backgroundColor = [ColorManager WhiteColor];
    [self addSubview:bgV];
    
    self.goodImgV = [[UIImageView alloc]init];
    self.goodImgV.backgroundColor = [ColorManager ColorF2F2F2];
    self.goodImgV.layer.cornerRadius = kWidth(5);
    [bgV addSubview:self.goodImgV];
    [self.goodImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(kWidth(17));
        make.width.height.mas_offset(kWidth(30));
    }];
    
    self.statusLab = [[UILabel alloc]init];
    self.statusLab.text = @"运输中";
    self.statusLab.textColor = [ColorManager Color333333];
    self.statusLab.font = kFont(16);
    [bgV addSubview:self.statusLab];
    [self.statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.goodImgV);
        make.left.equalTo(self.goodImgV.mas_right).mas_offset(kWidth(10));
    }];
    
    self.logisticsImgV = [[UIImageView alloc]init];
    self.logisticsImgV.backgroundColor = [ColorManager ColorF2F2F2];
    self.logisticsImgV.layer.cornerRadius = kWidth(15);
    [bgV addSubview:self.logisticsImgV];
    [self.logisticsImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(17));
        make.top.equalTo(self.goodImgV.mas_bottom).mas_offset(kWidth(20));
        make.width.height.mas_offset(kWidth(30));
    }];
    
    self.logisticsNumLab = [[UILabel alloc]init];
    self.logisticsNumLab.text = @"邮政快递包裹  124578965411";
    self.logisticsNumLab.textColor = [ColorManager Color333333];
    self.logisticsNumLab.font = kFont(14);
    [bgV addSubview:self.logisticsNumLab];
    [self.logisticsNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.logisticsImgV);
        make.left.equalTo(self.logisticsImgV.mas_right).mas_offset(kWidth(10));
    }];
    
    self.numCopyBtn = [[UIButton alloc]init];
    [self.numCopyBtn setTitle:@"复制" forState:UIControlStateNormal];
    [self.numCopyBtn setTitleColor:[ColorManager Color999999] forState:UIControlStateNormal];
    self.numCopyBtn.titleLabel.font = kFont(14);
    [self.numCopyBtn addTarget:self action:@selector(logisticsNumCopyClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bgV addSubview:self.numCopyBtn];
    [self.numCopyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.logisticsImgV);
        make.left.equalTo(self.logisticsNumLab.mas_right).mas_offset(kWidth(20));
        make.width.mas_offset(kWidth(30));
        make.height.mas_offset(kWidth(14));
    }];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = [ColorManager ColorF2F2F2];
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_offset(kWidth(1));
    }];
    
}

-(void)logisticsNumCopyClicked:(UIButton *)sender{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.model.expressCode;
}

-(void)setModel:(LogisticsModel *)model{
    _model = model;
    self.statusLab.text = model.status;
    self.logisticsNumLab.text = [NSString stringWithFormat:@"%@ %@",model.expressType,model.expressCode];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
