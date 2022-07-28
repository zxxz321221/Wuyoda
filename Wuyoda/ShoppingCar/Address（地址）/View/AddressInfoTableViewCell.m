//
//  AddressInfoTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/27.
//

#import "AddressInfoTableViewCell.h"

@interface AddressInfoTableViewCell ()<UITextViewDelegate>

@end

@implementation AddressInfoTableViewCell

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
    self.titleLab.font = kFont(18);
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(15));
        make.centerY.equalTo(self.contentView);
    }];
    
    self.infoBgV = [[UIView alloc]init];
    self.infoBgV.backgroundColor = [ColorManager ColorF2F2F2];
    self.infoBgV.layer.cornerRadius = kWidth(10);
    [self.contentView addSubview:self.infoBgV];
    [self.infoBgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kWidth(10));
        make.left.mas_offset(kWidth(111));
        make.right.mas_offset(kWidth(-20));
        make.bottom.mas_offset(kWidth(-10));
    }];
    
    self.infoTextField = [[UITextField alloc]init];
    self.infoTextField.textColor = [ColorManager BlackColor];
    self.infoTextField.font = kFont(14);
    [self.infoBgV addSubview:self.infoTextField];
    [self.infoTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.right.mas_offset(kWidth(-36));
        make.centerY.height.equalTo(self.infoBgV);
    }];
    
    self.addressTextV = [[UITextView alloc]init];
    self.addressTextV.textColor = [ColorManager BlackColor];
    self.addressTextV.font = kFont(14);
    self.addressTextV.backgroundColor = [ColorManager ColorF2F2F2];
    self.addressTextV.delegate = self;
    [self.infoBgV addSubview:self.addressTextV];
    [self.addressTextV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(16));
        make.right.mas_offset(kWidth(-36));
        make.top.mas_offset(kWidth(5));
        make.bottom.mas_offset(kWidth(-10));
    }];
    
    self.addressPlaceHolderLab = [[UILabel alloc]init];
    self.addressPlaceHolderLab.text = @"例：xx小区8号楼1-403";
    self.addressPlaceHolderLab.textColor = [ColorManager Color666666];
    self.addressPlaceHolderLab.font = kFont(14);
    [self.infoBgV addSubview:self.addressPlaceHolderLab];
    [self.addressPlaceHolderLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.mas_offset(kWidth(12));
    }];
    
    self.phoneTypeLab = [[UILabel alloc]init];
    self.phoneTypeLab.text = @"+86";
    self.phoneTypeLab.textColor = [ColorManager Color666666];
    self.phoneTypeLab.font = kFont(14);
    [self.infoBgV addSubview:self.phoneTypeLab];
    [self.phoneTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-34));
        make.centerY.equalTo(self.contentView);
    }];
    
    self.arrowImgV = [[UIImageView alloc]initWithImage:kGetImage(@"箭头_浅")];
    self.arrowImgV.contentMode = UIViewContentModeScaleAspectFit;
    [self.infoBgV addSubview:self.arrowImgV];
    [self.arrowImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-10));
        make.centerY.equalTo(self.infoBgV);
        make.width.height.mas_offset(kWidth(14));
    }];
    
    self.defaultImgV = [[UIImageView alloc]init];
    [self.defaultImgV setImage:kGetImage(@"选择")];
    self.defaultImgV.hidden = YES;
    [self.contentView addSubview:self.defaultImgV];
    [self.defaultImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_offset(kWidth(18));
    }];
    
    self.defaultLab = [[UILabel alloc]init];
    self.defaultLab.text = @"默认地址";
    self.defaultLab.textColor = [ColorManager BlackColor];
    self.defaultLab.font = kFont(18);
    [self.contentView addSubview:self.defaultLab];
    [self.defaultLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(48));
        make.centerY.equalTo(self.contentView);
    }];
    
    
}

-(void)textViewDidChange:(UITextView *)textView{
    self.addressPlaceHolderLab.hidden = textView.text.length;
}

-(void)setIs_buy:(BOOL)is_buy{
    if (is_buy) {
        [self.defaultImgV setImage:kGetImage(@"选中")];
    }else{
        [self.defaultImgV setImage:kGetImage(@"选择")];
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
