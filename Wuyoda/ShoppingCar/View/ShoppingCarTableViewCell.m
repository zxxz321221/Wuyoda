//
//  ShoppingCarTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/24.
//

#import "ShoppingCarTableViewCell.h"

@interface ShoppingCarTableViewCell ()

@property (nonatomic , retain)UIImageView *selectImgV;

@property (nonatomic , retain)UIImageView *imgV;

@property (nonatomic , retain)UILabel *nameLab;

@property (nonatomic , retain)UILabel *weightLab;

//@property (nonatomic , retain)UILabel *oldPriceLab;

@property (nonatomic , retain)UILabel *priceLab;

@property (nonatomic , retain)UIButton *subtractBtn;

@property (nonatomic , retain)UILabel *numLab;

@property (nonatomic , retain)UIButton *addBtn;

@property (nonatomic , retain)UILabel *statusLab;

@end

@implementation ShoppingCarTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    
    return self;
}

-(void)createUI{
    
    UIView *bgV = [[UIView alloc]init];
    bgV.backgroundColor = [ColorManager WhiteColor];
    bgV.layer.cornerRadius = kWidth(10);
    [self.contentView addSubview:bgV];
    [bgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.top.equalTo(self.contentView);
        make.width.mas_offset(kWidth(355));
        make.bottom.mas_offset(kWidth(-10));
    }];
    
    self.selectImgV = [[UIImageView alloc]initWithImage:kGetImage(@"未选中")];
    [bgV addSubview:self.selectImgV];
    [self.selectImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(11));
        make.top.mas_offset(kWidth(60));
        make.width.height.mas_offset(kWidth(18));
    }];
    
    self.imgV = [[UIImageView alloc]init];
    self.imgV.backgroundColor = [ColorManager ColorF2F2F2];
    self.imgV.layer.masksToBounds = YES;
    self.imgV.layer.cornerRadius = kWidth(10);
    self.imgV.contentMode = UIViewContentModeScaleAspectFit;
    [self.imgV setImage:kGetImage(@"good_detail_top")];
    [bgV addSubview:self.imgV];
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(48));
        make.top.mas_offset(kWidth(20));
        make.width.height.mas_offset(kWidth(100));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.text= @"【酱职人】国产黑豆荫油礼盒组 【Sauce Craftsman】Taiwan   Black Bean Sauce Gift Box";
    self.nameLab.textColor = [ColorManager BlackColor];
    self.nameLab.font = kFont(14);
    self.nameLab.numberOfLines = 3;
    self.nameLab.lineBreakMode = NSLineBreakByTruncatingTail;
    [bgV addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgV.mas_right).mas_offset(kWidth(10));
        make.top.equalTo(self.imgV);
        make.right.mas_offset(kWidth(-20));
    }];
    
//    self.oldPriceLab = [[UILabel alloc]init];
//    self.oldPriceLab.textColor = [ColorManager ColorCCCCCC];
//    self.oldPriceLab.font = kFont(14);
//    [bgV addSubview:self.oldPriceLab];
//    [self.oldPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.imgV.mas_right).mas_offset(kWidth(10));
//        make.top.mas_offset(kWidth(75));
//    }];
//
    self.weightLab = [[UILabel alloc]init];
    self.weightLab.textColor = [ColorManager ColorCCCCCC];
    self.weightLab.font = kFont(14);
    [bgV addSubview:self.weightLab];
    [self.weightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgV.mas_right).mas_offset(kWidth(10));
        make.top.mas_offset(kWidth(75));
    }];
    
    self.priceLab = [[UILabel alloc]init];
    self.priceLab.text = @"￥0";
    self.priceLab.textColor = [ColorManager ColorFE3C3D];
    self.priceLab.font = kFont(14);
    [bgV addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.weightLab);
        make.top.equalTo(self.weightLab.mas_bottom).mas_offset(kWidth(10));
    }];
    
    self.addBtn = [[UIButton alloc]init];
    [self.addBtn setTitle:@"+" forState:UIControlStateNormal];
    [self.addBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
    self.addBtn.titleLabel.font = kFont(14);
    self.addBtn.layer.borderColor = [ColorManager ColorF2F2F2].CGColor;
    self.addBtn.layer.borderWidth = kWidth(1);
    [self.addBtn addTarget:self action:@selector(changeCartNumClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bgV addSubview:self.addBtn];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-19));
        make.centerY.equalTo(self.priceLab);
        make.width.height.mas_offset(kWidth(26));
    }];
    
    self.numLab = [[UILabel alloc]init];
    self.numLab.text = @"1";
    self.numLab.textColor = [ColorManager BlackColor];
    self.numLab.textAlignment = NSTextAlignmentCenter;
    self.numLab.font= kFont(14);
    self.numLab.layer.borderColor = [ColorManager ColorF2F2F2].CGColor;
    self.numLab.layer.borderWidth = kWidth(1);
    [bgV addSubview:self.numLab];
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.addBtn.mas_left).mas_offset(kWidth(1));
        make.centerY.height.equalTo(self.addBtn);
        make.width.mas_offset(kWidth(44));
    }];
    
    self.subtractBtn = [[UIButton alloc]init];
    [self.subtractBtn setTitle:@"-" forState:UIControlStateNormal];
    [self.subtractBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
    self.subtractBtn.titleLabel.font = kFont(14);
    self.subtractBtn.layer.borderColor = [ColorManager ColorF2F2F2].CGColor;
    self.subtractBtn.layer.borderWidth = kWidth(1);
    [self.subtractBtn addTarget:self action:@selector(changeCartNumClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bgV addSubview:self.subtractBtn];
    [self.subtractBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.numLab.mas_left).mas_offset(kWidth(1));
        make.centerY.equalTo(self.addBtn);
        make.width.height.mas_offset(kWidth(26));
    }];
    
    self.statusLab = [[UILabel alloc]init];
    self.statusLab.text = @"该商品已下架，无法购买";
    self.statusLab.textColor = [ColorManager MainColor];
    self.statusLab.font = kBoldFont(12);
    [bgV addSubview:self.statusLab];
    [self.statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(kWidth(-20));
        make.left.mas_offset(kWidth(107));
    }];
}


-(void)setModel:(ShopCartModel *)model{
    _model = model;
    self.nameLab.text = model.goods_name;
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.goods_file1]]];
    if (![model.goods_kg isEqualToString:@"0"] && model.goods_kg) {
        self.weightLab.text = [NSString stringWithFormat:@"%@g",model.goods_kg];
    }else{
        self.weightLab.text = @" ";
    }
    
    //self.oldPriceLab.text = [CommonManager getShowPrice:model.money_type Price:model.ori_price];
    self.priceLab.text = [CommonManager getShowPrice:model.money_type Price:model.cart_price];
    
//    self.oldPriceLab.text = [NSString stringWithFormat:@"%@%@",[CommonManager getPriceType:model.money_type],model.ori_price];
//    self.priceLab.text = [NSString stringWithFormat:@"%@%@",[CommonManager getPriceType:model.money_type],model.cart_price];
    self.numLab.text = model.cart_num;
    
    if ([model.isup isEqualToString:@"1"]) {
        
        if ([model.goods_stock integerValue] < [model.cart_num integerValue]) {
            self.statusLab.text = @"该商品库存不足";
            self.statusLab.hidden = NO;
        }else{
            self.statusLab.hidden = YES;
        }
    }else{
        self.statusLab.text = @"该商品已下架，无法购买";
        self.statusLab.hidden = NO;
    }
    
}

-(void)setIsEdit:(BOOL)isEdit{
    if (isEdit) {
        if (self.model.isEdit.length && [self.model.isEdit isEqualToString:@"1"]) {
            [self.selectImgV setImage:kGetImage(@"选中")];
        }else{
            [self.selectImgV setImage:kGetImage(@"未选中")];
        }
    }else{
        if (self.model.isSelect.length && [self.model.isSelect isEqualToString:@"1"]) {
            [self.selectImgV setImage:kGetImage(@"选中")];
        }else{
            [self.selectImgV setImage:kGetImage(@"未选中")];
        }
    }
}

-(void)changeCartNumClicked:(UIButton *)sender{
    
    if ([self.model.isup isEqualToString:@"0"]) {
        [self.contentView showHUDWithText:@"商品已下架" withYOffSet:0];
        return;
    }
    
    NSInteger num = [self.model.cart_num integerValue];
    if (sender == self.addBtn) {
        num += 1;
    }else{
        if (num < 2) {
            return;
        }
        num -= 1;
    }
    NSDictionary *dic = @{@"cart_id":self.model.uid,@"num":[NSString stringWithFormat:@"%ld",num],@"api_token":[RegisterModel getUserInfoModel].user_token};
    
    [FJNetTool postWithParams:dic url:Special_cart_num loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            self.model.cart_num = [NSString stringWithFormat:@"%ld",num];
            if (self.delegate && [self.delegate respondsToSelector:@selector(updateCartNumwithModel:)]) {
                [self.delegate updateCartNumwithModel:self.model];
            }
        }else{
            [self showHUDWithText:baseModel.msg withYOffSet:0];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
