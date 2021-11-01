//
//  BankCardListTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/29.
//

#import "BankCardListTableViewCell.h"

@interface BankCardListTableViewCell ()

@property (nonatomic , retain)UILabel *nameLab;

@property (nonatomic , retain)UILabel *typeLab;

@property (nonatomic , retain)UILabel *numberLab;

@property (nonatomic , retain)UILabel *defaultLab;

@property (nonatomic , retain)UIImageView *selectImgV;

@end

@implementation BankCardListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    
    return self;
}

-(void)createUI{
    self.backgroundColor = [UIColor clearColor];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(kWidth(23), 0, kWidth(330), kWidth(90))];
    bgView.backgroundColor = [ColorManager WhiteColor];
    bgView.layer.cornerRadius = kWidth(5);
    [self.contentView addSubview:bgView];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.text = @"工商银行";
    self.nameLab.textColor = [ColorManager Color333333];
    self.nameLab.font = kFont(14);
    [bgView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(11));
        make.top.mas_offset(kWidth(15));
    }];
    
    self.typeLab = [[UILabel alloc]init];
    self.typeLab.text = @"主卡";
    self.typeLab.textColor = [ColorManager Color333333];
    self.typeLab.font = kFont(14);
    [bgView addSubview:self.typeLab];
    [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLab.mas_right).mas_offset(kWidth(20));
        make.top.mas_offset(kWidth(15));
    }];
    
    self.defaultLab = [[UILabel alloc]init];
    self.defaultLab.text = @"默认";
    self.defaultLab.textColor = [ColorManager Color008A70];
    self.defaultLab.font = kFont(12);
    [bgView addSubview:self.defaultLab];
    [self.defaultLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-8));
        make.top.mas_offset(kWidth(10));
    }];
    
    self.numberLab = [[UILabel alloc]init];
    self.numberLab.text = @"**** ******** 6788";
    self.numberLab.textColor = [ColorManager Color333333];
    self.numberLab.font = kFont(14);
    [bgView addSubview:self.numberLab];
    [self.numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(11));
        make.bottom.mas_offset(kWidth(-15));
    }];
    
    self.selectImgV = [[UIImageView alloc]initWithImage:kGetImage(@"选择")];
    [bgView addSubview:self.selectImgV];
    [self.selectImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-10));
        make.centerY.equalTo(self.numberLab);
        make.width.height.mas_offset(kWidth(16));
    }];
}

-(void)setIsEdit:(BOOL)isEdit{
    _isEdit = isEdit;
    if (isEdit) {
        self.selectImgV.hidden = NO;
    }else{
        self.selectImgV.hidden = YES;
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
