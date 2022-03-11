//
//  PayViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/28.
//

#import "PayViewController.h"
#import "PaySuccessViewController.h"
#import "ShopCartModel.h"
#import "PayModel.h"
#import "PayInfoViewController.h"
#import "PayInfoModel.h"

@interface PayViewController ()

@property (nonatomic , retain)PayModel *payModel;

@property (nonatomic , retain)UILabel *priceLab;

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"确认付款"];
    [self.view addSubview:nav];
    
    UIView *topV = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kWidth(148))];
    [self.view addSubview:topV];
    
    UILabel *topTitleLab = [[UILabel alloc]init];
    topTitleLab.text = @"付款金额";
    topTitleLab.textColor = [ColorManager BlackColor];
    topTitleLab.font = kFont(14);
    [topV addSubview:topTitleLab];
    [topTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(kWidth(15));
    }];
    
    UILabel *priceLab = [[UILabel alloc]init];
    priceLab.text = @"￥0";
    priceLab.textColor = [ColorManager BlackColor];
    priceLab.font = kFont(36);
    self.priceLab = priceLab;
    [topV addSubview:priceLab];
    [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topV);
        make.top.mas_offset(kWidth(46));
    }];
    
    
    UIView *payTypeView = [[UIView alloc]initWithFrame:CGRectMake(0, kWidth(158)+kHeight_NavBar, kScreenWidth, kWidth(52))];
    [self.view addSubview:payTypeView];
    
    UILabel *payTitleTypeLab = [[UILabel alloc]init];
    payTitleTypeLab.text = @"付款方式";
    payTitleTypeLab.textColor = [ColorManager Color333333];
    payTitleTypeLab.font = kFont(14);
    [payTypeView addSubview:payTitleTypeLab];
    [payTitleTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(24));
        make.centerY.equalTo(payTypeView);
    }];
    
    UIImageView *arrowImgV = [[UIImageView alloc]initWithImage:kGetImage(@"")];
    [payTypeView addSubview:arrowImgV];
    [arrowImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-24));
        make.centerY.equalTo(payTypeView);
        make.width.height.mas_offset(kWidth(12));
    }];
    
    UILabel *payTypeLab = [[UILabel alloc]init];
    payTypeLab.text = @"信用卡";
    payTypeLab.textColor = [ColorManager ColorD7D7D7];
    payTypeLab.font = kFont(14);
    [payTypeView addSubview:payTypeLab];
    [payTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(arrowImgV.mas_left).mas_offset(kWidth(-8));
        make.centerY.equalTo(payTypeView);
    }];
    
    UIButton *payBtn = [[UIButton alloc]init];
    [payBtn setTitle:@"保存" forState:UIControlStateNormal];
    [payBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    payBtn.titleLabel.font = kFont(14);
    payBtn.backgroundColor = [ColorManager MainColor];
    payBtn.layer.cornerRadius = kWidth(21);
    [payBtn addTarget:self action:@selector(payClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payBtn];
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(payTypeView.mas_bottom).mas_offset(kWidth(63));
        make.width.mas_offset(kWidth(350));
        make.height.mas_offset(kWidth(42));
    }];
    
    [self getDataFromServer];
}

-(void)getDataFromServer{
    
    NSArray *allKeys = [self.cartListDic allKeys];
    NSMutableDictionary *cartIdDic = [[NSMutableDictionary alloc]init];
    for (int i = 0; i<allKeys.count; i++) {
        NSArray *goodsArr = [self.cartListDic objectForKey:allKeys[i]];
        NSArray *goodsModelArr = [ShopCartModel mj_objectArrayWithKeyValuesArray:goodsArr];
        NSString *idStr = @"";
        for (int j = 0; j<goodsModelArr.count; j++) {
            ShopCartModel *model = [goodsModelArr objectAtIndex:j];
            if (j == 0) {
                idStr = model.uid;
            }else{
                idStr = [idStr stringByAppendingFormat:@",%@",model.uid];
            }
            [cartIdDic setObject:idStr forKey:allKeys[i]];
        }
    }
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:cartIdDic options:NSJSONWritingPrettyPrinted error:nil];
        
    NSString * cart_uid = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary *dic = @{@"m_id":[UserInfoModel getUserInfoModel].member_id,@"cart_uid":cart_uid,@"memo":self.memo,@"fare":self.fare,@"addressid":self.addressid,@"api_token":[RegisterModel getUserInfoModel].user_token};
    
    [FJNetTool postWithParams:dic url:Special_order_create loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            self.payModel = [PayModel mj_objectWithKeyValues:[responseObject[@"data"] firstObject]];
            self.priceLab.text = [NSString stringWithFormat:@"￥%.2f",[self.payModel.total_price floatValue]];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)payClicked{
//    PaySuccessViewController *vc = [[PaySuccessViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
    NSDictionary *dic = @{@"ordersn":self.payModel.ordersn,@"m_id":[UserInfoModel getUserInfoModel].member_id,@"api_token":[RegisterModel getUserInfoModel].user_token};
    
    [FJNetTool postWithParams:dic url:Special_order_pay loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            PayInfoModel *model = [PayInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
            PayInfoViewController *vc = [[PayInfoViewController alloc]init];
            vc.payInfoModel = model;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } failure:^(NSError *error) {
        
    }];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
