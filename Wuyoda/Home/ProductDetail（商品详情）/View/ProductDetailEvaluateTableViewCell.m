//
//  ProductDetailEvaluateTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/15.
//

#import "ProductDetailEvaluateTableViewCell.h"

@interface ProductDetailEvaluateTableViewCell ()

@property (nonatomic , retain)UIImageView *iconImgV;
@property (nonatomic , retain)UILabel *nameLab;
@property (nonatomic , retain)UILabel *timeLab;
@property (nonatomic , retain)UILabel *evaluateLab;

@property (nonatomic , retain)UILabel *allEvaluateLab;

@end

@implementation ProductDetailEvaluateTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    
    return self;
}

-(void)createUI{
    self.iconImgV = [[UIImageView alloc]initWithImage:kGetImage(@"normal_icon")];
    self.iconImgV.backgroundColor = [ColorManager RandomColor];
    self.iconImgV.layer.cornerRadius = kWidth(20);
    self.iconImgV.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImgV];
    [self.iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(kWidth(20));
        make.width.height.mas_offset(kWidth(40));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.text = @"小野";
    self.nameLab.textColor = [ColorManager BlackColor];
    self.nameLab.font = kFont(14);
    [self.contentView addSubview:self.nameLab];
    [self.iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImgV.mas_right).mas_offset(kWidth(9));
        make.top.equalTo(self.iconImgV);
    }];
    
    self.timeLab = [[UILabel alloc]init];
    self.timeLab.text = @"2020年9月";
    self.timeLab.textColor = [ColorManager Color555555];
    self.timeLab.font = kFont(12);
    [self.contentView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImgV.mas_right).mas_offset(kWidth(9));
        make.bottom.equalTo(self.iconImgV);
    }];
    
    self.evaluateLab = [[UILabel alloc]init];
    self.evaluateLab.text = @"体验感很好、很方便、线上客服服务也不错、我对台湾这边的美食不是很熟悉还主动介绍了地方、人讲话也是很有礼貌的哦！";
    self.evaluateLab.textColor = [ColorManager Color555555];
    self.evaluateLab.font = kFont(14);
    self.evaluateLab.numberOfLines =0;
    self.evaluateLab.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:self.evaluateLab];
    [self.evaluateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.right.mas_offset(kWidth(-20));
        make.top.equalTo(self.iconImgV.mas_bottom).mas_offset(kWidth(12));
    }];
    
    self.allEvaluateLab = [[UILabel alloc]init];
    self.allEvaluateLab.textColor = [ColorManager MainColor];
    self.allEvaluateLab.font = kFont(14);
    NSMutableAttributedString *allEvaluate = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"阅读全部%@条评价",@"172"]];
    [allEvaluate addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, allEvaluate.length)];
    self.allEvaluateLab.attributedText = allEvaluate;
    [self.contentView addSubview:self.allEvaluateLab];
    [self.allEvaluateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.equalTo(self.evaluateLab.mas_bottom).mas_offset(kWidth(24));
    }];
    
    UIButton *allEvaluateBtn = [[UIButton alloc]init];
    [allEvaluateBtn addTarget:self action:@selector(readAllEvaluateClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:allEvaluateBtn];
    [allEvaluateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.height.equalTo(self.allEvaluateLab);
    }];
    
}

-(void)readAllEvaluateClicked:(id)sender{
    
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
