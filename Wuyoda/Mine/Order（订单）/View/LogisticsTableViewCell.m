//
//  LogisticsTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/14.
//

#import "LogisticsTableViewCell.h"

@interface LogisticsTableViewCell ()

@property (nonatomic , retain)UIView *pointV;

@property (nonatomic , retain)UILabel *statusLab;

@property (nonatomic , retain)UILabel *timeLab;

@property (nonatomic , retain)UILabel *infoLab;

@end

@implementation LogisticsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    
    return self;
}

-(void)createUI{
    self.pointV = [[UIView alloc]init];
    self.pointV.backgroundColor = [ColorManager ColorCCCCCC];
    self.pointV.layer.cornerRadius = kWidth(10);
    [self.contentView addSubview:self.pointV];
    [self.pointV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(23));
        make.top.mas_offset(0);
        make.width.height.mas_offset(kWidth(20));
    }];
    
    self.line = [[UIView alloc]init];
    self.line.backgroundColor = [ColorManager ColorCCCCCC];
    [self.contentView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.pointV);
        make.top.equalTo(self.pointV.mas_bottom);
        make.width.mas_offset(kWidth(1));
        make.bottom.equalTo(self.contentView);
    }];
    
    self.statusLab = [[UILabel alloc]init];
    self.statusLab.text = @"";
    self.statusLab.textColor = [ColorManager Color999999];
    self.statusLab.font = kBoldFont(16);
    [self.contentView addSubview:self.statusLab];
    [self.statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pointV.mas_right).mas_offset(kWidth(20));
        make.centerY.equalTo(self.pointV);
    }];
    
    self.timeLab = [[UILabel alloc]init];
    //self.timeLab.text = @"08-29  09：56";
    self.timeLab.textColor = [ColorManager Color999999];
    self.timeLab.font = kFont(12);
    [self.contentView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.statusLab.mas_right).mas_offset(kWidth(3));
        make.centerY.equalTo(self.pointV);
    }];
    
    self.infoLab = [[UILabel alloc]init];
    //self.infoLab.text = @"快件离开武汉已发往沈阳";
    self.infoLab.textColor = [ColorManager Color999999];
    self.infoLab.font = kFont(12);
    self.infoLab.numberOfLines = 0;
    self.infoLab.lineBreakMode = NSLineBreakByCharWrapping;
    [self.contentView addSubview:self.infoLab];
    [self.infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pointV.mas_right).mas_offset(kWidth(20));
        make.top.equalTo(self.timeLab.mas_bottom).mas_offset(kWidth(5));
        make.right.mas_offset(kWidth(-20));
    }];
}

-(void)setModel:(LogisticsModel *)model{
    self.timeLab.text = model.updateTime;
    self.infoLab.text = model.action;
}

-(void)setModel2:(LogisticsSubModel *)model2{
    _model2 = model2;
    self.statusLab.text = model2.status;
    self.timeLab.text = model2.ftime;
    self.infoLab.text = model2.context;
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
