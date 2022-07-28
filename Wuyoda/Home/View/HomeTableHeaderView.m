//
//  HomeTableHeaderView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/13.
//

#import "HomeTableHeaderView.h"
//#import "HomeAddressView.h"
#import "HomeSearchCityViewController.h"
#import "TWProductListViewController.h"
#import "PreferentialGoodListViewController.h"
#import "MessageViewController.h"
#import "HomeNavigationView.h"
#import "HomeExpressView.h"

@interface HomeTableHeaderView ()

@property (nonatomic , retain)UIImageView *topBGImgV;
//@property (nonatomic , retain)UILabel *titleLab;
//@property (nonatomic , retain)UIButton *liveBtn;

//@property (nonatomic , retain)HomeAddressView *addressView;

@property (nonatomic , retain)HomeNavigationView *nav;
@property (nonatomic , retain)HomeExpressView *expressV;

@end

@implementation HomeTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.topBGImgV = [[UIImageView alloc]initWithImage:kGetImage(@"home_top")];
    [self addSubview:self.topBGImgV];
    [self.topBGImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(0);
        make.width.height.mas_offset(kWidth(375));
    }];
    
//    self.titleLab = [[UILabel alloc]init];
//    self.titleLab.text = @"与宝岛美丽的邂逅";
//    self.titleLab.textColor = [ColorManager WhiteColor];
//    self.titleLab.font = kBoldFont(26);
//    [self addSubview:self.titleLab];
//    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(kWidth(30));
//        make.top.mas_offset(kWidth(90));
//    }];
//
//    self.liveBtn = [[UIButton alloc]init];
//    [self.liveBtn setTitle:@"直播台湾特产抢先看" forState:UIControlStateNormal];
//    [self.liveBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
//    self.liveBtn.titleLabel.font = kFont(16);
//    self.liveBtn.layer.cornerRadius = kWidth(5);
//    self.liveBtn.layer.borderColor = [ColorManager WhiteColor].CGColor;
//    self.liveBtn.layer.borderWidth = kWidth(1);
//    //[self.liveBtn addTarget:self action:@selector(liveClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:self.liveBtn];
//    [self.liveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(kWidth(30));
//        make.top.equalTo(self.titleLab.mas_bottom).mas_offset(kWidth(15));
//        make.width.mas_offset(kWidth(157));
//        make.height.mas_offset(kWidth(37));
//    }];
    
    UIImageView *bottomImgV = [[UIImageView alloc]initWithImage:kGetImage(@"首页_顶部弧形")];
    [self addSubview:bottomImgV];
    [bottomImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(kWidth(235));
            make.left.right.bottom.equalTo(self);
    }];
    
//    self.addressView = [[HomeAddressView alloc]init];
//    self.addressView.layer.cornerRadius = kWidth(15);
//    [self addSubview:self.addressView];
//    [self.addressView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self);
//        make.top.mas_offset(kWidth(182));
//        make.width.mas_offset(kWidth(335));
//        make.height.mas_offset(kWidth(248));
//    }];
    
    self.nav = [[HomeNavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar)];
    [self addSubview:self.nav];
    
    self.expressV = [[HomeExpressView alloc]initWithFrame:CGRectMake(kWidth(20), kWidth(10)+kHeight_NavBar, kWidth(336), kWidth(210))];
    [self addSubview:self.expressV];
    
    NSArray *itemArr = [[NSArray alloc]initWithObjects:@"人气美食",@"特色商品",@"最新消息",@"特惠商品",@"线上客服", nil];
    for (int i = 0; i<itemArr.count; i++) {
        NSString *itemStr= [itemArr objectAtIndex:i];
        //UIView *itemV = [[UIView alloc]initWithFrame:CGRectMake(kWidth(24)+(kWidth(48)+kWidth(22))*i, kWidth(462), kWidth(48), kWidth(60))];
        UIView *itemV = [[UIView alloc]initWithFrame:CGRectMake(kWidth(30)+(kWidth(30)+kWidth(40))*i, kWidth(343), kWidth(40), kWidth(60))];
        if (!kHeight_SafeArea) {
            itemV.frame = CGRectMake(kWidth(30)+(kWidth(30)+kWidth(40))*i, kWidth(323), kWidth(40), kWidth(60));
        }
        [self addSubview:itemV];
        
        UIButton *itemBtn = [[UIButton alloc]initWithFrame:itemV.bounds];
        itemBtn.tag = i*100;
        [itemBtn addTarget:self action:@selector(itemSelectedClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *imgV = [[UIImageView alloc]initWithImage:kGetImage(itemStr)];
        imgV.userInteractionEnabled = YES;
        [itemV addSubview:imgV];
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(itemV);
            make.width.mas_offset(kWidth(33));
            make.height.mas_offset(kWidth(33));
        }];
        
        UILabel *itemLab = [[UILabel alloc]init];
        itemLab.text = itemStr;
        itemLab.textColor = [ColorManager BlackColor];
        itemLab.font = kFont(10);
        itemLab.userInteractionEnabled = YES;
        [itemV addSubview:itemLab];
        [itemLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.centerX.equalTo(itemV);
        }];
        
        [itemV addSubview:itemBtn];
    }
    
    
}


-(void)itemSelectedClicked:(UIButton *)sender{
    if (sender.tag == 0) {
        TWProductListViewController *vc = [[TWProductListViewController alloc]init];
        vc.type = @"2";
        vc.allCityArr = self.allCityArr;
        vc.currentCity = self.currentCity;
        [self.CurrentViewController.navigationController pushViewController:vc animated:YES];
    }
    if (sender.tag == 100) {
        TWProductListViewController *vc = [[TWProductListViewController alloc]init];
        vc.type = @"3";
        vc.allCityArr = self.allCityArr;
        vc.currentCity = self.currentCity;
        [self.CurrentViewController.navigationController pushViewController:vc animated:YES];
    }
    if (sender.tag == 200) {
//        TWProductListViewController *vc = [[TWProductListViewController alloc]init];
//        vc.type = @"3";
//        [self.CurrentViewController.navigationController pushViewController:vc animated:YES];
        MessageViewController *vc = [[MessageViewController alloc]init];
        [self.CurrentViewController.navigationController pushViewController:vc animated:YES];
    }
    if (sender.tag == 300) {
        PreferentialGoodListViewController *vc = [[PreferentialGoodListViewController alloc]init];
        [self.CurrentViewController.navigationController pushViewController:vc animated:YES];
    }
    if (sender.tag == 400) {
        FJWebViewController *vc = [[FJWebViewController alloc]init];
        vc.url = @"http://new.wuyoda.com/public/help/wuyoda_help.html";
        [self.CurrentViewController.navigationController pushViewController:vc animated:YES];
    }
}

//-(void)setCurrentCity:(NSString *)currentCity{
//    _currentCity = currentCity;
//    self.addressView.currentCity = currentCity;
//}
//
//-(void)setHotCityArr:(NSMutableArray *)hotCityArr{
//    _hotCityArr = hotCityArr;
//    self.addressView.hotCityArr = hotCityArr;
//}
//-(void)setAllCityArr:(NSArray *)allCityArr{
//    _allCityArr = allCityArr;
//    self.addressView.allCityArr = allCityArr;
//}
//-(void)liveClicked:(id)sender{
//    [self showHUDWithText:@"敬请期待" withYOffSet:0];
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
