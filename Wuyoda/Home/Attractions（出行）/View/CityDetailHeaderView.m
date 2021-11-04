//
//  CityDetailHeaderView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/22.
//

#import "CityDetailHeaderView.h"

@interface CityDetailHeaderView ()

@property (nonatomic , retain)UIImageView *imgV;

@property (nonatomic , retain)UILabel *introLab;

@end

@implementation CityDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    self.backgroundColor = [ColorManager WhiteColor];
    
    self.imgV = [[UIImageView alloc]initWithImage:kGetImage(@"高雄市")];
    //self.imgV.backgroundColor = [ColorManager RandomColor];
    [self addSubview:self.imgV];
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(16));
        make.right.mas_offset(-16);
        make.top.mas_offset(kWidth(5));
        make.height.mas_offset(kWidth(174));
    }];
    
    self.introLab = [[UILabel alloc]init];
    self.introLab.text = @"高雄市的旅游风情：拥有大都市现代风格的高雄市，旅游景点的丰富让人目不暇给，在市区有高雄85大楼、城市光廊、玫瑰圣母院、驳二艺术特区、瑞丰夜市、爱河之心(如意湖)、梦时代购物中心等，而近郊的旗津风景区、莲池潭、西子湾风景区也都有秀丽的景致供前往旅游的民众观赏；除此之外，五都合并前的高雄县，占地相当广大且旅游资源相对丰富，不论您打算来趟访古之旅拜访旗山老街、美浓、桥头糖厂，亦或是山林寻幽之旅，如阿公店水库、观音山、荖浓溪、茂林国家风景区、关山越岭古道、宝来温泉等，都可依您想到高雄旅游的目的来安排；而甫于2010年全新开幕位于大树区观音山风景区旁的义大世界，九十余公顷的面积，区域内包含学校、星级饭店、游乐世界、购物广场等涵盖文化艺术、购物美食、休闲渡假等多元主题，在南台湾掀起渡假游憩新风潮，也是您探访高雄不可错过的新兴景点。";
    self.introLab.textColor = [ColorManager Color333333];
    self.introLab.font = kFont(16);
    self.introLab.numberOfLines = 0;
    self.introLab.lineBreakMode = NSLineBreakByCharWrapping;
    [self addSubview:self.introLab];
    [self.introLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.right.mas_offset(-20);
        make.top.equalTo(self.imgV.mas_bottom).mas_offset(kWidth(14));
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
