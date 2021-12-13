//
//  OrderRemarkTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/26.
//

#import "OrderRemarkTableViewCell.h"

@implementation OrderRemarkTableViewCell

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
    titleLab.text = @"订单备注";
    titleLab.textColor = [ColorManager ColorCCCCCC];
    titleLab.font = kFont(14);
    [self.contentView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(15));
        make.centerY.equalTo(self.contentView);
    }];
    
    
    self.remarkField = [[UITextField alloc]init];
    self.remarkField.placeholder = @"请填写您的要求";
    self.remarkField.textColor = [ColorManager ColorCCCCCC];
    self.remarkField.font = kFont(14);
    self.remarkField.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.remarkField];
    [self.remarkField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-26));
        make.centerY.height.equalTo(self.contentView);
        make.width.mas_offset(kWidth(250));
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
