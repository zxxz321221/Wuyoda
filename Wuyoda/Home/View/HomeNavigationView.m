//
//  HomeNavigationView.m
//  Wuyoda
//
//  Created by 赵祥 on 2022/5/20.
//

#import "HomeNavigationView.h"
#import "ClassicalViewController.h"
#import "SearchViewController.h"

@implementation HomeNavigationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    UIView *searchV = [[UIView alloc]init];
    searchV.backgroundColor = [ColorManager WhiteColor];
    searchV.layer.cornerRadius = kWidth(15);
    searchV.layer.borderColor = [ColorManager MainColor].CGColor;
    searchV.layer.borderWidth = kWidth(1);
    [self addSubview:searchV];
    [searchV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.mas_offset(kWidth(-10));
        make.width.mas_offset(kWidth(240));
        make.height.mas_offset(kWidth(30));
    }];
    
    UIImageView *searchImgV = [[UIImageView alloc]initWithImage:kGetImage(@"搜索（灰）")];
    [searchV addSubview:searchImgV];
    [searchImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(searchV);
        make.left.mas_offset(kWidth(10));
        make.width.height.mas_offset(kWidth(18));
    }];
    
    UILabel *searchLab = [[UILabel alloc]init];
    searchLab.text = @"请输入要搜索的商品名称";
    searchLab.textColor = [ColorManager Color999999];
    searchLab.font = kFont(14);
    [searchV addSubview:searchLab];
    [searchLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(searchV);
        make.left.equalTo(searchImgV.mas_right).mas_offset(kWidth(18));
    }];
    
    UIButton *searchBtn = [[UIButton alloc]init];
    [searchBtn addTarget:self action:@selector(searchClicked) forControlEvents:UIControlEventTouchUpInside];
    [searchV addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.height.equalTo(searchV);
    }];
    
    self.classBtn = [[UIButton alloc]init];
//    [self.classBtn setTitle:@"分类" forState:UIControlStateNormal];
//    [self.classBtn setTitleColor:[ColorManager MainColor] forState:UIControlStateNormal];
//    self.classBtn.titleLabel.font = kFont(14);
    [self.classBtn setImage:kGetImage(@"首页分类") forState:UIControlStateNormal];
    [self.classBtn addTarget:self action:@selector(classicalClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.classBtn];
    [self.classBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(searchV);
        make.left.mas_offset(kWidth(15));
        make.width.mas_offset(kWidth(40));

        make.height.mas_offset(kWidth(20));
//        make.width.height.mas_offset(kWidth(25));
    }];
    
    self.shopCartBtn = [[UIButton alloc]init];
    [self.shopCartBtn setImage:kGetImage(@"首页顶部购物车") forState:UIControlStateNormal];
    [self.shopCartBtn addTarget:self action:@selector(shopCartClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.shopCartBtn];
    [self.shopCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(searchV);
        make.right.mas_offset(kWidth(-20));
        make.width.height.mas_offset(kWidth(20));
    }];
    
}

-(void)classicalClicked{
    ClassicalViewController *vc = [[ClassicalViewController alloc]init];
    [self.CurrentViewController.navigationController pushViewController:vc animated:YES];
}

-(void)searchClicked{
    SearchViewController *vc = [[SearchViewController alloc]init];
    [self.CurrentViewController.navigationController pushViewController:vc animated:YES];
}

-(void)shopCartClicked{
    if ([CommonManager isLogin:self.CurrentViewController isPush:YES]) {
        [self.CurrentViewController.tabBarController setSelectedIndex:2];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
