//
//  OrderAddressTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/26.
//

#import "OrderAddressTableViewCell.h"

@interface OrderAddressTableViewCell ()

@property (nonatomic , retain)UILabel *nameLab;

@property (nonatomic , retain)UIImageView *addressImgV;

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
    
    self.contentView.backgroundColor = [ColorManager ColorF2F2F2];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(kWidth(10), 0, kWidth(355), kWidth(84))];
    bgView.layer.cornerRadius = kWidth(10);
    bgView.backgroundColor = [ColorManager WhiteColor];
    [self.contentView addSubview:bgView];
    

    self.addressImgV = [[UIImageView alloc]initWithImage:kGetImage(@"订单_地址")];
    self.addressImgV.contentMode = UIViewContentModeScaleAspectFit;
    [bgView addSubview:self.addressImgV];
    [self.addressImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(10));
        make.centerY.equalTo(bgView);
        make.width.mas_offset(kWidth(16));
        make.height.mas_offset(kWidth(20));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    //self.nameLab.text = @"张三";
    self.nameLab.textColor = [ColorManager BlackColor];
    self.nameLab.font = kFont(14);
    [bgView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(33));
        make.top.mas_offset(kWidth(20));
    }];
    
    self.phoneLab = [[UILabel alloc]init];
    //self.phoneLab.text = @"156****1245";
    self.phoneLab.textColor = [ColorManager BlackColor];
    self.phoneLab.font = kFont(14);
    [bgView addSubview:self.phoneLab];
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLab.mas_right).mas_offset(kWidth(10));
        make.top.mas_offset(kWidth(20));
    }];
    
    self.addressLab = [[UILabel alloc]init];
    //self.addressLab.text = @"辽宁省大连市沙河口区中山路588-24-8";
    self.addressLab.textColor = [ColorManager BlackColor];
    self.addressLab.font = kFont(14);
    [bgView addSubview:self.addressLab];
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(33));
        make.right.mas_offset(kWidth(-36));
        make.bottom.mas_offset(kWidth(-20));
    }];
    
    UIImageView *arrowImgV = [[UIImageView alloc]initWithImage:kGetImage(@"箭头_浅")];
    arrowImgV.contentMode = UIViewContentModeScaleAspectFit;
    [bgView addSubview:arrowImgV];
    [arrowImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-10));
        make.centerY.equalTo(bgView);
        make.width.height.mas_offset(kWidth(16));
    }];
    
    
}

-(void)setModel:(AddressModel *)model{
    _model = model;
    if (model.uid.length) {
        self.nameLab.text = model.name;
        self.phoneLab.text = model.mobile;
        self.addressLab.text = [NSString stringWithFormat:@"%@%@%@%@%@",model.province,model.city,model.county,model.address,model.zipcode];
        //self.addressImgV.hidden = NO;
    }else{
        self.nameLab.text = @"";
        self.phoneLab.text = @"";
        self.addressLab.text = @"";
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
