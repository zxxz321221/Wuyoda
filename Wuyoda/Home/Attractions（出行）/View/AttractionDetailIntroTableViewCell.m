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

-(void)setAttractionName:(NSString *)attractionName{
    if ([attractionName isEqualToString:@"金獅湖風景區"]) {
        self.introLab.text = @"金狮湖风景区\n金狮湖位于高雄爱河上游，原名大埤或覆鼎金埤，是爱河源头的贮水埤圳之一，水源来自中山高速公路东侧之鼎金圳，湖面积约11公顷，雨季时有调节的重要功能。与澄清湖之间，隔着中山高速公路与高雄高尔夫球场。湖面状似伏狮、倚着狮头山而风景宜人，狮山公园、蝴蝶园、道德院以及覆鼎金保安宫等各景点围绕着湖畔。";
    }else if ([attractionName isEqualToString:@"蓮池潭"]){
        self.introLab.text = @"蓮池潭(龍虎塔)\n莲池潭位于高雄市左营区，南邻龟山、北倚半屏山，起初称为莲花潭，莲池潭总面积约为42公顷是高雄市左营区最大的湖泊，拥有约20多座的寺庙，环潭十二座香烟缭绕的庙宇包含北极玄天上帝、启明堂、春秋阁、五里亭和龙虎塔，北面有高雄孔庙和万年公园、南侧为凤山县旧城残、东面则为莲池潭牌楼入口和高雄市风景区管理所。高雄左营莲池潭近年来会举办一年一度的「莲池潭万年祭」，约在10月份举行，让莲池潭充满传统文化和宗教气息的高雄旅游景点。\n莲池潭畔拥有多座寺庙，期中以高雄孔庙、春秋阁、龙虎塔、北极玄天上帝等等；「高雄孔庙」最原始、初建于西元1684年的建物目前仅保存崇圣祠，新高雄孔庙重建于西元1977年，位于莲池潭西北岸，整体建筑风格为宋代孔庙风格以及山东曲阜孔庙的配置，拥有夏商周三代的特色和文化，总面积为台湾最大的孔庙；「春秋阁」是两座中国宫殿式的春阁和秋阁，见于西元1953年，两座楼阁分别都是四层八角并以九曲桥相互连结，是纪念关圣帝君的标地物，阁前的骑龙观音也是特色所在；「龙虎塔」是两座龙和虎的阁楼，高七层的塔可由龙口进、虎口出，龙塔内画有中国的二十四孝子插图、虎塔则有十二贤士和玉皇大帝三十六宫将图；「北极玄天上帝」又称北极亭，庙高约为72公尺、七星宝剑长约38.5公尺，是东南亚最高的水上神像，入口处拥有峰壑和喷泉等等造景；莲池潭畔另外还有启明堂、五里亭和清水宫等庙宇，都是民众来到莲池潭旅游可造访的高雄旅游景点。";
    }else if ([attractionName isEqualToString:@"夜市文化"]){
        self.introLab.text = @"「O5 R10美麗島站」這邊可是有兩大夜市聚集，一定讓您吃得肚皮飽、眼皮鬆。\n走出美麗島站11號出口，我們來到了必吃景點之一的「六合夜市」，過去聚集許多小吃攤的「大港埔夜市」，更名為現在的「六合夜市」，這裡共有170個多攤位，大多以小吃為主，無論是牛排店、山產、特產、冷飲、冰品或是海產店應有盡有，其中鹽蒸蝦、紅茶牛奶、筒仔米糕、烏魚腱、海鮮粥、過魚湯、十全藥燉排骨、擔仔麵、土魠魚羹等等算是高雄市的招牌特色，不可錯過；此外「六合夜市」裡還有許多擁有異國風味的攤位，像是土耳其冰淇淋、墨西哥脆餅等都十分特別喔！\n傳統小吃　所向披靡－南華夜市\n轉個方向走出捷運三號出口，我們到了另一頭的「南華夜市」，不同於小吃美食為主的六合夜市，這裡以流行服飾、配件、皮鞋、日常生活用品等為主，商品種類眾多且物廉價美。別以為「南華夜市」只有服飾而已，來到這您不能不嚐嚐連外縣市朋友都愛的傳統小吃，像是：經營64年的愛玉冰、39年的老李排骨酥湯、24年的小辣椒滷味等，好吃的讓您豎起大拇指說讚！";
    }else if ([attractionName isEqualToString:@"蓮池潭"]){
        self.introLab.text = @"旗津海鮮\n旗津是高雄著名旅遊勝地，也是喜歡吃海鮮的遊客必去的景點，因為旗津四面環海，漁獲豐富，所以這裡有許多家專賣海鮮料理的海產店、小吃店和路邊攤，在中洲輪渡站旁還有漁民在此販賣當日捕撈的新鮮漁貨，不論是現吃還是買回家料理，各式各樣的海鮮絕對可以讓你大口滿足。\n\n★ 好吃推薦：烤小卷、螃蟹粥、川燙白蝦、酥炸蚵仔酥、炒海菜";
    }
}

@end
