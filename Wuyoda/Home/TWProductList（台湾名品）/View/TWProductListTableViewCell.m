//
//  TWProductListTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/17.
//

#import "TWProductListTableViewCell.h"

@interface TWProductListTableViewCell ()

@property (nonatomic , retain)UIImageView *imgV;
@property (nonatomic , retain)UILabel *logoLab;
@property (nonatomic , retain)UILabel *introLab;
@property (nonatomic , retain)UILabel *nameLab;
@property (nonatomic , retain)UIView *tagBGView;
@property (nonatomic , retain)UILabel *priceLab;
@property (nonatomic , retain)UILabel *oldPriceLab;
@property (nonatomic , retain)UILabel *unitLab;
@property (nonatomic , retain)UILabel *discountLab;

@end

@implementation TWProductListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.imgV = [[UIImageView alloc]init];
    self.imgV.backgroundColor = [ColorManager RandomColor];
    self.imgV.layer.cornerRadius = kWidth(10);
    self.imgV.layer.masksToBounds = YES;
    [self.contentView addSubview:self.imgV];
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kWidth(0));
        make.left.mas_offset(kWidth(20));
        make.width.mas_offset(kWidth(335));
        make.height.mas_offset(kWidth(206));
    }];
    
    self.logoLab = [[UILabel alloc]init];
    self.logoLab.text = @"知名品牌";
    self.logoLab.textColor = [ColorManager WhiteColor];
    self.logoLab.font = kFont(14);
    self.logoLab.textAlignment = NSTextAlignmentCenter;
    self.logoLab.backgroundColor = [ColorManager BlackColor];
    self.logoLab.layer.cornerRadius = kWidth(5);
    self.logoLab.layer.masksToBounds = YES;
    [self.contentView addSubview:self.logoLab];
    [self.logoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.equalTo(self.imgV.mas_bottom).mas_offset(kWidth(8));
        make.width.mas_offset(kWidth(71));
        make.height.mas_offset(kWidth(24));
    }];
    
    self.introLab = [[UILabel alloc]init];
    self.introLab.text = @"日本煎饼的美味绝技";
    self.introLab.textColor = [ColorManager BlackColor];
    self.introLab.font = kFont(14);
    [self.contentView addSubview:self.introLab];
    [self.introLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logoLab.mas_right).mas_offset(kWidth(9));
        make.centerY.equalTo(self.logoLab);
        make.right.mas_offset(kWidth(-20));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.text = @"小林煎饼礼盒";
    self.nameLab.textColor = [ColorManager BlackColor];
    self.nameLab.font = kBoldFont(16);
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.equalTo(self.logoLab.mas_bottom).mas_offset(kWidth(8));
        make.right.mas_offset(kWidth(-20));
    }];
    
    self.tagBGView = [[UIView alloc]init];
    [self.contentView addSubview:self.tagBGView];
    [self.tagBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.nameLab);
        make.top.equalTo(self.nameLab.mas_bottom).mas_offset(kWidth(8));
        make.height.mas_offset(kWidth(1));
    }];
    
    self.priceLab = [[UILabel alloc]init];
    self.priceLab.text = @"￥394";
    self.priceLab.textColor = [ColorManager ColorD8001B];
    self.priceLab.font = kBoldFont(16);
    [self.contentView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.equalTo(self.tagBGView.mas_bottom).mas_offset(kWidth(10));
    }];
    
    self.oldPriceLab = [[UILabel alloc]init];
    self.oldPriceLab.textColor = [ColorManager ColorAAAAAA];
    self.oldPriceLab.font = kFont(14);
    NSMutableAttributedString *oldPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",@"788"]];
    [oldPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, oldPrice.length)];
    self.oldPriceLab.attributedText = oldPrice;
    [self.contentView addSubview:self.oldPriceLab];
    [self.oldPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLab.mas_right).mas_offset(kWidth(4));
        make.bottom.equalTo(self.priceLab);
    }];
    
    self.unitLab = [[UILabel alloc]init];
    self.unitLab.text = @"/盒";
    self.unitLab.textColor = [ColorManager Color555555];
    self.unitLab.font = kFont(14);
    [self.contentView addSubview:self.unitLab];
    [self.unitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.oldPriceLab.mas_right);
        make.centerY.equalTo(self.oldPriceLab);
    }];
    
    self.discountLab = [[UILabel alloc]init];
    self.discountLab.text = @"5折 · 仅限今晚";
    self.discountLab.textColor = [ColorManager ColorD8001B];
    self.discountLab.font = kBoldFont(12);
    self.discountLab.textAlignment = NSTextAlignmentCenter;
    self.discountLab.backgroundColor = [ColorManager ColorF5D3D7];
    self.discountLab.layer.cornerRadius = kWidth(5);
    self.discountLab.layer.masksToBounds = YES;
    [self.contentView addSubview:self.discountLab];
    [self.discountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.unitLab.mas_right).mas_offset(kWidth(8));
        make.centerY.equalTo(self.unitLab);
        make.width.mas_offset(kWidth(99));
        make.height.mas_offset(kWidth(24));
    }];
    
    self.tagsArr = [[NSMutableArray alloc]initWithObjects:@"严选食材",@"安心购",@"特价",@"达人推荐",@"伴手礼", nil];
    
}

-(void)setTagsArr:(NSMutableArray *)tagsArr{
    _tagsArr = tagsArr;
    
    for (int i = 0; i<tagsArr.count; i++) {
        NSString *str = [tagsArr objectAtIndex:i];
        CGFloat strW = [LCTools widthWithString:str font:kWidth(12)];
        UILabel *lab = [[UILabel alloc]init];
        lab.text = str;
        lab.textColor = [ColorManager ColorB8741A];
        //lab.backgroundColor = [ColorManager ColorE1FFCA];
        lab.layer.cornerRadius = kWidth(5);
        lab.layer.borderColor = [ColorManager ColorB8741A].CGColor;
        lab.layer.borderWidth = kWidth(1);
        lab.layer.cornerRadius = kWidth(5);
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = kFont(12);
        lab.layer.masksToBounds = YES;
        if (i == 0) {
            lab.frame = CGRectMake(0, 0, strW+kWidth(12), kWidth(24));
        }else{
            UILabel *beforeLab = self.tagBGView.subviews.lastObject;
            if (beforeLab.frame.origin.x+beforeLab.frame.size.width + strW+kWidth(12) > kWidth(335)) {
                lab.frame = CGRectMake(0, beforeLab.frame.origin.y+kWidth(24)+kWidth(4), strW+kWidth(12), kWidth(24));
            }else{
                lab.frame = CGRectMake(beforeLab.frame.origin.x+beforeLab.frame.size.width+kWidth(4), beforeLab.origin.y, strW+kWidth(12), kWidth(24));
            }
        }
        
        [self.tagBGView addSubview:lab];
    }
    
    UILabel *lastLab = self.tagBGView.subviews.lastObject;
    //self.tagBGView.frame = CGRectMake(kWidth(20), self.tagBGView.origin.y, kWidth(335), lastLab.origin.y+lastLab.height);
    [self.tagBGView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(lastLab.origin.y+lastLab.height);
    }];
}

-(void)setImgName:(NSString *)imgName{
    [self.imgV setImage:kGetImage(imgName)];
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
