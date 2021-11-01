//
//  HomeCultureProductTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/14.
//

#import "HomeCultureProductTableViewCell.h"

@interface HomeCultureProductTableViewCell ()

@property (nonatomic , retain)UIImageView *leftImageV;
@property (nonatomic , retain)UIImageView *rightTopImageV;
@property (nonatomic , retain)UIImageView *rightBottomImageV;


@end

@implementation HomeCultureProductTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.leftImageV = [[UIImageView alloc]init];
    [self.leftImageV setImage:kGetImage(@"home_culturel_good1")];
    self.leftImageV.backgroundColor = [ColorManager RandomColor];
    self.leftImageV.layer.cornerRadius = kWidth(5);
    self.leftImageV.layer.masksToBounds = YES;
    [self.contentView addSubview:self.leftImageV];
    [self.leftImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.mas_offset(0);
        make.width.height.mas_offset(kWidth(165));
    }];
    
    self.rightTopImageV = [[UIImageView alloc]init];
    [self.rightTopImageV setImage:kGetImage(@"home_culturel_good2")];
    self.rightTopImageV.backgroundColor = [ColorManager RandomColor];
    self.rightTopImageV.layer.cornerRadius = kWidth(5);
    self.rightTopImageV.layer.masksToBounds = YES;
    [self.contentView addSubview:self.rightTopImageV];
    [self.rightTopImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-20));
        make.top.equalTo(self.leftImageV);
        make.width.mas_offset(kWidth(161));
        make.height.mas_offset(kWidth(78));
    }];
    
    self.rightBottomImageV = [[UIImageView alloc]init];
    [self.rightBottomImageV setImage:kGetImage(@"home_culturel_good3")];
    self.rightBottomImageV.backgroundColor = [ColorManager RandomColor];
    self.rightBottomImageV.layer.cornerRadius = kWidth(5);
    self.rightBottomImageV.layer.masksToBounds = YES;
    [self.contentView addSubview:self.rightBottomImageV];
    [self.rightBottomImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-20));
        make.bottom.equalTo(self.leftImageV);
        make.width.mas_offset(kWidth(161));
        make.height.mas_offset(kWidth(78));
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
