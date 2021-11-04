//
//  CityAttractionTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/22.
//

#import "CityAttractionTableViewCell.h"

@interface CityAttractionTableViewCell ()

@property (nonatomic , retain)UIImageView *imgV;

@property (nonatomic , retain)UILabel *nameLab;

@property (nonatomic , retain)UILabel *introLab;

@end

@implementation CityAttractionTableViewCell

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
        make.left.mas_offset(kWidth(16));
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_offset(kWidth(80));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.text = @"逢甲夜市";
    self.nameLab.textColor = [ColorManager Color333333];
    self.nameLab.font = kBoldFont(14);
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgV.mas_right).mas_offset(kWidth(16));
        make.top.equalTo(self.imgV);
    }];
    
    self.introLab = [[UILabel alloc]init];
    self.introLab.text = @"湿地面积不大，包含潮溪、沼泽、沙滩、碎石、泥滩等丰富且复杂的湿地生态。生物物种差异度极高，是各种底栖生物、鱼贝类、鸟类、水禽类栖息的最佳场所。高美湿地是著名的观...";
    self.introLab.textColor = [ColorManager Color333333];
    self.introLab.font = kFont(12);
    self.introLab.numberOfLines = 4;
    self.introLab.lineBreakMode = NSLineBreakByCharWrapping;
    [self addSubview:self.introLab];
    [self.introLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgV.mas_right).mas_offset(kWidth(16));
        make.right.mas_offset(-20);
        make.top.equalTo(self.nameLab.mas_bottom).mas_offset(kWidth(8));
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
