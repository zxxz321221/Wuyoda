//
//  OrderInfoAddressTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/27.
//

#import "OrderInfoAddressTableViewCell.h"

@interface OrderInfoAddressTableViewCell ()

@property (nonatomic , retain)UIImageView *addressImgV;

@property (nonatomic , retain)UILabel *nameLab;

@property (nonatomic , retain)UILabel *phoneLab;

@property (nonatomic , retain)UILabel *addressLab;

@property (nonatomic , retain)UIImageView *arrowImgV;

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
    
    self.contentView.backgroundColor = [ColorManager ColorF2F2F2];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(kWidth(10), 0, kWidth(355), kWidth(84))];
    bgView.backgroundColor = [ColorManager WhiteColor];
    [self.contentView addSubview:bgView];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(kWidth(10), kWidth(10))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame =  bgView.bounds;
    maskLayer.path = maskPath.CGPath;
    bgView.layer.mask = maskLayer;
    
    self.addressImgV = [[UIImageView alloc]initWithImage:kGetImage(@"订单_地址")];
    self.addressImgV.contentMode = UIViewContentModeScaleAspectFit;
    self.addressImgV.contentMode = UIViewContentModeScaleAspectFit;
    [bgView addSubview:self.addressImgV];
    [self.addressImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(10));
        make.centerY.equalTo(bgView);
        make.width.height.mas_offset(kWidth(16));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    //self.nameLab.text = @"张三";
    self.nameLab.textColor = [ColorManager BlackColor];
    self.nameLab.font = kBoldFont(14);
    [bgView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(35));
        make.top.mas_offset(kWidth(20));
    }];
    
    self.phoneLab = [[UILabel alloc]init];
    //self.phoneLab.text = @"156****1245";
    self.phoneLab.textColor = [ColorManager BlackColor];
    self.phoneLab.font = kBoldFont(14);
    [bgView addSubview:self.phoneLab];
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLab.mas_right).mas_offset(kWidth(10));
        make.centerY.equalTo(self.nameLab);
    }];
    
    self.changeddressBtn = [[UIButton alloc]init];
    [self.changeddressBtn setTitle:@"修改" forState:UIControlStateNormal];
    [self.changeddressBtn setTitleColor:[ColorManager Color09AFFF] forState:UIControlStateNormal];
    self.changeddressBtn.titleLabel.font = kFont(14);
    [bgView addSubview:self.changeddressBtn];
    [self.changeddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-10));
        make.centerY.equalTo(self.nameLab);
        make.width.mas_offset(kWidth(35));
        make.height.mas_offset(kWidth(15));
    }];
    
    self.addressLab = [[UILabel alloc]init];
    //self.addressLab.text = @"辽宁省大连市沙河口区中山路金玉577-5-2101";
    self.addressLab.textColor = [ColorManager Color555555];
    self.addressLab.font = kFont(12);
    [bgView addSubview:self.addressLab];
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(35));
        make.right.mas_offset(kWidth(-36));
        make.top.equalTo(self.nameLab.mas_bottom).mas_offset(kWidth(8));
    }];
    
//    self.arrowImgV = [[UIImageView alloc]initWithImage:kGetImage(@"箭头_浅")];
//    self.arrowImgV.contentMode = UIViewContentModeScaleAspectFit;
//    [bgView addSubview:self.arrowImgV];
//    [self.arrowImgV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_offset(kWidth(-10));
//        make.centerY.equalTo(bgView);
//        make.width.height.mas_offset(kWidth(16));
//    }];
    
}

-(void)setModel:(OrderListModel *)model{
    if (self.type) {
        self.addressLab.text = [NSString stringWithFormat:@"收货人：%@",model.address];
    }else{
        self.addressLab.text = model.address;
    }
    self.nameLab.text = model.consignee;
    self.phoneLab.text = model.mobile;
}

-(void)setType:(NSString *)type{
    _type= type;
    self.addressImgV.hidden = NO;
    if ([type isEqualToString:@"1"]) {
        self.changeddressBtn.hidden = NO;
    }else{
        self.changeddressBtn.hidden = YES;
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
