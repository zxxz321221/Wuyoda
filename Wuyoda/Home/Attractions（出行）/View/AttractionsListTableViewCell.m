//
//  AttractionsListTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/18.
//

#import "AttractionsListTableViewCell.h"

@interface AttractionsListTableViewCell ()

@property (nonatomic , retain)UIView *bgView;
@property (nonatomic , retain)UIImageView *imgV;
@property (nonatomic , retain)UILabel *nameLab;
@property (nonatomic , retain)UILabel *introLab;
//@property (nonatomic , retain)UIButton *likeBtn;
//@property (nonatomic , retain)UIButton *shareBtn;

@end

@implementation AttractionsListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    self.contentView.backgroundColor = [ColorManager ColorF2F2F2];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(160))];
    bgView.backgroundColor = [ColorManager WhiteColor];
    self.bgView = bgView;
    [self.contentView addSubview:bgView];
    
    self.imgV = [[UIImageView alloc]init];
    self.imgV.backgroundColor = [ColorManager ColorF2F2F2];
    self.imgV.layer.cornerRadius = kWidth(5);
    self.imgV.layer.masksToBounds = YES;
    [bgView addSubview:self.imgV];
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.centerY.equalTo(bgView);
        make.width.height.mas_offset(kWidth(120));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.text = @"旗津海水浴场";
    self.nameLab.textColor = [ColorManager BlackColor];
    self.nameLab.font = kBoldFont(18);
    [bgView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgV.mas_right).mas_offset(kWidth(20));
        make.right.mas_offset(kWidth(-20));
        make.top.equalTo(self.imgV);
    }];
    
    self.introLab = [[UILabel alloc]init];
    self.introLab.text = @"浴场设有观海景观步道、越野区自然生态区等不同的休憩区...";
    self.introLab.textColor = [ColorManager Color333333];
    self.introLab.font = kFont(12);
    self.introLab.numberOfLines = 2;
    self.introLab.lineBreakMode = NSLineBreakByTruncatingTail;
    [bgView addSubview:self.introLab];
    [self.introLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgV.mas_right).mas_offset(kWidth(20));
        make.right.mas_offset(kWidth(-20));
        make.top.equalTo(self.nameLab.mas_bottom).mas_offset(kWidth(8));
    }];
    
    
//    self.shareBtn = [[UIButton alloc]init];
//    [self.shareBtn setTitle:@"分享" forState:UIControlStateNormal];
//    [self.shareBtn setImage:kGetImage(@"") forState:UIControlStateNormal];
//    [self.shareBtn setTitleColor:[ColorManager Color333333] forState:UIControlStateNormal];
//    self.shareBtn.titleLabel.font = kFont(12);
//    [self.contentView addSubview:self.shareBtn];
//    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_offset(kWidth(-20));
//        make.bottom.equalTo(self.imgV);
//        make.width.mas_offset(kWidth(48));
//        make.height.mas_offset(kWidth(17));
//    }];
//    
//    self.likeBtn = [[UIButton alloc]init];
//    [self.likeBtn setTitle:@"收藏" forState:UIControlStateNormal];
//    [self.likeBtn setImage:kGetImage(@"") forState:UIControlStateNormal];
//    [self.likeBtn setTitleColor:[ColorManager Color333333] forState:UIControlStateNormal];
//    self.likeBtn.titleLabel.font = kFont(12);
//    [self.contentView addSubview:self.likeBtn];
//    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.shareBtn.mas_left).mas_offset(kWidth(-18));
//        make.bottom.equalTo(self.imgV);
//        make.width.mas_offset(kWidth(48));
//        make.height.mas_offset(kWidth(17));
//    }];
    
}

-(void)setModel:(AttractionModel *)model{
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    self.nameLab.text = model.scenic_title;
    self.introLab.text = model.scenic_brief;
}

-(void)setIsFirst:(BOOL)isFirst{
    if (isFirst) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bgView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(kWidth(10), kWidth(10))];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame =  self.bgView.bounds;
        maskLayer.path = maskPath.CGPath;
        self.bgView.layer.mask = maskLayer;
    }else{
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bgView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(kWidth(10), kWidth(10))];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame =  self.bgView.bounds;
        maskLayer.path = maskPath.CGPath;
        self.bgView.layer.mask = maskLayer;
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
