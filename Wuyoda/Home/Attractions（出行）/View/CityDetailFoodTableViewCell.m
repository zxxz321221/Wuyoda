//
//  CityDetailFoodTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/22.
//

#import "CityDetailFoodTableViewCell.h"

@interface CityDetailFoodTableViewCell ()

@property (nonatomic , retain)UIImageView *imgV;

@property (nonatomic , retain)UILabel *nameLab;

@property (nonatomic , retain)UILabel *branchLab;

@property (nonatomic , retain)UILabel *tagLab;

@property (nonatomic , retain)UILabel *introLab;

@property (nonatomic , retain)UILabel *addressLab;

@end

@implementation CityDetailFoodTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    self.imgV = [[UIImageView alloc]init];
    self.imgV.backgroundColor = [ColorManager ColorF2F2F2];
    self.imgV.layer.cornerRadius = kWidth(5);
    [self.contentView addSubview:self.imgV];
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(16));
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_offset(kWidth(80));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    //self.nameLab.text = @"纸箱王";
    self.nameLab.textColor = [ColorManager Color333333];
    self.nameLab.font = kBoldFont(14);
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgV).mas_offset(kWidth(3));
        make.left.equalTo(self.imgV.mas_right).mas_offset(kWidth(16));
    }];
    
    self.branchLab = [[UILabel alloc]init];
    //self.branchLab.text = @"（西屯路店）";
    self.branchLab.textColor = [ColorManager Color333333];
    self.branchLab.font = kFont(13);
    [self.contentView addSubview:self.branchLab];
    [self.branchLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.nameLab);
        make.left.equalTo(self.nameLab.mas_right).mas_offset(kWidth(5));
    }];
    
    self.tagLab = [[UILabel alloc]init];
    //self.tagLab.text = @"创意台湾菜";
    self.tagLab.textColor = [ColorManager WhiteColor];
    self.tagLab.font = kFont(10);
    self.tagLab.backgroundColor = [ColorManager Color008A70];
    self.tagLab.layer.cornerRadius = kWidth(3);
    self.tagLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.tagLab];
    [self.tagLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLab);
        make.left.equalTo(self.branchLab.mas_right).mas_offset(kWidth(6));
        make.width.mas_offset(kWidth(60));
        make.height.mas_offset(kWidth(18));
    }];
    
    self.introLab = [[UILabel alloc]init];
    //self.introLab.text = @"很有趣的创意餐厅，店内所有东西都是纸做的";
    self.introLab.textColor = [ColorManager Color333333];
    self.introLab.font = kFont(12);
    [self.contentView addSubview:self.introLab];
    [self.introLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLab.mas_bottom).mas_offset(kWidth(20));
        make.left.equalTo(self.nameLab);
        make.right.mas_offset(kWidth((-20)));
    }];
    
    self.addressLab = [[UILabel alloc]init];
    //self.addressLab.text = @"位置：东海大学以北1.2公里";
    self.addressLab.textColor = [ColorManager Color333333];
    self.addressLab.font = kFont(12);
    [self.contentView addSubview:self.addressLab];
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.introLab.mas_bottom).mas_offset(kWidth(10));
        make.left.right.equalTo(self.introLab);
    }];
    
}

-(void)setModel:(CityCustomModel *)model{
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:nil];
    self.nameLab.text = model.custom_title;
    self.tagLab.text = model.custom_td;
    CGFloat stringWidth = 0;
    CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
    
    if (model.custom_td) {
        
        stringWidth = [model.custom_td boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil].size.width;
    }
    [self.tagLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(stringWidth+kWidth(5));
    }];
    //CGFloat tagW =
    self.introLab.text = model.custom_brief;
    self.addressLab.text = [NSString stringWithFormat:@"位置:%@",model.custom_position];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setAttractionName:(NSString *)attractionName{
    self.nameLab.text = attractionName;
    if ([attractionName isEqualToString:@"夜市文化"]) {
        self.imgV.image = kGetImage(@"夜市文化1");
        self.introLab.text = @"這邊可是有兩大夜市聚集，一定讓您吃得肚皮飽、眼皮鬆。\n走出美麗島站11號出口，我們來到了必吃景點之一的「六合夜市」，過去聚集許多小吃攤的「大港埔夜市」，更名為現在的「六合夜市」，這裡共有170個多攤位，大多以小吃為主，無論是牛排店、山產、特產、冷飲、冰品或是海產店應有盡有，其中鹽蒸蝦、紅茶牛奶、筒仔米糕、烏魚腱、海鮮粥、過魚湯、十全藥燉排骨、擔仔麵、土魠魚羹等等算是高雄市的招牌特色，不可錯過；此外「六合夜市」裡還有許多擁有異國風味的攤位，像是土耳其冰淇淋、墨西哥脆餅等都十分特別喔！\n傳統小吃　所向披靡－南華夜市\n轉個方向走出捷運三號出口，我們到了另一頭的「南華夜市」，不同於小吃美食為主的六合夜市，這裡以流行服飾、配件、皮鞋、日常生活用品等為主，商品種類眾多且物廉價美。別以為「南華夜市」只有服飾而已，來到這您不能不嚐嚐連外縣市朋友都愛的傳統小吃，像是：經營64年的愛玉冰、39年的老李排骨酥湯、24年的小辣椒滷味等，好吃的讓您豎起大拇指說讚！";
    }else if ([attractionName isEqualToString:@"旗津海鲜"]){
        self.imgV.image = kGetImage(@"旗津海鲜");
        self.introLab.text = @"旗津是高雄著名旅遊勝地，也是喜歡吃海鮮的遊客必去的景點，因為旗津四面環海，漁獲豐富，所以這裡有許多家專賣海鮮料理的海產店、小吃店和路邊攤，在中洲輪渡站旁還有漁民在此販賣當日捕撈的新鮮漁貨，不論是現吃還是買回家料理，各式各樣的海鮮絕對可以讓你大口滿足。";
    }
}

@end
