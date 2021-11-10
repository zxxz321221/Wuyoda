//
//  ProductDetailIntroduceTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/15.
//

#import "ProductDetailIntroduceTableViewCell.h"

@interface ProductDetailIntroduceTableViewCell ()

@property (nonatomic , retain)UILabel *introLab;

@property (nonatomic , retain)UIButton *moreBtn;

@end

@implementation ProductDetailIntroduceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.introLab = [[UILabel alloc]init];
    self.introLab.text = @"味荣于丰原耕耘七十余年，致力于结合在地农产与人文。葫芦墩(丰原旧名)自古以「水清、米白、查某水」闻名。\n「水清」意指大甲溪引进的水清澈无比，「米白」指的曾受天皇称赞的葫芦墩米。味荣酱油采用葫芦墩圳水与米、并承袭老师傅的酿造工艺，成就了滴滴亮亮的好味道。且以精致味噌、有机酿造的专家为经营指标，多年累积的特殊口味与专业生产经验，奠定台湾中部第一品牌的地位及信誉，以客户的满意为依归，贯彻品质目标。";
    self.introLab.textColor= [ColorManager BlackColor];
    self.introLab.font = kFont(14);
    self.introLab.numberOfLines = 0;
    self.introLab.lineBreakMode = NSLineBreakByCharWrapping;
    [self.contentView addSubview:self.introLab];
    [self.introLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.right.mas_offset(kWidth(-20));
        make.top.mas_offset(kWidth(5));
    }];
    
    self.moreBtn = [[UIButton alloc]init];
    [self.moreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
    [self.moreBtn setTitleColor:[ColorManager MainColor] forState:UIControlStateNormal];
    self.moreBtn.titleLabel.font = kFont(14);
    [self.contentView addSubview:self.moreBtn];
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.bottom.mas_offset(-20);
        make.width.mas_offset(kWidth(70));
        make.height.mas_offset(kWidth(20));
    }];
}

-(void)setModel:(HomeShopModel *)model{
    self.introLab.text = model.goods_advance;
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
