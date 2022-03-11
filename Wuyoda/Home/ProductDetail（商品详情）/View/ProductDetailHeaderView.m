//
//  ProductDetailHeaderView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/15.
//

#import "ProductDetailHeaderView.h"
#import "BannerModel.h"
#import "BannerImageView.h"

@interface ProductDetailHeaderView ()<SDCycleScrollViewDelegate>

//@property (nonatomic , retain)UIImageView *productImgV;
@property (nonatomic , retain)UIButton *likeBtn;

@property (nonatomic , retain)UILabel *typeLab;
@property (nonatomic , retain)UILabel *typeIntroLab;
@property (nonatomic , retain)UILabel *titleLab;

@property (nonatomic , retain)UIView *labBGView;

@property (nonatomic , retain)UILabel *discountLab;
@property (nonatomic , retain)UILabel *discountIntroLab;

@property (nonatomic , retain)NSMutableArray *goodsStatusArr;

@property (nonatomic , retain)NSMutableArray *otherStatusArr;

@property (nonatomic , retain)NSArray *bannerArr;
@property (nonatomic, strong) UIView *bannerBGView;
@property (nonatomic, strong) SDCycleScrollView *banner;

@end

@implementation ProductDetailHeaderView

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
    
    self.bannerBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(330))];
    [self addSubview:self.bannerBGView];
    
    
    
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setImage:kGetImage(@"商品详情_关闭") forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.mas_offset(kHeight_StatusBar+kWidth(23));
        make.width.height.mas_offset(kWidth(32));
    }];
    
    self.likeBtn = [[UIButton alloc]init];
    [self.likeBtn setImage:kGetImage(@"商品详情_收藏") forState:UIControlStateNormal];
    [self.likeBtn setImage:kGetImage(@"商品详情_收藏选中") forState:UIControlStateSelected];
    [self.likeBtn addTarget:self action:@selector(likeProductClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.likeBtn];
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-20));
        make.top.mas_offset(kHeight_StatusBar+kWidth(23));
        make.width.height.mas_offset(kWidth(32));
    }];
    
    UIButton *shareBtn = [[UIButton alloc]init];
    [shareBtn setImage:kGetImage(@"商品详情_分享") forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:shareBtn];
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.likeBtn.mas_left).mas_offset(kWidth(-12));
        make.top.mas_offset(kHeight_StatusBar+kWidth(23));
        make.width.height.mas_offset(kWidth(32));
    }];
    
//    UIImageView *typeImgV = [[UIImageView alloc]initWithImage:kGetImage(@"商品详情_标签")];
//    [self addSubview:typeImgV];
//    [typeImgV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(kWidth(20));
//        make.top.equalTo(self.bannerBGView.mas_bottom).mas_offset(kWidth(18));
//        make.width.height.mas_offset(kWidth(16));
//    }];
//
//    self.typeLab = [[UILabel alloc]init];
//    self.typeLab.text = @"传统荫油";
//    self.typeLab.textColor = [ColorManager BlackColor];
//    self.typeLab.font = kFont(14);
//    [self addSubview:self.typeLab];
//    [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(typeImgV);
//        make.left.equalTo(typeImgV.mas_right).mas_offset(kWidth(13));
//    }];
//
//    self.typeIntroLab = [[UILabel alloc]init];
//    self.typeIntroLab.text = @"一甲子的浓郁酿造工艺";
//    self.typeIntroLab.textColor = [ColorManager Color0300BF];
//    self.typeIntroLab.font = kFont(14);
//    [self addSubview:self.typeIntroLab];
//    [self.typeIntroLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(typeImgV);
//        make.left.equalTo(self.typeLab.mas_right).mas_offset(kWidth(16));
//        make.right.mas_offset(kWidth(-20));
//    }];
    
    self.titleLab = [[UILabel alloc]init];
    //self.titleLab.text = @"【酱职人】国产黑豆荫油礼盒组 【Sauce Craftsman】Taiwan Black Bean Sauce Gift Box";
    self.titleLab.textColor = [ColorManager BlackColor];
    self.titleLab.font = kFont(18);
    self.titleLab.numberOfLines = 0;
    self.titleLab.lineBreakMode = NSLineBreakByWordWrapping;
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bannerBGView.mas_bottom).mas_offset(kWidth(18));
        make.left.mas_offset(kWidth(20));
        make.right.mas_offset(kWidth(-20));
    }];
    
    //[self layoutIfNeeded];
    
    self.labBGView = [[UIView alloc]initWithFrame:CGRectMake(kWidth(20), self.titleLab.frame.origin.y+self.titleLab.frame.size.height+kWidth(16), kWidth(335), 1)];
    self.labBGView.backgroundColor = [ColorManager WhiteColor];
    [self addSubview:self.labBGView];
    
    UIView *lineV = [[UIView alloc]init];
    lineV.backgroundColor = [ColorManager ColorAAAAAA];
    [self addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self);
        //make.top.equalTo(self.labBGView.mas_bottom).mas_offset(kWidth(20));
        make.height.mas_offset(kWidth(1));
        make.bottom.equalTo(self);
    }];
    
//    self.discountLab = [[UILabel alloc]init];
//    self.discountLab.text = @"享受8月31日- 11月30日期间的9.8折优惠";
//    self.discountLab.textColor = [ColorManager BlackColor];
//    self.discountLab.font = kBoldFont(14);
//    [self addSubview:self.discountLab];
//    [self.discountLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(lineV.mas_bottom).mas_offset(kWidth(20));
//        make.left.mas_offset(kWidth(20));
//        make.right.mas_offset(kWidth(-50));
//    }];
//
//
//    self.discountIntroLab = [[UILabel alloc]init];
//    self.discountIntroLab.text = @"在84天内完成预订，锁定限时好价";
//    self.discountIntroLab.textColor = [ColorManager BlackColor];
//    self.discountIntroLab.font = kFont(14);
//    [self addSubview:self.discountIntroLab];
//    [self.discountIntroLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.discountLab.mas_bottom).mas_offset(kWidth(6));
//        make.left.mas_offset(kWidth(20));
//        make.right.mas_offset(kWidth(-20));
//    }];
//
//    UIImageView *discountImgV = [[UIImageView alloc]initWithImage:kGetImage(@"商品详情_优惠券")];
//    [self addSubview:discountImgV];
//    [discountImgV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_offset(kWidth(-22));
//        make.centerY.equalTo(self.discountLab);
//        make.width.height.mas_offset(kWidth(24));
//    }];
    
    
}

-(void)closeClicked{
    [self.CurrentViewController.navigationController popViewControllerAnimated:YES];
}

-(void)likeProductClicked:(UIButton *)sender{
    sender.selected = !sender.isSelected;
}

-(void)shareClicked:(UIButton *)sender{
    [self showHUDWithText:@"敬请期待" withYOffSet:0];
}

-(void)createTagLab{
    
    for (int i = 0; i<self.labelArr.count; i++) {
        NSString *str = [self.labelArr objectAtIndex:i];
        CGFloat strW = [LCTools widthWithString:str font:kWidth(13)];
        UILabel *lab = [[UILabel alloc]init];
        lab.text = str;
        if (i<self.goodsStatusArr.count) {
            lab.textColor = [ColorManager Color4B7A02];
            lab.backgroundColor = [ColorManager ColorE1FFCA];
        }else{
            lab.textColor = [ColorManager Color333333];
            lab.backgroundColor = [ColorManager ColorD7D7D7];
        }
        
        lab.layer.cornerRadius = kWidth(5);
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = kFont(13);
        lab.layer.masksToBounds = YES;
        if (i == 0) {
            lab.frame = CGRectMake(0, 0, strW+kWidth(12), kWidth(30));
        }else{
            UILabel *beforeLab = self.labBGView.subviews.lastObject;
            if (beforeLab.frame.origin.x+beforeLab.frame.size.width + strW+kWidth(12) > self.labBGView.size.width) {
                lab.frame = CGRectMake(0, beforeLab.frame.origin.y+kWidth(30)+kWidth(4), strW+kWidth(12), kWidth(30));
            }else{
                lab.frame = CGRectMake(beforeLab.frame.origin.x+beforeLab.frame.size.width+kWidth(4), beforeLab.origin.y, strW+kWidth(12), kWidth(30));
            }
        }
        
        [self.labBGView addSubview:lab];
    }
    
    UILabel *lastLab = self.labBGView.subviews.lastObject;
    self.labBGView.frame = CGRectMake(kWidth(20), self.labBGView.origin.y, kWidth(335), lastLab.origin.y+lastLab.height);
}

-(void)setModel:(HomeShopModel *)model{
    _model = model;
    self.titleLab.text = model.goods_name;
    [self.titleLab layoutIfNeeded];
    //[self.productImgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.goods_file1]]];
    self.labBGView.frame = CGRectMake(kWidth(20), self.titleLab.frame.origin.y+self.titleLab.frame.size.height+kWidth(30), kWidth(335), 1);
    
    self.bannerArr = [BannerModel mj_objectArrayWithKeyValuesArray:model.gallery];
    self.goodsStatusArr = [[NSMutableArray alloc]init];
    self.otherStatusArr = [[NSMutableArray alloc]init];
    if ([model.goods_status isEqualToString:@"1"]) {
        [self.goodsStatusArr addObject:@"热门"];
    }else if ([model.goods_status isEqualToString:@"2"]){
        [self.goodsStatusArr addObject:@"推荐"];
    }else if ([model.goods_status isEqualToString:@"3"]){
        [self.goodsStatusArr addObject:@"热门"];
        [self.goodsStatusArr addObject:@"推荐"];
    }else if ([model.goods_status isEqualToString:@"4"]){
        [self.goodsStatusArr addObject:@"免邮"];
    }else if ([model.goods_status isEqualToString:@"5"]){
        [self.goodsStatusArr addObject:@"热门"];
        [self.goodsStatusArr addObject:@"免邮"];
    }else if ([model.goods_status isEqualToString:@"6"]){
        [self.goodsStatusArr addObject:@"推荐"];
        [self.goodsStatusArr addObject:@"免邮"];
    }else if ([model.goods_status isEqualToString:@"6"]){
        [self.goodsStatusArr addObject:@"热门"];
        [self.goodsStatusArr addObject:@"推荐"];
        [self.goodsStatusArr addObject:@"免邮"];
    }
    
    if ([model.twmp isEqualToString:@"6"]) {
        [self.otherStatusArr addObject:@"台湾名品"];
    }
    if ([model.bdlh isEqualToString:@"7"]) {
        [self.otherStatusArr addObject:@"宝岛礼盒"];
    }
    if ([model.thsp isEqualToString:@"8"]) {
        [self.otherStatusArr addObject:@"特惠商品"];
    }
    if ([model.ddp isEqualToString:@"5"]) {
        [self.otherStatusArr addObject:@"对对碰"];
    }
    
    self.labelArr = [[NSMutableArray alloc]init];
    [self.labelArr addObjectsFromArray:self.goodsStatusArr];
    [self.labelArr addObjectsFromArray:self.otherStatusArr];
    [self createTagLab];
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
    self.banner.autoScrollTimeInterval = 3;
    self.banner.showPageControl = NO;
//    self.banner.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
//    self.banner.pageControlBottomOffset = kWidth(10);
//    self.banner.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
//    self.banner.pageDotImage = kGetImage(@"Home_pageNoSe");
//    self.banner.currentPageDotImage = kGetImage(@"Home_pageSe");
    self.banner.spacingBetweenDots = kWidth(5);
    self.banner.pageControlDotSize = CGSizeMake(kWidth(10), kWidth(5));
    self.banner.backgroundColor = [UIColor whiteColor];
    self.banner.placeholderImage = kGetImage(@"发现长条占位图");
    self.banner.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    self.banner.clipsToBounds = YES;
    self.banner.backgroundColor = [ColorManager ColorF2F2F2];
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
