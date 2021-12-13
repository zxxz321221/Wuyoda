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

@property (nonatomic , retain)UILabel *oldPriceLab;

@property (nonatomic , retain)UILabel *priceLab;

@property (nonatomic , retain)UIButton *subtractBtn;

@property (nonatomic , retain)UILabel *numLab;

@property (nonatomic , retain)UIButton *addBtn;

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
        make.bottom.mas_offset(kWidth(-8));
    }];
    
    self.selectImgV = [[UIImageView alloc]initWithImage:kGetImage(@"选择")];
    [bgV addSubview:self.selectImgV];
    [self.selectImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(11));
        make.top.mas_offset(kWidth(24));
        make.width.height.mas_offset(kWidth(20));
    }];
    
    self.imgV = [[UIImageView alloc]init];
    self.imgV.backgroundColor = [ColorManager RandomColor];
    self.imgV.layer.masksToBounds = YES;
    self.imgV.layer.cornerRadius = kWidth(10);
    [self.imgV setImage:kGetImage(@"good_detail_top")];
    [bgV addSubview:self.imgV];
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(46));
        make.top.mas_offset(kWidth(16));
        make.width.height.mas_offset(kWidth(80));
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
    
    self.oldPriceLab = [[UILabel alloc]init];
    self.oldPriceLab.textColor = [ColorManager ColorAAAAAA];
    self.oldPriceLab.font = kFont(14);
    NSMutableAttributedString *oldPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",@"788"]];
    [oldPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, oldPrice.length)];
    self.oldPriceLab.attributedText = oldPrice;
    [bgV addSubview:self.oldPriceLab];
    [self.oldPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgV.mas_right).mas_offset(kWidth(10));
        make.top.equalTo(self.nameLab.mas_bottom).mas_offset(kWidth(15));
    }];
    
    self.priceLab = [[UILabel alloc]init];
    self.priceLab.text = @"￥0";
    self.priceLab.textColor = [ColorManager ColorD8001B];
    self.priceLab.font = kFont(16);
    [bgV addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.oldPriceLab);
        make.top.equalTo(self.oldPriceLab.mas_bottom).mas_offset(kWidth(13));
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
}


-(void)setModel:(ShopCartModel *)model{
    _model = model;
    self.nameLab.text = model.goods_name;
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.goods_file1]]];
    if (model.isSelect.length && [model.isSelect isEqualToString:@"1"]) {
        [self.selectImgV setImage:kGetImage(@"选中")];
    }else{
        [self.selectImgV setImage:kGetImage(@"选择")];
    }
    self.oldPriceLab.text = [NSString stringWithFormat:@"%@%@",[CommonManager getPriceType:model.money_type],model.ori_price];
    self.priceLab.text = [NSString stringWithFormat:@"%@%@",[CommonManager getPriceType:model.money_type],model.cart_price];
    self.numLab.text = model.cart_num;
}

-(void)changeCartNumClicked:(UIButton *)sender{
    NSInteger num = [self.model.cart_num integerValue];
    if (sender == self.addBtn) {
        num += 1;
    }else{
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
