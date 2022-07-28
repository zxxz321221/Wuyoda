//
//  OrderInfoInvoiceTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/27.
//

#import "OrderInfoInvoiceTableViewCell.h"

@interface OrderInfoInvoiceTableViewCell ()

@property (nonatomic , retain)UILabel *invoiceLab;

@end

@implementation OrderInfoInvoiceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    
    return self;
}

-(void)createUI{
    
    self.backgroundColor = [ColorManager ColorF2F2F2];
    
    UIView *bgV = [[UIView alloc]initWithFrame:CGRectMake(kWidth(10), 0, kWidth(355), kWidth(44))];
    bgV.backgroundColor = [ColorManager WhiteColor];
    [self.contentView addSubview:bgV];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bgV.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(kWidth(10), kWidth(10))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame =  bgV.bounds;
    maskLayer.path = maskPath.CGPath;
    bgV.layer.mask = maskLayer;

    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"发票";
    titleLab.textColor = [ColorManager Color333333];
    titleLab.font = kFont(14);
    [bgV addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(12));
        make.centerY.equalTo(bgV);
    }];
    
    
    self.invoiceLab = [[UILabel alloc]init];
    self.invoiceLab.text = @"暂不支持开具电子发票";
    self.invoiceLab.textColor = [ColorManager Color333333];
    self.invoiceLab.font = kFont(14);
    [bgV addSubview:self.invoiceLab];
    [self.invoiceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-12));
        make.centerY.equalTo(bgV);
    }];

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
