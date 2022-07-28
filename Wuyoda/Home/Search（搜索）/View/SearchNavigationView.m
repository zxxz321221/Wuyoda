//
//  SearchNavigationView.m
//  Wuyoda
//
//  Created by 赵祥 on 2022/5/24.
//

#import "SearchNavigationView.h"
#import "TWProductListViewController.h"

@interface SearchNavigationView ()

@property (nonatomic , retain)UIButton *backBtn;



@end

@implementation SearchNavigationView

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
    
    self.searchField = [[UITextField alloc]init];
    self.searchField.placeholder = @"请输入要搜索的商品名称";
    self.searchField.textColor = [ColorManager Color333333];
    self.searchField.font = kFont(14);
    self.searchField.returnKeyType = UIReturnKeySearch;
    [searchV addSubview:self.searchField];
    [self.searchField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(searchV);
        make.left.equalTo(searchImgV.mas_right).mas_offset(kWidth(18));
        make.right.mas_offset(kWidth(-10));
    }];
    
    
    self.backBtn = [[UIButton alloc]init];
    [self.backBtn setImage:kGetImage(@"返回") forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(searchV);
        make.left.mas_offset(kWidth(20));
        make.width.height.mas_offset(kWidth(16));
    }];
    
    self.searchBtn = [[UIButton alloc]init];
    [self.searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [self.searchBtn setTitleColor:[ColorManager Color333333] forState:UIControlStateNormal];
    self.searchBtn.titleLabel.font = kFont(16);
    [self.searchBtn addTarget:self action:@selector(searchClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.searchBtn];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(searchV);
        make.right.mas_offset(kWidth(-20));
        make.width.mas_offset(kWidth(35));
        make.height.mas_offset(kWidth(20));
    }];
    
    self.shopCartBtn = [[UIButton alloc]init];
    [self.shopCartBtn setImage:kGetImage(@"首页顶部购物车") forState:UIControlStateNormal];
    self.shopCartBtn.titleLabel.font = kFont(16);
    [self.shopCartBtn addTarget:self action:@selector(shopCartClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.shopCartBtn];
    [self.shopCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(searchV);
        make.right.mas_offset(kWidth(-20));
        make.width.height.mas_offset(kWidth(20));
    }];
    
}

-(void)backClicked{
    [self.CurrentViewController.navigationController popViewControllerAnimated:YES];
}

-(void)searchClicked{
    if (self.searchField.text.length) {
        TWProductListViewController *vc = [[TWProductListViewController alloc]init];
        vc.type = @"1";
        vc.searchStr = self.searchField.text;
        [self.CurrentViewController.navigationController pushViewController:vc animated:YES];
    }
    
}

-(void)shopCartClicked{
    if ([CommonManager isLogin:self.CurrentViewController isPush:YES]) {
        [self.CurrentViewController.tabBarController setSelectedIndex:2];
        [self.CurrentViewController.navigationController popToViewController:self.CurrentViewController.navigationController.viewControllers.firstObject animated:NO];
    }
    
    
}

-(void)setType:(NSString *)type{
    _type = type;
    
    if ([type isEqualToString:@"1"]) {
        self.shopCartBtn.hidden = YES;
    }else{
        self.searchBtn.hidden = YES;
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
