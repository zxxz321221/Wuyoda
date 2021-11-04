//
//  AttractionsListTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/18.
//

#import "AttractionsListTableViewCell.h"

@interface AttractionsListTableViewCell ()

@property (nonatomic , retain)UIImageView *imgV;
@property (nonatomic , retain)UILabel *nameLab;
@property (nonatomic , retain)UILabel *introLab;
@property (nonatomic , retain)UIButton *likeBtn;
@property (nonatomic , retain)UIButton *shareBtn;

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
    self.imgV = [[UIImageView alloc]init];
    self.imgV.backgroundColor = [ColorManager RandomColor];
    self.imgV.layer.cornerRadius = kWidth(5);
    [self.contentView addSubview:self.imgV];
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_offset(kWidth(120));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.text = @"旗津海水浴场";
    self.nameLab.textColor = [ColorManager BlackColor];
    self.nameLab.font = kBoldFont(18);
    [self.contentView addSubview:self.nameLab];
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
    self.introLab.lineBreakMode = NSLineBreakByCharWrapping;
    [self.contentView addSubview:self.introLab];
    [self.introLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgV.mas_right).mas_offset(kWidth(20));
        make.right.mas_offset(kWidth(-20));
        make.top.equalTo(self.nameLab.mas_bottom).mas_offset(kWidth(8));
    }];
    
    
    self.shareBtn = [[UIButton alloc]init];
    [self.shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [self.shareBtn setImage:kGetImage(@"") forState:UIControlStateNormal];
    [self.shareBtn setTitleColor:[ColorManager Color333333] forState:UIControlStateNormal];
    self.shareBtn.titleLabel.font = kFont(12);
    [self.contentView addSubview:self.shareBtn];
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-20));
        make.bottom.equalTo(self.imgV);
        make.width.mas_offset(kWidth(48));
        make.height.mas_offset(kWidth(17));
    }];
    
    self.likeBtn = [[UIButton alloc]init];
    [self.likeBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [self.likeBtn setImage:kGetImage(@"") forState:UIControlStateNormal];
    [self.likeBtn setTitleColor:[ColorManager Color333333] forState:UIControlStateNormal];
    self.likeBtn.titleLabel.font = kFont(12);
    [self.contentView addSubview:self.likeBtn];
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.shareBtn.mas_left).mas_offset(kWidth(-18));
        make.bottom.equalTo(self.imgV);
        make.width.mas_offset(kWidth(48));
        make.height.mas_offset(kWidth(17));
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [ColorManager ColorF7F7F7];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_offset(kWidth(1));
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

-(void)setAttractionName:(NSString *)attractionName{
    self.nameLab.text = attractionName;
    if ([attractionName isEqualToString:@"金獅湖風景區"]) {
        self.imgV.image = kGetImage(@"金獅湖風景區0");
        self.introLab.text = @"金狮湖位于高雄爱河上游，原名大埤或覆鼎金埤，是爱河源头的贮水埤圳之一，水源来自中山高速公路东侧之鼎金圳，湖面积约11公顷，雨季时有调节的重要功能。与澄清湖之间，隔着中山高速公路与高雄高尔夫球场。湖面状似伏狮、倚着狮头山而风景宜人，狮山公园、蝴蝶园、道德院以及覆鼎金保安宫等各景点围绕着湖畔。";
    }else if ([attractionName isEqualToString:@"蓮池潭"]){
        self.imgV.image = kGetImage(@"蓮池潭0");
        self.introLab.text = @"莲池潭位于高雄市左营区，南邻龟山、北倚半屏山，起初称为莲花潭，莲池潭总面积约为42公顷是高雄市左营区最大的湖泊，拥有约20多座的寺庙，环潭十二座香烟缭绕的庙宇包含北极玄天上帝、启明堂、春秋阁、五里亭和龙虎塔，北面有高雄孔庙和万年公园、南侧为凤山县旧城残、东面则为莲池潭牌楼入口和高雄市风景区管理所。高雄左营莲池潭近年来会举办一年一度的「莲池潭万年祭」，约在10月份举行，让莲池潭充满传统文化和宗教气息的高雄旅游景点。";
    }
}

@end
