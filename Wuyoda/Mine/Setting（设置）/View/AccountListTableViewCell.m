//
//  AccountListTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/30.
//

#import "AccountListTableViewCell.h"

@interface AccountListTableViewCell ()

@property (nonatomic , retain)UIImageView *iconImgV;

@property (nonatomic , retain)UILabel *nameLab;

@property (nonatomic , retain)UIImageView *selectImgV;

@end

@implementation AccountListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    
    return self;
}

-(void)createUI{
    self.iconImgV = [[UIImageView alloc]initWithImage:kGetImage(@"normal_icon")];
    self.iconImgV.layer.cornerRadius = kWidth(28);
    self.iconImgV.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImgV];
    [self.iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(21));
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_offset(kWidth(56));
    }];
    
    self.selectImgV = [[UIImageView alloc]initWithImage:kGetImage(@"选中")];
    [self.contentView addSubview:self.selectImgV];
    [self.selectImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.iconImgV);
        make.width.height.mas_offset(kWidth(16));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    //self.nameLab.text = @"小张";
    self.nameLab.textColor = [ColorManager Color333333];
    self.nameLab.font = kFont(16);
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(87));
        make.centerY.equalTo(self);
    }];
    
    self.deleteBtn = [[UIButton alloc] init];
    [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:[ColorManager Color008A70] forState:UIControlStateNormal];
    self.deleteBtn.titleLabel.font = kFont(14);
    self.deleteBtn.layer.cornerRadius = kWidth(13);
    self.deleteBtn.layer.borderColor = [ColorManager Color008A70].CGColor;
    self.deleteBtn.layer.borderWidth = kWidth(1);
    [self.contentView addSubview:self.deleteBtn];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-20));
        make.centerY.equalTo(self.contentView);
        make.width.mas_offset(kWidth(60));
        make.height.mas_offset(kWidth(26));
    }];
}

-(void)setModel:(UserInfoModel *)model{
    [self.iconImgV sd_setImageWithURL:[NSURL URLWithString:model.member_image] placeholderImage:kGetImage(@"normal_icon")];
    self.nameLab.text = model.member_name;
    
    UserInfoModel *currentUser = [UserInfoModel getUserInfoModel];
    if ([model.member_id isEqualToString:currentUser.member_id]) {
        self.selectImgV.hidden = NO;
    }else{
        self.selectImgV.hidden = YES;
    }
}

- (void)setType:(NSString *)type{
    if ([type isEqualToString:@"2"]) {
        self.deleteBtn .hidden = YES;
        self.selectImgV.hidden = YES;
        [self.iconImgV setImage:kGetImage(@"添加账号")];
        self.nameLab.text = @"添加账号";
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
