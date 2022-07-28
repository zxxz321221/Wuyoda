//
//  AttractionDetailHeaderView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/18.
//

#import "AttractionDetailHeaderView.h"
#import "BannerModel.h"
#import "BannerImageView.h"

@interface AttractionDetailHeaderView ()<SDCycleScrollViewDelegate>

//@property (nonatomic , retain)UIScrollView *scrollV;
//@property (nonatomic , retain)UIImageView *attractionImgV;
@property (nonatomic , retain)UILabel *titleLab;
@property (nonatomic , retain)UILabel *priceLab;
@property (nonatomic , retain)UIView *tagsBGV;

@property (nonatomic , retain)NSArray *bannerArr;
@property (nonatomic, strong) UIView *bannerBGView;
@property (nonatomic, strong) SDCycleScrollView *banner;

@end

@implementation AttractionDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.backgroundColor = [ColorManager ColorF2F2F2];
    
//    self.scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(330))];
//    self.scrollV.pagingEnabled = YES;
//    [self addSubview:self.scrollV];
    
    UIView *bgView = [[UIView alloc]initWithFrame:self.bounds];
    bgView.backgroundColor = [ColorManager WhiteColor];
    [self addSubview:bgView];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(kWidth(10), kWidth(10))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame =  bgView.bounds;
    maskLayer.path = maskPath.CGPath;
    bgView.layer.mask = maskLayer;
    
    self.bannerBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(375))];
    self.bannerBGView.backgroundColor = [ColorManager WhiteColor];
    self.bannerBGView.layer.cornerRadius = kWidth(10);
    self.bannerBGView.layer.masksToBounds = YES;
    [self addSubview:self.bannerBGView];
    

    
//    self.attractionImgV = [[UIImageView alloc]init];
//    self.attractionImgV.backgroundColor = [ColorManager RandomColor];
//    [self addSubview:self.attractionImgV];
//    [self.attractionImgV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.width.equalTo(self);
//        make.height.mas_offset(kWidth(330));
//    }];
    
//    UIButton *closeBtn = [[UIButton alloc]init];
//    [closeBtn setImage:kGetImage(@"商品详情_关闭") forState:UIControlStateNormal];
//    [closeBtn addTarget:self action:@selector(closeClicked) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:closeBtn];
//    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(kWidth(20));
//        make.top.mas_offset(kHeight_StatusBar+kWidth(23));
//        make.width.height.mas_offset(kWidth(32));
//    }];
    
//    UIButton *shareBtn = [[UIButton alloc]init];
//    [shareBtn setImage:kGetImage(@"商品详情_分享") forState:UIControlStateNormal];
//    [shareBtn addTarget:self action:@selector(shareClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:shareBtn];
//    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_offset(kWidth(-20));
//        make.top.mas_offset(kHeight_StatusBar+kWidth(23));
//        make.width.height.mas_offset(kWidth(32));
//    }];
    
    self.titleLab = [[UILabel alloc]init];
    //self.titleLab.text = @"旗津海水浴场周边3日游";
    self.titleLab.textColor = [ColorManager BlackColor];
    self.titleLab.font = kBoldFont(18);
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.right.mas_offset(kWidth(-20));
        make.top.mas_offset(kWidth(395));
    }];
    
//    self.priceLab = [[UILabel alloc]init];
//    self.priceLab.text = @"市场价门票：￥299";
//    self.priceLab.textColor = [ColorManager MainColor];
//    self.priceLab.font = kFont(16);
//    [self addSubview:self.priceLab];
//    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(kWidth(20));
//        make.right.mas_offset(kWidth(-20));
//        make.top.equalTo(self.titleLab.mas_bottom).mas_offset(kWidth(9));
//    }];
//
//    self.tagsBGV = [[UIView alloc]init];
//    [self addSubview:self.tagsBGV];
//    [self.tagsBGV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(kWidth(20));
//        make.right.mas_offset(kWidth(-20));
//        make.top.equalTo(self.priceLab.mas_bottom).mas_offset(kWidth(16));
//        make.height.mas_offset(1);
//    }];
//
//    UIView *line = [[UIView alloc] init];
//    line.backgroundColor = [ColorManager ColorF7F7F7];
//    [self addSubview:line];
//    [line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(self);
//        make.height.mas_offset(kWidth(1));
//    }];
    
    //self.tagsArr = [[NSMutableArray alloc]initWithObjects:@"热门景点",@"低价优势", nil];
}

-(void)closeClicked{
    [self.CurrentViewController.navigationController popViewControllerAnimated:YES];
}

-(void)shareClicked:(UIButton *)sender{
    [self showHUDWithText:@"敬请期待" withYOffSet:0];
}

-(void)setTagsArr:(NSMutableArray *)tagsArr{
    _tagsArr = tagsArr;
    
    for (int i = 0; i<tagsArr.count; i++) {
        NSString *str = [tagsArr objectAtIndex:i];
        CGFloat strW = [LCTools widthWithString:str font:kWidth(13)];
        UILabel *lab = [[UILabel alloc]init];
        lab.text = str;
        lab.textColor = [ColorManager Color7F4D12];
        lab.backgroundColor = [ColorManager ColorF7E6CE];
        lab.layer.cornerRadius = kWidth(5);
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = kFont(13);
        lab.layer.masksToBounds = YES;
        if (i == 0) {
            lab.frame = CGRectMake(0, 0, strW+kWidth(20), kWidth(30));
        }else{
            UILabel *beforeLab = self.tagsBGV.subviews.lastObject;
            if (beforeLab.frame.origin.x+beforeLab.frame.size.width + strW+kWidth(20) > kWidth(335)) {
                lab.frame = CGRectMake(0, beforeLab.frame.origin.y+kWidth(30)+kWidth(4), strW+kWidth(20), kWidth(30));
            }else{
                lab.frame = CGRectMake(beforeLab.frame.origin.x+beforeLab.frame.size.width+kWidth(4), beforeLab.origin.y, strW+kWidth(20), kWidth(30));
            }
        }
        
        [self.tagsBGV addSubview:lab];
    }
    
    UILabel *lastLab = self.tagsBGV.subviews.lastObject;
    //self.tagBGView.frame = CGRectMake(kWidth(20), self.tagBGView.origin.y, kWidth(335), lastLab.origin.y+lastLab.height);
    [self.tagsBGV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(lastLab.origin.y+lastLab.height);
    }];
    
}

-(void)setModel:(AttractionModel *)model{
    _model = model;
    self.titleLab.text = model.scenic_title;
    self.bannerArr = [BannerModel mj_objectArrayWithKeyValuesArray:model.scenic_file];
//    self.scrollV.contentSize = CGSizeMake(kScreenWidth, 0);
//    UIImageView *attractionImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(330))];
//    attractionImgV.backgroundColor = [ColorManager RandomColor];
//    [attractionImgV sd_setImageWithURL:[NSURL URLWithString:model.cover]];
//    [self.scrollV addSubview:attractionImgV];
//    self.priceLab.text = [NSString stringWithFormat:@"市场价门票：￥%@",model.scenic_price];
}

-(void)setBannerArr:(NSArray *)bannerArr{
    _bannerArr = bannerArr;
    NSMutableArray *picArr = [NSMutableArray array];
//    [picArr addObjectsFromArray:bannerArr];
    for (BannerModel *model in bannerArr) {
        [picArr addObject:model.thumb];
    }
    self.banner = [SDCycleScrollView cycleScrollViewWithFrame:self.bannerBGView.bounds imageNamesGroup:picArr];
    self.banner.delegate = self;
    self.banner.infiniteLoop = picArr.count-1;
    self.banner.autoScrollTimeInterval = 3;
    self.banner.showPageControl = YES;
    self.banner.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    self.banner.pageControlBottomOffset = kWidth(12);
    self.banner.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.banner.pageDotImage = kGetImage(@"banner_normal");
    self.banner.currentPageDotImage = kGetImage(@"banner_select");
    self.banner.spacingBetweenDots = kWidth(5);
    self.banner.pageControlDotSize = CGSizeMake(kWidth(8), kWidth(8));
    self.banner.backgroundColor = [ColorManager WhiteColor];
    self.banner.placeholderImage = kGetImage(@"发现长条占位图");
    self.banner.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    self.banner.clipsToBounds = YES;
    [self.bannerBGView addSubview:self.banner];
}

#pragma mark - banner delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"轮播图点击%ld",index);
    BannerImageView *bannerImgV = [[BannerImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bannerImgV.bannerArr= self.bannerArr;
    bannerImgV.currentPage = index;
    [self.CurrentViewController.navigationController.view addSubview:bannerImgV];
}

//-(void)setAttractionName:(NSString *)attractionName{
//    self.titleLab.text = attractionName;
//    if ([attractionName isEqualToString:@"金獅湖風景區"]) {
//        self.scrollV.contentSize = CGSizeMake(kScreenWidth*4, 0);
//        for (int i = 0; i<4; i++) {
//            UIImageView *attractionImgV = [[UIImageView alloc]initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, kWidth(330))];
//            attractionImgV.backgroundColor = [ColorManager RandomColor];
//            NSString *imgName = [NSString stringWithFormat:@"%@%d",attractionName,i];
//            attractionImgV.image = kGetImage(imgName);
//            [self.scrollV addSubview:attractionImgV];
//
//        }
//    }else if ([attractionName isEqualToString:@"蓮池潭"]){
//        self.scrollV.contentSize = CGSizeMake(kScreenWidth*3, 0);
//        for (int i = 0; i<3; i++) {
//            UIImageView *attractionImgV = [[UIImageView alloc]initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, kWidth(330))];
//            attractionImgV.backgroundColor = [ColorManager RandomColor];
//            NSString *imgName = [NSString stringWithFormat:@"%@%d",attractionName,i];
//            attractionImgV.image = kGetImage(imgName);
//            [self.scrollV addSubview:attractionImgV];
//
//        }
//    }
//    else if ([attractionName isEqualToString:@"夜市文化"]){
//        self.priceLab.text = @"";
//        self.scrollV.contentSize = CGSizeMake(kScreenWidth*2, 0);
//        for (int i = 0; i<2; i++) {
//            UIImageView *attractionImgV = [[UIImageView alloc]initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, kWidth(330))];
//            attractionImgV.backgroundColor = [ColorManager RandomColor];
//            NSString *imgName = [NSString stringWithFormat:@"%@%d",attractionName,i+1];
//            attractionImgV.image = kGetImage(imgName);
//            [self.scrollV addSubview:attractionImgV];
//
//        }
//    }
//    else if ([attractionName isEqualToString:@"旗津海鲜"]){
//        self.priceLab.text = @"";
//        self.scrollV.contentSize = CGSizeMake(kScreenWidth, 0);
//        for (int i = 0; i<1; i++) {
//            UIImageView *attractionImgV = [[UIImageView alloc]initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, kWidth(330))];
//            attractionImgV.backgroundColor = [ColorManager RandomColor];
//            NSString *imgName = [NSString stringWithFormat:@"%@",attractionName];
//            attractionImgV.image = kGetImage(imgName);
//            [self.scrollV addSubview:attractionImgV];
//
//        }
//    }
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
