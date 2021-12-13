//
//  ChangeOrderAddressTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/12.
//

#import "ChangeOrderAddressTableViewCell.h"

@interface ChangeOrderAddressTableViewCell ()

@property (nonatomic , retain)UILabel *nameLab;

@property (nonatomic , retain)UILabel *phoneLab;

@property (nonatomic , retain)UILabel *addressLab;

@property (nonatomic , retain)UIImageView *selectImgV;

@end

@implementation ChangeOrderAddressTableViewCell

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
        make.left.equalTo(self.nameLab.mas_right).mas_offset(kWidth(5));
        make.top.mas_offset(kWidth(15));
    }];
    
    self.addressLab = [[UILabel alloc]init];
    self.addressLab.text = @"辽宁省大连市沙河口区中山路588-24-8";
    self.addressLab.textColor = [ColorManager BlackColor];
    self.addressLab.font = kFont(14);
    [self.contentView addSubview:self.addressLab];
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.right.mas_offset(kWidth(-35));
        make.bottom.mas_offset(kWidth(-15));
    }];
    
    self.selectImgV = [[UIImageView alloc]initWithImage:kGetImage(@"选择")];
    [self.contentView addSubview:self.selectImgV];
    [self.selectImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-12));
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_offset(kWidth(18));
    }];
}

-(void)setModel:(AddressModel *)model{
    _model = model;
    self.addressLab.text = model.address;
    self.nameLab.text = model.name;
    self.phoneLab.text = model.mobile;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        [self.selectImgV setImage:kGetImage(@"选中")];
    }else{
        [self.selectImgV setImage:kGetImage(@"选择")];
    }
    // Configure the view for the selected state
}

@end
