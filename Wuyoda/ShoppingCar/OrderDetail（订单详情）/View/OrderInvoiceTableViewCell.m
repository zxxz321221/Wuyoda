//
//  OrderInvoiceTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/26.
//

#import "OrderInvoiceTableViewCell.h"

@interface OrderInvoiceTableViewCell ()

@property (nonatomic , retain)UILabel *invoiceLab;

@end

@implementation OrderInvoiceTableViewCell

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
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"发票";
    titleLab.textColor = [ColorManager ColorCCCCCC];
    titleLab.font = kFont(14);
    [self.contentView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(15));
        make.centerY.equalTo(self.contentView);
    }];
    
    
    UIImageView *arrowImgV = [[UIImageView alloc]initWithImage:kGetImage(@"")];
    [self.contentView addSubview:arrowImgV];
    [arrowImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-10));
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_offset(kWidth(16));
    }];
    
    self.invoiceLab = [[UILabel alloc]init];
    self.invoiceLab.text = @"不开发票";
    self.invoiceLab.textColor = [ColorManager Color333333];
    self.invoiceLab.font = kFont(14);
    [self.contentView addSubview:self.invoiceLab];
    [self.invoiceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-40));
        make.centerY.equalTo(self.contentView);
    }];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = [ColorManager ColorF2F2F2];
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.width.equalTo(self.contentView);
        make.height.mas_offset(kWidth(1));
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
