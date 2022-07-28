//
//  LogisticeHeaderView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/14.
//

#import "LogisticeHeaderView.h"
#import "LogisticsStateMessageHandle.h"

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
    
    UIView *bgV = [[UIView alloc]init];
    bgV.backgroundColor = [ColorManager WhiteColor];
    [self addSubview:bgV];
    [bgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.equalTo(self);
        make.bottom.mas_offset(kWidth(-10));
    }];
    
    self.goodImgV = [[UIImageView alloc]init];
    self.goodImgV.backgroundColor = [ColorManager ColorF2F2F2];
    self.goodImgV.layer.cornerRadius = kWidth(5);
    self.goodImgV.layer.masksToBounds = YES;
    self.goodImgV.contentMode = UIViewContentModeScaleAspectFit;
    self.goodImgV.hidden = YES;
    [bgV addSubview:self.goodImgV];
    [self.goodImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.mas_offset(kWidth(20));
        make.width.height.mas_offset(kWidth(70));
    }];
    
    self.statusLab = [[UILabel alloc]init];
    //self.statusLab.text = @"运输中";
    self.statusLab.textColor = [ColorManager ColorFB9A3A];
    self.statusLab.font = kFont(16);
    self.statusLab.numberOfLines = 0;
    self.statusLab.lineBreakMode = NSLineBreakByCharWrapping;
    [bgV addSubview:self.statusLab];
    [self.statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodImgV).mas_offset(kWidth(6));
        make.left.equalTo(self.goodImgV.mas_right).mas_offset(kWidth(10));
        make.width.mas_offset(kWidth(255));
    }];
    
//    self.logisticsImgV = [[UIImageView alloc]init];
//    self.logisticsImgV.backgroundColor = [ColorManager ColorF2F2F2];
//    self.logisticsImgV.layer.cornerRadius = kWidth(15);
//    [bgV addSubview:self.logisticsImgV];
//    [self.logisticsImgV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(kWidth(17));
//        make.top.equalTo(self.statusLab.mas_bottom).mas_offset(kWidth(25));
//        make.width.height.mas_offset(kWidth(30));
//    }];
//
    self.logisticsNumLab = [[UILabel alloc]init];
    //self.logisticsNumLab.text = @"邮政快递包裹  124578965411";
    self.logisticsNumLab.textColor = [ColorManager Color333333];
    self.logisticsNumLab.font = kFont(14);
    [bgV addSubview:self.logisticsNumLab];
    [self.logisticsNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.statusLab.mas_bottom).mas_offset(kWidth(20));
        make.left.equalTo(self.goodImgV.mas_right).mas_offset(kWidth(10));
    }];
    
    self.numCopyBtn = [[UIButton alloc]init];
    [self.numCopyBtn setTitle:@"复制" forState:UIControlStateNormal];
    [self.numCopyBtn setTitleColor:[ColorManager Color999999] forState:UIControlStateNormal];
    self.numCopyBtn.titleLabel.font = kFont(14);
    [self.numCopyBtn addTarget:self action:@selector(logisticsNumCopyClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.numCopyBtn.hidden = YES;
    [bgV addSubview:self.numCopyBtn];
    [self.numCopyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.logisticsNumLab);
        make.left.equalTo(self.logisticsNumLab.mas_right).mas_offset(kWidth(20));
        make.width.mas_offset(kWidth(30));
        make.height.mas_offset(kWidth(14));
    }];
    
}

-(void)logisticsNumCopyClicked:(UIButton *)sender{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    //pasteboard.string = self.model.expressCode;
    if ([self.expressType isEqualToString:@"2"]) {
        pasteboard.string = self.model2.nu;
    }else{
        pasteboard.string = self.model.expressCode;
    }
    
}

-(void)setModel:(LogisticsModel *)model{
    _model = model;
    self.statusLab.text = model.status;
    self.logisticsNumLab.text = [NSString stringWithFormat:@"%@ %@",model.expressType,model.expressCode];
    [self.goodImgV sd_setImageWithURL:[NSURL URLWithString:model.file]];
    self.numCopyBtn.hidden = NO;
    self.goodImgV.hidden = NO;
}

-(void)setModel2:(LogisticsNewModel *)model2{
    _model2 = model2;
    self.statusLab.text = [LogisticsStateMessageHandle getStateMessage:model2.state];
    
    self.logisticsNumLab.text = [NSString stringWithFormat:@"邮政快递 %@",model2.nu];
    [self.goodImgV sd_setImageWithURL:[NSURL URLWithString:model2.file]];
    self.numCopyBtn.hidden = NO;
    self.goodImgV.hidden = NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
