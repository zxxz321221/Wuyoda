//
//  AttractionsListNavView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/18.
//

#import "AttractionsListNavView.h"

@implementation AttractionsListNavView

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
    
    self.searchField = [[UITextField alloc]init];
    self.searchField.textColor = [ColorManager BlackColor];
    self.searchField.placeholder = @"请输入景点名称";
    self.searchField.font = kFont(14);
    self.searchField.backgroundColor = [ColorManager ColorF2F2F2];
    self.searchField.layer.cornerRadius = kWidth(5);
    
    UIImageView *leftV = [[UIImageView alloc]initWithImage:kGetImage(@"定位")];
    self.searchField.leftView = leftV;
    self.searchField.leftViewMode = UITextFieldViewModeAlways;
    
    [self addSubview:self.searchField];
    [self.searchField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-20));
        make.bottom.mas_offset(kWidth(-12));
        make.width.mas_offset(kWidth(300));
        make.height.mas_offset(kWidth(36));
    }];
    
    UIButton *backBtn = [[UIButton alloc]init];
    [backBtn setImage:kGetImage(@"返回") forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.centerY.equalTo(self.searchField);
        make.width.height.mas_offset(kWidth(16));
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
