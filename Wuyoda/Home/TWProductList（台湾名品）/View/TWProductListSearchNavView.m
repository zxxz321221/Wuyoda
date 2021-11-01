//
//  TWProductListSearchNavView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/17.
//

#import "TWProductListSearchNavView.h"

@implementation TWProductListSearchNavView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    UIView *searchBGView = [[UIView alloc]init];
    searchBGView.backgroundColor = [ColorManager WhiteColor];
    searchBGView.layer.borderWidth = 1;
    searchBGView.layer.borderColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.00].CGColor;
    // Shadow Code
    searchBGView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.15].CGColor;
    searchBGView.layer.shadowOffset = CGSizeMake(0,3);
    searchBGView.layer.shadowRadius = 6;
    searchBGView.layer.shadowOpacity = 1;
    // Radius Code
    searchBGView.layer.cornerRadius = 2;
    [self addSubview:searchBGView];
    [searchBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.mas_offset(kWidth(-6));
        make.width.mas_offset(kWidth(335));
        make.height.mas_offset(kWidth(46));
    }];
    
    UIButton *backBtn = [[UIButton alloc]init];
    [backBtn setImage:kGetImage(@"返回") forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    [searchBGView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(12));
        make.centerY.equalTo(searchBGView);
        make.width.height.mas_offset(kWidth(16));
    }];
    
    UIButton *addressBtn = [[UIButton alloc]init];
    [addressBtn setTitle:@"台北市" forState:UIControlStateNormal];
    [addressBtn setTitleColor:[ColorManager MainColor] forState:UIControlStateNormal];
    addressBtn.titleLabel.font = kFont(14);
    [searchBGView addSubview:addressBtn];
    [addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backBtn.mas_right).mas_offset(kWidth(3));
        make.centerY.height.equalTo(searchBGView);
        make.width.mas_offset(kWidth(70));
    }];
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [ColorManager ColorAAAAAA];
    [searchBGView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(searchBGView);
        make.width.mas_offset(1);
        make.left.mas_offset(kWidth(100));
    }];
    
    self.searField = [[UITextField alloc]init];
    self.searField.textColor = [ColorManager BlackColor];
    self.searField.placeholder = @"景点/商品/品牌名";
    self.searField.font = kFont(14);
    self.searField.returnKeyType = UIReturnKeySearch;
    [searchBGView addSubview:self.searField];
    [self.searField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(118));
        make.right.mas_offset(kWidth(-20));
        make.centerY.height.equalTo(searchBGView);
    }];
}

-(void)backClicked{
    [self.CurrentViewController.navigationController popViewControllerAnimated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
