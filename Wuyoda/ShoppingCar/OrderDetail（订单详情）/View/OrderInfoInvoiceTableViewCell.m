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

    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"发票";
    titleLab.textColor = [ColorManager Color333333];
    titleLab.font = kFont(14);
    [self.contentView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(12));
        make.centerY.equalTo(self.contentView);
    }];
    
    
    self.invoiceLab = [[UILabel alloc]init];
    self.invoiceLab.text = @"暂不支持开具电子发票";
    self.invoiceLab.textColor = [ColorManager Color333333];
    self.invoiceLab.font = kFont(14);
    [self.contentView addSubview:self.invoiceLab];
    [self.invoiceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-12));
        make.centerY.equalTo(self.contentView);
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
