//
//  OrderAddressTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/26.
//

#import "OrderAddressTableViewCell.h"

@interface OrderAddressTableViewCell ()

@property (nonatomic , retain)UILabel *nameLab;

@property (nonatomic , retain)UILabel *phoneLab;

@property (nonatomic , retain)UILabel *addressLab;

@end

@implementation OrderAddressTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    
    return self;
}

-(void)createUI{
    
    UIView *topLine = [[UIView alloc]init];
    topLine.backgroundColor = [ColorManager ColorF2F2F2];
    [self.contentView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.equalTo(self.contentView);
        make.height.mas_offset(kWidth(1));
    }];
    UIImageView *addressImgV = [[UIImageView alloc]initWithImage:kGetImage(@"地址")];
    [self.contentView addSubview:addressImgV];
    [addressImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(10));
        make.centerY.equalTo(self.contentView);
        make.width.mas_offset(kWidth(16));
        make.height.mas_offset(kWidth(20));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    //self.nameLab.text = @"张三";
    self.nameLab.textColor = [ColorManager BlackColor];
    self.nameLab.font = kFont(14);
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(43));
        make.top.mas_offset(kWidth(12));
    }];
    
    self.phoneLab = [[UILabel alloc]init];
    //self.phoneLab.text = @"156****1245";
    self.phoneLab.textColor = [ColorManager BlackColor];
    self.phoneLab.font = kFont(14);
    [self.contentView addSubview:self.phoneLab];
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLab.mas_right).mas_offset(kWidth(10));
        make.top.mas_offset(kWidth(12));
    }];
    
    self.addressLab = [[UILabel alloc]init];
    //self.addressLab.text = @"辽宁省大连市沙河口区中山路588-24-8";
    self.addressLab.textColor = [ColorManager BlackColor];
    self.addressLab.font = kFont(14);
    [self.contentView addSubview:self.addressLab];
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(43));
        make.right.mas_offset(kWidth(-36));
        make.bottom.mas_offset(kWidth(-12));
    }];
    
    UIImageView *arrowImgV = [[UIImageView alloc]initWithImage:kGetImage(@"")];
    [self.contentView addSubview:arrowImgV];
    [arrowImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-10));
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_offset(kWidth(16));
    }];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = [ColorManager ColorF2F2F2];
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.width.equalTo(self.contentView);
        make.height.mas_offset(kWidth(1));
    }];
    
}

-(void)setModel:(AddressModel *)model{
    _model = model;
    if (model.uid.length) {
        self.nameLab.text = model.name;
        self.phoneLab.text = model.mobile;
        self.addressLab.text = [NSString stringWithFormat:@"%@%@%@%@%@",model.province,model.city,model.county,model.address,model.zipcode];
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
