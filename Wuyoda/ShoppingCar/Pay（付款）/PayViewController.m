//
//  PayViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/28.
//

#import "PayViewController.h"
#import "PaySuccessViewController.h"
#import "ShopCartModel.h"
#import "PayInfoViewController.h"
#import "PayInfoModel.h"
#import "PayTypeListView.h"

#import "OrderInfoViewController.h"
#import "OrderViewController.h"

@interface PayViewController ()<selectPayTypeDelegate>


@property (nonatomic , retain)UILabel *priceLab;

@property(nonatomic , copy)NSString *payType;

@property (nonatomic , retain)UILabel *payTypeLab;

@property (nonatomic ,retain)PayTypeListView *payTypeView;

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"确认付款"];
    nav.backgroundColor = [ColorManager ColorF2F2F2];
    nav.isInitBackBtn = YES;
    nav.block = ^{
        BOOL isPop = NO;
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[OrderViewController class]] || [vc isKindOfClass:[OrderInfoViewController class]]) {
                isPop = YES;
                [self.navigationController popToViewController:vc animated:YES];
                break;
            }
        }
        if (!isPop) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    };
    [self.view addSubview:nav];
    
    self.view.backgroundColor = [ColorManager ColorF2F2F2];
    
    UIView *topV = [[UIView alloc]initWithFrame:CGRectMake(kWidth(10), kHeight_NavBar+kWidth(10), kScreenWidth-kWidth(20), kWidth(148))];
    topV.backgroundColor = [ColorManager WhiteColor];
    topV.layer.cornerRadius = kWidth(10);
    [self.view addSubview:topV];
    
    UILabel *topTitleLab = [[UILabel alloc]init];
    topTitleLab.text = @"付款金额";
    topTitleLab.textColor = [ColorManager BlackColor];
    topTitleLab.font = kFont(14);
    [topV addSubview:topTitleLab];
    [topTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kWidth(15));
        make.left.mas_offset(kWidth(10));
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
    
    
    UIView *payTypeView = [[UIView alloc]initWithFrame:CGRectMake(kWidth(10), kWidth(168)+kHeight_NavBar, kScreenWidth-kWidth(20), kWidth(52))];
    payTypeView.backgroundColor = [ColorManager WhiteColor];
    payTypeView.layer.cornerRadius = kWidth(10);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPayTypeListView)];
    [payTypeView addGestureRecognizer:tap];
    payTypeView.hidden = YES;
    [self.view addSubview:payTypeView];
    
    UILabel *payTitleTypeLab = [[UILabel alloc]init];
    payTitleTypeLab.text = @"付款方式";
    payTitleTypeLab.textColor = [ColorManager Color333333];
    payTitleTypeLab.font = kFont(14);
    [payTypeView addSubview:payTitleTypeLab];
    [payTitleTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(10));
        make.centerY.equalTo(payTypeView);
    }];
    
    UIImageView *arrowImgV = [[UIImageView alloc]initWithImage:kGetImage(@"箭头_浅")];
    arrowImgV.contentMode = UIViewContentModeScaleAspectFit;
    [payTypeView addSubview:arrowImgV];
    [arrowImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-23));
        make.centerY.equalTo(payTypeView);
        make.width.height.mas_offset(kWidth(12));
    }];
    
    self.payTypeLab = [[UILabel alloc]init];
    self.payTypeLab.text = @"快捷支付";
    self.payTypeLab.textColor = [ColorManager ColorD7D7D7];
    self.payTypeLab.font = kFont(14);
    [payTypeView addSubview:self.payTypeLab];
    [self.payTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(arrowImgV.mas_left).mas_offset(kWidth(-8));
        make.centerY.equalTo(payTypeView);
    }];
    
    UIButton *payBtn = [[UIButton alloc]init];
    [payBtn setTitle:@"付款" forState:UIControlStateNormal];
    [payBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    payBtn.titleLabel.font = kFont(14);
    [payBtn setBackgroundImage:kGetImage(@"login_按钮") forState:UIControlStateNormal];;
    payBtn.layer.cornerRadius = kWidth(21);
    [payBtn addTarget:self action:@selector(payClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payBtn];
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(topV.mas_bottom).mas_offset(kWidth(47));
        make.width.mas_offset(kWidth(335));
        make.height.mas_offset(kWidth(48));
    }];
    self.payType = @"5";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkWeiXinAccount:) name:@"weixinLoginSuccess" object:nil];
    if (self.cartListDic) {
        [self getDataFromServer];
    }else if (self.payModel){
        self.priceLab.text = [NSString stringWithFormat:@"￥%.2f",[self.payModel.total_price floatValue]];
    }
    
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
        NSLog(@"Special_order_create:%@",responseObject);
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
    
    if ([self.payType isEqualToString:@"7"]) {
        SendAuthReq *req =[[SendAuthReq alloc ] init];
        req.scope = @"snsapi_userinfo";
        req.state = @"none" ;
        //第三方向微信终端发送一个SendAuthReq消息结构
        [WXApi sendReq:req completion:^(BOOL success) {
            
        }];
    }else{
        NSDictionary *dic = @{@"ordersn":self.payModel.ordersn,@"m_id":[UserInfoModel getUserInfoModel].member_id,@"api_token":[RegisterModel getUserInfoModel].user_token};
        
        [FJNetTool postWithParams:dic url:Special_order_pay loading:YES success:^(id responseObject) {
            BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
            if ([baseModel.code isEqualToString:CODE0]) {
                PayInfoModel *model = [PayInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
                PayInfoViewController *vc = [[PayInfoViewController alloc]init];
                vc.payInfoModel = model;
                vc.payType = self.payType;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"orderUpdate" object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"willPayOrderUpdate" object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"orderInfoUpdate" object:nil];
                
                BOOL isPop = NO;
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    if ([vc isKindOfClass:[OrderViewController class]] || [vc isKindOfClass:[OrderInfoViewController class]]) {
                        isPop = YES;
                        [self.navigationController popToViewController:vc animated:YES];
                        break;
                    }
                }
                if (!isPop) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            }
        } failure:^(NSError *error) {
            
        }];
    }
}

-(void)checkWeiXinAccount:(NSNotification *)notification{
    NSDictionary *responseDic = notification.object;
    NSString *openid = responseDic[@"openid"];
    NSLog(@"openID:%@----%@",openid,responseDic);
    NSDictionary *dic = @{@"ordersn":self.payModel.ordersn,@"m_id":[UserInfoModel getUserInfoModel].member_id,@"api_token":[RegisterModel getUserInfoModel].user_token};
    
    [FJNetTool postWithParams:dic url:Special_order_pay loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            PayInfoModel *model = [PayInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
            PayInfoViewController *vc = [[PayInfoViewController alloc]init];
            vc.payInfoModel = model;
            vc.payType = self.payType;
            vc.openId = openid;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)showPayTypeListView{
    self.payTypeView = [[PayTypeListView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar)];
    self.payTypeView.delegate = self;
    [self.payTypeView show];
    [self.view addSubview:self.payTypeView];
}

- (void)selectPayType:(NSString *)type{
    self.payTypeLab.text = type;
    if ([type isEqualToString:@"微信支付"]) {
        self.payType = @"7";
    }else{
        self.payType = @"5";
    }
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
