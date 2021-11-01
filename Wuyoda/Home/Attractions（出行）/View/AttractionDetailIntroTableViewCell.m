//
//  AttractionDetailIntroTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/18.
//

#import "AttractionDetailIntroTableViewCell.h"

@interface AttractionDetailIntroTableViewCell ()

@property (nonatomic , retain)UILabel *introLab;

@property (nonatomic , retain)UIButton *moreBtn;

@end

@implementation AttractionDetailIntroTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.introLab = [[UILabel alloc]init];
    self.introLab.text = @"浴场观看观海智慧步道、越野区、自然生态区等不同的休憩区；所以游客如织，即使是海水浴场不开放的季节，到此的游客亦不在身边。道路及峻伟的旗后山。\n尤其是每到傍晚时分，太阳当娱乐斜挂、彩空时，带着一波的浪花拍打着沙的乐音，情侣们谈情说爱及情趣等的浪漫地点。喜欢动力风筝的人就在此，还有游客在此落日余晖或远眺海上的船只。注意：旗津海水浴场有固定的戏水安全区域，请游客前往戏水时应先了解安全区域的规定，请勿在安全范围外的戏水范围内。";
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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
