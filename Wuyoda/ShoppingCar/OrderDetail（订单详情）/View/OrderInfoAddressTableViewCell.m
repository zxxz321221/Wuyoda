//
//  OrderInfoAddressTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/27.
//

#import "OrderInfoAddressTableViewCell.h"

@interface OrderInfoAddressTableViewCell ()

@property (nonatomic , retain)UILabel *nameLab;

@property (nonatomic , retain)UILabel *phoneLab;

@property (nonatomic , retain)UILabel *addressLab;

@end

@implementation OrderInfoAddressTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    
    return self;
}

-(void)createUI{
    
    UIImageView *addressImgV = [[UIImageView alloc]initWithImage:kGetImage(@"")];
    [self.contentView addSubview:addressImgV];
    [addressImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(12));
        make.top.mas_offset(18);
        make.width.height.mas_offset(kWidth(16));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    //self.nameLab.text = @"张三";
    self.nameLab.textColor = [ColorManager BlackColor];
    self.nameLab.font = kBoldFont(14);
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(35));
        make.centerY.equalTo(addressImgV);
    }];
    
    self.phoneLab = [[UILabel alloc]init];
    //self.phoneLab.text = @"156****1245";
    self.phoneLab.textColor = [ColorManager BlackColor];
    self.phoneLab.font = kBoldFont(14);
    [self.contentView addSubview:self.phoneLab];
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLab.mas_right).mas_offset(kWidth(10));
        make.centerY.equalTo(addressImgV);
    }];
    
    self.addressLab = [[UILabel alloc]init];
    //self.addressLab.text = @"辽宁省大连市沙河口区中山路金玉577-5-2101";
    self.addressLab.textColor = [ColorManager Color555555];
    self.addressLab.font = kFont(12);
    [self.contentView addSubview:self.addressLab];
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(35));
        make.right.mas_offset(kWidth(-36));
        make.top.equalTo(self.nameLab.mas_bottom).mas_offset(kWidth(8));
    }];
    
    
}

-(void)setModel:(OrderListModel *)model{
    self.addressLab.text = model.address;
    self.nameLab.text = model.pay_name;
    self.phoneLab.text = model.mobile;
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
