//
//  OrderInfoTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/27.
//

#import "OrderInfoTableViewCell.h"

@implementation OrderInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    
    return self;
}

-(void)createUI{
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.textColor = [ColorManager Color666666];
    self.titleLab.font = kFont(14);
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(12));
        make.centerY.equalTo(self.contentView);
    }];
    
    self.infoLab = [[UILabel alloc]init];
    self.infoLab.textColor = [ColorManager Color666666];
    self.infoLab.font = kFont(14);
    [self.contentView addSubview:self.infoLab];
    [self.infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-12));
        make.centerY.equalTo(self.contentView);
    }];
    
    self.orderCopyBtn = [[UIButton alloc]init];
    [self.orderCopyBtn setTitle:@"复制" forState:UIControlStateNormal];
    [self.orderCopyBtn setTitleColor:[ColorManager Color09AFFF] forState:UIControlStateNormal];
    self.orderCopyBtn.titleLabel.font = kFont(14);
    [self.contentView addSubview:self.orderCopyBtn];
    [self.orderCopyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-12));
        make.centerY.equalTo(self.contentView);
        make.width.mas_offset(kWidth(30));
        make.height.mas_offset(22);
    }];
    
    self.orderNumLab = [[UILabel alloc]init];
    self.orderNumLab.textColor = [ColorManager Color666666];
    self.orderNumLab.font = kFont(14);
    [self.contentView addSubview:self.orderNumLab];
    [self.orderNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.orderCopyBtn.mas_left).mas_offset(kWidth(-8));
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
