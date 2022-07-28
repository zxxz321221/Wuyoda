//
//  ProductDetailFooterView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/16.
//

#import "ProductDetailFooterView.h"
#import "CWStarRateView.h"
#import "ShopCartModel.h"
#import "OrderDetailViewController.h"
#import "ProductDetailCollectionAlertView.h"

@interface ProductDetailFooterView ()

@property (nonatomic , retain)UILabel *priceLab;
@property (nonatomic , retain)UILabel *oldPriceLab;
@property (nonatomic , retain)UILabel *unitLab;
@property (nonatomic , retain)CWStarRateView *starV;
@property (nonatomic , retain)UILabel *recommendLab;

@property (nonatomic , retain)UIButton *collectionBtn;

@property (nonatomic , retain)ProductDetailCollectionAlertView *collectionAlertV;

@end

@implementation ProductDetailFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
//    self.priceLab = [[UILabel alloc]init];
//    self.priceLab.text = @"￥211";
//    self.priceLab.textColor = [ColorManager BlackColor];
//    self.priceLab.font = kBoldFont(16);
//    [self addSubview:self.priceLab];
//    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(kWidth(20));
//        make.top.mas_offset(kWidth(15));
//    }];
//
//    self.oldPriceLab = [[UILabel alloc]init];
//    self.oldPriceLab.textColor = [ColorManager Color555555];
//    self.oldPriceLab.font = kFont(12);
//    NSMutableAttributedString *oldPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",@"264"]];
//    [oldPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, oldPrice.length)];
//    self.oldPriceLab.attributedText = oldPrice;
//    [self addSubview:self.oldPriceLab];
//    [self.oldPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.priceLab.mas_right).mas_offset(kWidth(6));
//        make.bottom.equalTo(self.priceLab);
//    }];
//
//    self.unitLab = [[UILabel alloc]init];
//    self.unitLab.text = @"/盒";
//    self.unitLab.textColor = [ColorManager Color555555];
//    self.unitLab.font = kFont(12);
//    [self addSubview:self.unitLab];
//    [self.unitLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.oldPriceLab.mas_right).mas_offset(kWidth(6));
//        make.centerY.equalTo(self.oldPriceLab);
//    }];
//
//    [self layoutIfNeeded];
//
//    self.starV = [[CWStarRateView alloc]initWithFrame:CGRectMake(kWidth(20), self.priceLab.frame.origin.y+self.priceLab.bounds.size.height+kWidth(7), kWidth(80), kWidth(15)) numberOfStars:5];
//    self.starV.scorePercent = 0.8;
//    [self addSubview:self.starV];
//
//    self.recommendLab = [[UILabel alloc]init];
//    self.recommendLab.text = @"98%客人推荐";
//    self.recommendLab.textColor = [ColorManager Color555555];
//    self.recommendLab.font = kFont(12);
//    [self addSubview:self.recommendLab];
//    [self.recommendLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.starV);
//        make.top.equalTo(self.starV.mas_bottom).mas_offset(kWidth(7));
//    }];
    
    self.backgroundColor = [ColorManager WhiteColor];
    
    UIButton *shoppingCartBtn = [[UIButton alloc]init];
    [shoppingCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [shoppingCartBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    shoppingCartBtn.titleLabel.font = kFont(14);
    shoppingCartBtn.backgroundColor = [ColorManager ColorFA8B18];
    shoppingCartBtn.layer.cornerRadius = kWidth(20);
    [shoppingCartBtn addTarget:self action:@selector(addShoppingCartClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:shoppingCartBtn];
    [shoppingCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kWidth(22));
        make.right.mas_offset(kWidth(-135));
        make.width.mas_offset(kWidth(100));
        make.height.mas_offset(kWidth(40));
    }];
    
    UIButton *buyBtn = [[UIButton alloc]init];
    [buyBtn setTitle:@"立即结算" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    buyBtn.titleLabel.font = kFont(14);
    buyBtn.backgroundColor = [ColorManager MainColor];
    buyBtn.layer.cornerRadius = kWidth(20);
    [buyBtn addTarget:self action:@selector(buyClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buyBtn];
    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kWidth(22));
        make.right.mas_offset(kWidth(-20));
        make.width.mas_offset(kWidth(100));
        make.height.mas_offset(kWidth(40));
    }];
    
    self.collectionBtn = [[UIButton alloc]init];
    [self.collectionBtn setImage:kGetImage(@"商品详情_收藏") forState:UIControlStateNormal];
    [self.collectionBtn setImage:kGetImage(@"商品详情_收藏选中") forState:UIControlStateSelected];
    [self.collectionBtn addTarget:self action:@selector(collectionClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.collectionBtn];
    [self.collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(shoppingCartBtn);
        make.left.mas_offset(kWidth(40));
        make.width.height.mas_offset(kWidth(24));
    }];
}

-(void)setModel:(HomeShopModel *)model{
    _model = model;
    //self.priceLab.text = [NSString stringWithFormat:@"%@%@",[CommonManager getPriceType:model.money_type],model.price];
    self.priceLab.text = [CommonManager getShowPrice:model.money_type Price:model.price];
    //self.oldPriceLab.text = [NSString stringWithFormat:@"%@%@",[CommonManager getPriceType:model.money_type],model.goods_market_price_org];
    self.oldPriceLab.text = [CommonManager getShowPrice:model.money_type Price:model.goods_market_price_org];
    self.collectionBtn.selected = model.favorite;
}

-(void)addShoppingCartClicked:(UIButton *)sender{
    
    if (![CommonManager isLogin:self.CurrentViewController isPush:YES]) {
        return;
    }

    UserInfoModel *model = [UserInfoModel getUserInfoModel];
    NSDictionary *dic = @{@"goods_id":self.model.uid,@"ps_num":@"1",@"m_id":model.member_id,@"att_value":@"",@"refer_g_uid":@"",@"api_token":[RegisterModel getUserInfoModel].user_token};
    [FJNetTool postWithParams:dic url:Special_cart_order loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            [self showHUDWithText:@"加入购物车成功" withYOffSet:0];
        }else{
            [self showHUDWithText:baseModel.msg withYOffSet:0];
        }
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)buyClicked:(UIButton *)sender{
    if ([CommonManager isLogin:self.CurrentViewController isPush:YES]) {
        UserInfoModel *model = [UserInfoModel getUserInfoModel];
        NSDictionary *dic = @{@"api_token":[RegisterModel getUserInfoModel].user_token,@"goods_id":self.model.uid,@"ps_num":@"1",@"m_id":model.member_id,@"att_value":@"",@"refer_g_uid":@"",@"addressid":@""};
        
        [FJNetTool postWithParams:dic url:Special_buy_now loading:YES success:^(id responseObject) {
            BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
            if ([baseModel.code isEqualToString:CODE0]) {
                
                NSMutableArray *cartArr = [ShopCartModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"cart_list"]];

                OrderDetailViewController *vc = [[OrderDetailViewController alloc]init];
                vc.cartArr = cartArr;
                [self.CurrentViewController.navigationController pushViewController:vc animated:YES];
            }
        } failure:^(NSError *error) {
                
        }];
    }
    
}

-(void)collectionClicked:(UIButton *)sender{
    if (![CommonManager isLogin:self.CurrentViewController isPush:YES]) {
        return;
    }
    if (sender.selected) {
        self.collectionAlertV = [[ProductDetailCollectionAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [self.collectionAlertV.doneBtn addTarget:self action:@selector(removeCollectionFromServer) forControlEvents:UIControlEventTouchUpInside];
        [self.CurrentViewController.view addSubview:self.collectionAlertV];
    }else{
        [self addCollectionFromServer];
    }
}

-(void)addCollectionFromServer{
    UserInfoModel *model = [UserInfoModel getUserInfoModel];
    NSDictionary *dic = @{@"api_token":[RegisterModel getUserInfoModel].user_token,@"uid":self.model.uid,@"m_uid":model.uid};
    
    [FJNetTool postWithParams:dic url:Special_favorite_detail loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            self.collectionBtn.selected = YES;
            [self showHUDWithText:baseModel.msg withYOffSet:0];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)removeCollectionFromServer{
    [self.collectionAlertV removeFromSuperview];
    UserInfoModel *model = [UserInfoModel getUserInfoModel];
    NSDictionary *dic = @{@"api_token":[RegisterModel getUserInfoModel].user_token,@"uid":self.model.uid,@"m_uid":model.uid};
    
    [FJNetTool postWithParams:dic url:Special_favorite_remove loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            self.collectionBtn.selected = NO;
            [self showHUDWithText:baseModel.msg withYOffSet:0];
        }
    } failure:^(NSError *error) {
        
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
