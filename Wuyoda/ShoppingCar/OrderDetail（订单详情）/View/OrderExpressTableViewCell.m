//
//  OrderExpressTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2022/6/9.
//

#import "OrderExpressTableViewCell.h"

@interface OrderExpressTableViewCell ()

@property (nonatomic , retain)UILabel *titleLab;

@property (nonatomic , retain)UIImageView *selectImgV;

@end

@implementation OrderExpressTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    
    return self;
}

-(void)createUI{
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.textColor = [ColorManager BlackColor];
    self.titleLab.font = kFont(14);
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.mas_offset(kWidth(20));
    }];
    
    self.selectImgV = [[UIImageView alloc]initWithImage:kGetImage(@"选择")];
    [self.contentView addSubview:self.selectImgV];
    [self.selectImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.mas_offset(kWidth(-20));
        make.width.height.mas_offset(kWidth(18));
    }];
}

-(void)setShipDic:(NSDictionary *)shipDic{
    _shipDic = shipDic;
    self.titleLab.text = shipDic[@"name"];
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
