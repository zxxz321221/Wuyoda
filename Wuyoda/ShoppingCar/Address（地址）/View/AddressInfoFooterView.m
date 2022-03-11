//
//  AddressInfoFooterView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/27.
//

#import "AddressInfoFooterView.h"

@implementation AddressInfoFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"上传身份证正反面";
    titleLab.textColor = [ColorManager Color666666];
    titleLab.font = kFont(14);
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(kWidth(15));
    }];
    
    UILabel * tipLab = [[UILabel alloc]init];
    tipLab.text = @"温馨提示：请上传原始比例的身份证正反面，请勿剪裁涂改，保证身份信息清晰显示，否则无法通过审核";
    tipLab.textColor = [ColorManager Color999999];
    tipLab.font = kFont(12);
    tipLab.numberOfLines = 0;
    tipLab.lineBreakMode = NSLineBreakByCharWrapping;
    [self addSubview:tipLab];
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(15));
        make.right.mas_offset(kWidth(-15));
        make.top.equalTo(titleLab.mas_bottom).mas_offset(kWidth(11));
    }];
    
    self.identifierimgV1 = [[UIImageView alloc]initWithImage:kGetImage(@"上传身份证正面")];
    [self addSubview:self.identifierimgV1];
    [self.identifierimgV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(24));
        make.top.equalTo(tipLab.mas_bottom).mas_offset(kWidth(17));
        make.width.mas_offset(kWidth(145));
        make.height.mas_offset(kWidth(86));
    }];
    
    self.identifierBtn1 = [[UIButton alloc]init];
    //[self.identifierBtn1 setImage:kGetImage(@"上传身份证正面") forState:UIControlStateNormal];
    [self addSubview:self.identifierBtn1];
    [self.identifierBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(24));
        make.top.equalTo(tipLab.mas_bottom).mas_offset(kWidth(17));
        make.width.mas_offset(kWidth(145));
        make.height.mas_offset(kWidth(86));
    }];
    
    self.identifierimgV2 = [[UIImageView alloc]initWithImage:kGetImage(@"上传身份证反面")];
    [self addSubview:self.identifierimgV2];
    [self.identifierimgV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-24));
        make.top.equalTo(tipLab.mas_bottom).mas_offset(kWidth(17));
        make.width.mas_offset(kWidth(145));
        make.height.mas_offset(kWidth(86));
    }];
    
    self.identifierBtn2 = [[UIButton alloc]init];
    [self addSubview:self.identifierBtn2];
    [self.identifierBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-24));
        make.top.equalTo(tipLab.mas_bottom).mas_offset(kWidth(17));
        make.width.mas_offset(kWidth(145));
        make.height.mas_offset(kWidth(86));
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
