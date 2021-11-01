//
//  HomeTableHeaderView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/13.
//

#import "HomeTableHeaderView.h"
#import "HomeAddressView.h"
#import "HomeSearchCityViewController.h"
#import "TWProductListViewController.h"
#import "PreferentialGoodListViewController.h"

@interface HomeTableHeaderView ()

@property (nonatomic , retain)UIImageView *topBGImgV;
@property (nonatomic , retain)UILabel *titleLab;
@property (nonatomic , retain)UIButton *liveBtn;

@property (nonatomic , retain)HomeAddressView *addressView;

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
    
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.text = @"与宝岛美丽的邂逅";
    self.titleLab.textColor = [ColorManager WhiteColor];
    self.titleLab.font = kBoldFont(26);
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(30));
        make.top.mas_offset(kWidth(90));
    }];
    
    self.liveBtn = [[UIButton alloc]init];
    [self.liveBtn setTitle:@"直播台湾特产抢先看" forState:UIControlStateNormal];
    [self.liveBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    self.liveBtn.titleLabel.font = kFont(16);
    self.liveBtn.layer.cornerRadius = kWidth(5);
    self.liveBtn.layer.borderColor = [ColorManager WhiteColor].CGColor;
    self.liveBtn.layer.borderWidth = kWidth(1);
    [self addSubview:self.liveBtn];
    [self.liveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(30));
        make.top.equalTo(self.titleLab.mas_bottom).mas_offset(kWidth(15));
        make.width.mas_offset(kWidth(157));
        make.height.mas_offset(kWidth(37));
    }];
    
    UIImageView *bottomImgV = [[UIImageView alloc]initWithImage:kGetImage(@"首页_顶部弧形")];
    [self addSubview:bottomImgV];
    [bottomImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(kWidth(285));
            make.left.right.bottom.equalTo(self);
    }];
    
    self.addressView = [[HomeAddressView alloc]init];
    self.addressView.layer.cornerRadius = kWidth(15);
    [self addSubview:self.addressView];
    [self.addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.mas_offset(kWidth(182));
        make.width.mas_offset(kWidth(335));
        make.height.mas_offset(kWidth(248));
    }];
    
    NSArray *itemArr = [[NSArray alloc]initWithObjects:@"台湾名品",@"宝岛礼盒",@"最新消息",@"特惠商品",@"线上客服", nil];
    for (int i = 0; i<itemArr.count; i++) {
        NSString *itemStr= [itemArr objectAtIndex:i];
        UIView *itemV = [[UIView alloc]initWithFrame:CGRectMake(kWidth(24)+(kWidth(48)+kWidth(22))*i, kWidth(462), kWidth(48), kWidth(60))];
        [self addSubview:itemV];
        
        UIButton *itemBtn = [[UIButton alloc]initWithFrame:itemV.bounds];
        itemBtn.tag = i*100;
        [itemBtn addTarget:self action:@selector(itemSelectedClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        UIImageView *imgV = [[UIImageView alloc]initWithImage:kGetImage(itemStr)];
        imgV.userInteractionEnabled = YES;
        [itemV addSubview:imgV];
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(itemV);
            make.width.mas_offset(kWidth(30));
            make.height.mas_offset(kWidth(32));
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
        [self.CurrentViewController.navigationController pushViewController:vc animated:YES];
    }
    if (sender.tag == 100) {
        TWProductListViewController *vc = [[TWProductListViewController alloc]init];
        vc.type = @"3";
        [self.CurrentViewController.navigationController pushViewController:vc animated:YES];
    }
    if (sender.tag == 200) {
//        TWProductListViewController *vc = [[TWProductListViewController alloc]init];
//        vc.type = @"3";
//        [self.CurrentViewController.navigationController pushViewController:vc animated:YES];
    }
    if (sender.tag == 300) {
        PreferentialGoodListViewController *vc = [[PreferentialGoodListViewController alloc]init];
        [self.CurrentViewController.navigationController pushViewController:vc animated:YES];
    }
    if (sender.tag == 400) {

    }
}

-(void)setCurrentCity:(NSString *)currentCity{
    _currentCity = currentCity;
    self.addressView.currentCity = currentCity;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
