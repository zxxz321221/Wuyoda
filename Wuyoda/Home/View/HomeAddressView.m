//
//  HomeAddressView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/13.
//

#import "HomeAddressView.h"
#import "HomeSearchCityViewController.h"
#import "TWProductListViewController.h"

@interface HomeAddressView ()<HomeSearchCitySelectDelegate,UITextFieldDelegate>

@property (nonatomic , retain)UIButton *localBtn;
@property (nonatomic , retain)UIButton *internationalBtn;

@property (nonatomic , retain)UIButton *addressBtn;
@property (nonatomic , retain)UIView *currentAddressView;

@property (nonatomic , retain)UITextField *searchField;

@end

@implementation HomeAddressView

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
    self.localBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kWidth(168), kWidth(40))];
    [self.localBtn setTitle:@"台湾" forState:UIControlStateNormal];
    [self.localBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
    self.localBtn.titleLabel.font = kFont(12);
    self.localBtn.backgroundColor = [ColorManager WhiteColor];
    [self.localBtn addTarget:self action:@selector(changeAreaClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.localBtn];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.localBtn.bounds byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(kWidth(15), kWidth(15))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame =  self.localBtn.bounds;
    maskLayer.path = maskPath.CGPath;
    self.localBtn.layer.mask = maskLayer;
    
    self.internationalBtn = [[UIButton alloc]initWithFrame:CGRectMake(kWidth(168), 0, kWidth(168), kWidth(40))];
    [self.internationalBtn setTitle:@"国际/韩国" forState:UIControlStateNormal];
    [self.internationalBtn setTitleColor:[ColorManager Color7F7F7F] forState:UIControlStateNormal];
    self.internationalBtn.titleLabel.font = kFont(12);
    self.internationalBtn.backgroundColor = [ColorManager ColorF7F7F7];
    [self.internationalBtn addTarget:self action:@selector(changeAreaClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.internationalBtn];
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:self.internationalBtn.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomLeft cornerRadii:CGSizeMake(kWidth(15), kWidth(15))];
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame =  self.localBtn.bounds;
    maskLayer1.path = maskPath1.CGPath;
    self.internationalBtn.layer.mask = maskLayer1;
    
    self.addressBtn = [[UIButton alloc]init];
    [self.addressBtn setTitle:@"台北市" forState:UIControlStateNormal];
    [self.addressBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
    self.addressBtn.titleLabel.font = kFont(16);
    self.addressBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.addressBtn addTarget:self action:@selector(addressBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.addressBtn];
    [self.addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(24));
        make.top.mas_offset(kWidth(56));
        make.width.mas_offset(kWidth(150));
        make.height.mas_offset(kWidth(36));
    }];
    
    self.currentAddressView = [[UIView alloc]init];
    [self addSubview:self.currentAddressView];
    [self.currentAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(self.addressBtn);
        make.right.mas_offset(kWidth(-24));
        make.width.mas_offset(kWidth(72));
    }];
    
    UILabel *currentLab = [[UILabel alloc]init];
    currentLab.text = @"当前位置";
    currentLab.textColor = [ColorManager BlackColor];
    currentLab.font = kFont(12);
    [self.currentAddressView addSubview:currentLab];
    [currentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.centerY.mas_offset(kWidth(0));
    }];
    UIImageView *currenImgV = [[UIImageView alloc]initWithImage:kGetImage(@"定位")];
    [self.currentAddressView addSubview:currenImgV];
    [currenImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.mas_offset(0);
        make.width.height.mas_offset(kWidth(16));
    }];
    
    UIView *lineV1 = [[UIView alloc]init];
    lineV1.backgroundColor = [ColorManager ColorF7F7F7];
    [self addSubview:lineV1];
    [lineV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addressBtn.mas_bottom);
        make.left.mas_offset(kWidth(24));
        make.right.mas_offset(kWidth(-24));
        make.height.mas_offset(kWidth(1));
    }];
    
    self.searchField = [[UITextField alloc]init];
    self.searchField.placeholder = @"景点/特产/品牌名";
    self.searchField.textColor = [ColorManager BlackColor];
    self.searchField.font = kFont(14);
    //self.searchField.returnKeyType = UIReturnKeySearch;
    //self.searchField.delegate = self;
    [self addSubview:self.searchField];
    [self.searchField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lineV1);
        make.top.equalTo(lineV1.mas_bottom).mas_offset(kWidth(8));
        make.height.mas_offset(kWidth(36));
    }];
    
    UIView *lineV2 = [[UIView alloc]init];
    lineV2.backgroundColor = [ColorManager ColorF7F7F7];
    [self addSubview:lineV2];
    [lineV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchField.mas_bottom);
        make.left.mas_offset(kWidth(24));
        make.right.mas_offset(kWidth(-24));
        make.height.mas_offset(kWidth(1));
    }];
    
    UIButton *searchBtn = [[UIButton alloc]init];
    [searchBtn setTitle:@"搜索名品" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    searchBtn.titleLabel.font = kFont(14);
    searchBtn.backgroundColor = [ColorManager Color008A70];
    searchBtn.layer.cornerRadius = kWidth(5);
    [searchBtn addTarget:self action:@selector(searchClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lineV2);
        make.top.equalTo(self.searchField.mas_bottom).mas_offset(kWidth(8));
        make.height.mas_offset(kWidth(40));
    }];
    
    UIButton *codeSearchBtn = [[UIButton alloc]init];
    [codeSearchBtn setTitle:@"扫码搜索" forState:UIControlStateNormal];
    [codeSearchBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    codeSearchBtn.titleLabel.font = kFont(14);
    codeSearchBtn.backgroundColor = [ColorManager Color008A70];
    codeSearchBtn.layer.cornerRadius = kWidth(5);
    [codeSearchBtn setImage:kGetImage(@"扫码") forState:UIControlStateNormal];
    codeSearchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, kWidth(10));
    [codeSearchBtn addTarget:self action:@selector(codeSearchClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:codeSearchBtn];
    [codeSearchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineV2);
        make.width.mas_offset(kWidth(137));
        make.top.equalTo(searchBtn.mas_bottom).mas_offset(kWidth(8));
        make.height.mas_offset(kWidth(40));
    }];
    
    UIButton *photoSearchBtn = [[UIButton alloc]init];
    [photoSearchBtn setTitle:@"拍照搜索" forState:UIControlStateNormal];
    [photoSearchBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    photoSearchBtn.titleLabel.font = kFont(14);
    photoSearchBtn.backgroundColor = [ColorManager Color008A70];
    photoSearchBtn.layer.cornerRadius = kWidth(5);
    [photoSearchBtn setImage:kGetImage(@"拍照搜索") forState:UIControlStateNormal];
    photoSearchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, kWidth(10));
    [photoSearchBtn addTarget:self action:@selector(phoneSearchClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:photoSearchBtn];
    [photoSearchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lineV2);
        make.width.mas_offset(kWidth(137));
        make.top.equalTo(searchBtn.mas_bottom).mas_offset(kWidth(8));
        make.height.mas_offset(kWidth(40));
    }];
}

-(void)changeAreaClicked:(UIButton *)sender{
    sender.backgroundColor = [ColorManager WhiteColor];
    [sender setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
    if (sender == self.localBtn) {
        [self.internationalBtn setTitleColor:[ColorManager Color7F7F7F] forState:UIControlStateNormal];
        self.internationalBtn.backgroundColor = [ColorManager ColorF7F7F7];
    }else{
        [self.localBtn setTitleColor:[ColorManager Color7F7F7F] forState:UIControlStateNormal];
        self.localBtn.backgroundColor = [ColorManager ColorF7F7F7];
    }
}

-(void)addressBtnClicked:(id)sender{
    HomeSearchCityViewController *vc = [[HomeSearchCityViewController alloc]init];
    vc.delegate = self;
    vc.hotCityArr = self.hotCityArr;
    vc.allCityArr = self.allCityArr;
    [self.CurrentViewController.navigationController pushViewController:vc animated:YES];
}

-(void)searchClicked:(id)sender{
    if (self.searchField.text.length) {
        TWProductListViewController *vc = [[TWProductListViewController alloc]init];
        vc.type= @"1";
        vc.searchStr = self.searchField.text;
        vc.allCityArr = self.allCityArr;
        vc.currentCity = self.addressBtn.titleLabel.text;
        [self.CurrentViewController.navigationController pushViewController:vc animated:YES];
    }else{
        [self showHUDWithText:@"请输入搜索内容" withYOffSet:0];
    }
    
}

-(void)codeSearchClicked:(id)sender{
    [self showHUDWithText:@"敬请期待" withYOffSet:0];
}

-(void)phoneSearchClicked:(id)sender{
    [self showHUDWithText:@"敬请期待" withYOffSet:0];
}


-(void)selectCity:(NSString *)city{
    [self.addressBtn setTitle:city forState:UIControlStateNormal];
    NSDictionary *dic = @{@"city":city};
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeHomeCity" object:dic];
}

//-(BOOL)textFieldShouldReturn:(UITextField *)textField{
//    TWProductListViewController *vc = [[TWProductListViewController alloc]init];
//    vc.type= @"1";
//    [self.CurrentViewController.navigationController pushViewController:vc animated:YES];
//
//    return YES;
//}

-(void)setCurrentCity:(NSString *)currentCity{
    _currentCity = currentCity;
    
    [self.addressBtn setTitle:currentCity forState:UIControlStateNormal];
}

-(void)setHotCityArr:(NSArray *)hotCityArr{
    _hotCityArr = hotCityArr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
