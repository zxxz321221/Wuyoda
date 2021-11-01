//
//  AddressListTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/27.
//

#import "AddressListTableViewCell.h"

@interface AddressListTableViewCell ()

@property (nonatomic , retain)UILabel *nameLab;

@property (nonatomic , retain)UILabel *phoneLab;

@property (nonatomic , retain)UILabel *addressLab;

@property (nonatomic , retain)UIButton *editBtn;

@property (nonatomic , retain)UIImageView *defaultImgV;

@property (nonatomic , retain)UIButton *deleteBtn;

@end

@implementation AddressListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    
    return self;
}

-(void)createUI{
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.text = @"张三";
    self.nameLab.textColor = [ColorManager BlackColor];
    self.nameLab.font = kFont(14);
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.mas_offset(kWidth(15));
    }];
    
    self.phoneLab = [[UILabel alloc]init];
    self.phoneLab.text = @"156****1245";
    self.phoneLab.textColor = [ColorManager BlackColor];
    self.phoneLab.font = kFont(14);
    [self.contentView addSubview:self.phoneLab];
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLab.mas_right).mas_offset(kWidth(10));
        make.top.mas_offset(kWidth(15));
    }];
    
    self.addressLab = [[UILabel alloc]init];
    self.addressLab.text = @"辽宁省大连市沙河口区中山路588-24-8";
    self.addressLab.textColor = [ColorManager BlackColor];
    self.addressLab.font = kFont(14);
    [self.contentView addSubview:self.addressLab];
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.right.mas_offset(kWidth(-36));
        make.top.equalTo(self.nameLab.mas_bottom).mas_offset(kWidth(16));
    }];
    
    self.editBtn = [[UIButton alloc]init];
    [self.editBtn setImage:kGetImage(@"编辑地址") forState:UIControlStateNormal];
    [self.editBtn addTarget:self action:@selector(editAddressClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.editBtn];
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-20));
        make.top.mas_offset(kWidth(27));
        make.width.height.mas_offset(kWidth(18));
    }];

    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = [ColorManager ColorF2F2F2];
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.contentView);
        make.top.mas_offset(kWidth(75));
        make.height.mas_offset(kWidth(1));
    }];
    
    self.defaultImgV = [[UIImageView alloc]init];
    self.defaultImgV.image = kGetImage(@"选择");
    [self.contentView addSubview:self.defaultImgV];
    [self.defaultImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.mas_offset(kWidth(87));
        make.width.height.mas_offset(kWidth(18));
    }];
    
    UILabel *defaultLab = [[UILabel alloc]init];
    defaultLab.text = @"默认地址";
    defaultLab.textColor = [ColorManager Color666666];
    defaultLab.font = kFont(14);
    [self.contentView addSubview:defaultLab];
    [defaultLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.defaultImgV.mas_right).mas_offset(kWidth(15));
        make.centerY.equalTo(self.defaultImgV);
    }];
    
    self.deleteBtn = [[UIButton alloc]init];
    [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:[ColorManager Color666666] forState:UIControlStateNormal];
    self.deleteBtn.titleLabel.font = kFont(14);
    [self.contentView addSubview:self.deleteBtn];
    [self.deleteBtn  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-18));
        make.centerY.equalTo(self.defaultImgV);
        make.width.mas_offset(kWidth(30));
        make.height.mas_offset(kWidth(14));
    }];
}

-(void)editAddressClicked:(UIButton *)sender{
    
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
