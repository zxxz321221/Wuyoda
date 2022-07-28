//
//  ChangePasswordTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/9.
//

#import "ChangePasswordTableViewCell.h"

@implementation ChangePasswordTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    
    return self;
}

-(void)createUI{
    
    self.contentView.backgroundColor = [ColorManager ColorF2F2F2];
    
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(56))];
    self.bgView.backgroundColor = [ColorManager WhiteColor];
    [self.contentView addSubview:self.bgView];
    
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.textColor = [ColorManager BlackColor];
    self.titleLab.font = kFont(14);
    [self.bgView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgView);
        make.left.mas_offset(kWidth(20));
    }];
    
    self.infoTextField = [[UITextField alloc]init];
    self.infoTextField.textColor = [ColorManager Color333333];
    self.infoTextField.font = kFont(14);
    [self.bgView addSubview:self.infoTextField];
    [self.infoTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgView);
        make.left.mas_offset(kWidth(106));
        make.right.mas_offset(kWidth(-70));
        make.height.mas_offset(kWidth(24));
    }];
    
    self.getCodeBtn = [[UIButton alloc]init];
    [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.getCodeBtn setTitleColor:[ColorManager ColorFB9A3A] forState:UIControlStateNormal];
    self.getCodeBtn.titleLabel.font = kFont(14);
    [self.bgView addSubview:self.getCodeBtn];
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgView);
        make.right.mas_offset(kWidth(-20));
        make.width.mas_offset(kWidth(75));
        make.height.mas_offset(kWidth(20));
    }];
    
    self.disAppearBtn = [[UIButton alloc]init];
    [self.disAppearBtn setImage:kGetImage(@"不可见") forState:UIControlStateNormal];
    [self.disAppearBtn setImage:kGetImage(@"可见") forState:UIControlStateSelected];
    [self.bgView addSubview:self.disAppearBtn];
    [self.disAppearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgView);
        make.right.mas_offset(kWidth(-20));
        make.width.height.mas_offset(kWidth(15));
    }];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = [ColorManager ColorF2F2F2];
    self.bottomLine = bottomLine;
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_offset(kWidth(1));
    }];
}

-(void)setIsLast:(BOOL)isLast{
    self.bottomLine.hidden = isLast;
    if (isLast) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bgView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(kWidth(10), kWidth(10))];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame =  self.bgView.bounds;
        maskLayer.path = maskPath.CGPath;
        self.bgView.layer.mask = maskLayer;
        
    }else{
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bgView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(0, 0)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame =  self.bgView.bounds;
        maskLayer.path = maskPath.CGPath;
        self.bgView.layer.mask = maskLayer;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
