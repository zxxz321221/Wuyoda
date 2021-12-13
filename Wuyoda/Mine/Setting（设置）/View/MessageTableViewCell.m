//
//  MessageTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/14.
//

#import "MessageTableViewCell.h"

@interface MessageTableViewCell ()

@property (nonatomic , retain)UIImageView *iconImgV;

@property (nonatomic , retain)UILabel *nameLab;

@property (nonatomic , retain)UILabel *timeLab;

@property (nonatomic , retain)UILabel *messageLab;

@end

@implementation MessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    
    return self;
}

-(void)createUI{
    self.iconImgV = [[UIImageView alloc]init];
    self.iconImgV.backgroundColor = [ColorManager RandomColor];
    self.iconImgV.layer.cornerRadius = kWidth(28);
    self.iconImgV.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImgV];
    [self.iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(kWidth(20));
        make.width.height.mas_offset(kWidth(56));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.text = @"小野";
    self.nameLab.textColor = [ColorManager BlackColor];
    self.nameLab.font = kFont(16);
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImgV.mas_right).mas_offset(kWidth(13));
        make.top.equalTo(self.iconImgV);
    }];
    
    self.timeLab = [[UILabel alloc]init];
    self.timeLab.text = @"2020/5/17 ";
    self.timeLab.textColor = [ColorManager Color7F7F7F];
    self.timeLab.font = kFont(12);
    [self.contentView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-44));
        make.centerY.equalTo(self.nameLab);
    }];
    
    UIImageView *arrowImgV = [[UIImageView alloc]initWithImage:kGetImage(@"")];
    [self.contentView addSubview:arrowImgV];
    [arrowImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-20));
        make.centerY.equalTo(self.timeLab);
        make.width.height.mas_offset(kWidth(16));
    }];
    
    self.messageLab = [[UILabel alloc]init];
    self.messageLab.text = @"小摹你好！让每一位客人都买得安心...";
    self.messageLab.textColor = [ColorManager Color7F7F7F];
    self.messageLab.font = kFont(14);
    [self.contentView addSubview:self.messageLab];
    [self.messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLab);
        make.right.mas_offset(kWidth(-38));
        make.top.equalTo(self.nameLab.mas_bottom).mas_offset(kWidth(8));
    }];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = [ColorManager ColorF2F2F2];
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.height.mas_offset(kWidth(1));
        make.left.mas_offset(kWidth(20));
        make.right.mas_offset(kWidth(-20));
    }];
    
}

-(void)setModel:(MessageModel *)model{
    [self.iconImgV sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    self.nameLab.text = model.author;
    self.timeLab.text = model.register_date;
    self.messageLab.text = model.board_subject;
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
