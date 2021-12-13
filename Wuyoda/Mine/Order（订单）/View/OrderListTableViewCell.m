//
//  OrderListTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/11.
//

#import "OrderListTableViewCell.h"

@interface OrderListTableViewCell ()

@property (nonatomic , retain)UIImageView *imgV;

@property (nonatomic , retain)UILabel *statusLab;

@property (nonatomic , retain)UILabel *titleLab;

@property (nonatomic , retain)UILabel *specificationLab;

@property (nonatomic , retain)UILabel *numLab;

@property (nonatomic , retain)UILabel *priceLab;

@end

@implementation OrderListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    
    return self;
}

-(void)createUI{
    self.backgroundColor = [ColorManager ColorF2F2F2];
    UIView *bgV = [[UIView alloc]init];
    bgV.layer.cornerRadius = kWidth(10);
    bgV.backgroundColor = [ColorManager WhiteColor];
    [self.contentView addSubview:bgV];
    [bgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.mas_offset(kWidth(10));
        make.width.mas_offset(kWidth(350));
        make.height.mas_offset(kWidth(196));
    }];
    
    self.statusLab = [[UILabel alloc]init];
    self.statusLab.text = @"已取消";
    self.statusLab.textColor = [ColorManager Color999999];
    self.statusLab.font = kFont(12);
    [bgV addSubview:self.statusLab];
    [self.statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-16));
        make.top.mas_offset(kWidth(14));
    }];
    
    self.imgV = [[UIImageView alloc]init];
    self.imgV.layer.cornerRadius = kWidth(5);
    self.imgV.backgroundColor = [ColorManager RandomColor];
    [bgV addSubview:self.imgV];
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(15));
        make.top.mas_offset(kWidth(40));
        make.width.height.mas_offset(kWidth(79));
    }];
    
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.text = @"【酱职人】国产黑豆荫油礼...";
    self.titleLab.textColor = [ColorManager BlackColor];
    self.titleLab.font = kFont(14);
    [bgV addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgV.mas_right).mas_offset(kWidth(14));
        make.right.mas_offset(kWidth(-50));
        make.top.mas_offset(kWidth(40));
    }];
    
    self.specificationLab = [[UILabel alloc]init];
    self.specificationLab.text = @"规格：200g/块";
    self.specificationLab.textColor = [ColorManager Color999999];
    self.specificationLab.font = kFont(12);
    [bgV addSubview:self.specificationLab];
    [self.specificationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgV.mas_right).mas_offset(kWidth(14));
        make.top.equalTo(self.titleLab.mas_bottom).mas_offset(kWidth(24));
    }];
    self.numLab = [[UILabel alloc]init];
    self.numLab.text = @"数量：1";
    self.numLab.textColor = [ColorManager Color999999];
    self.numLab.font = kFont(12);
    [bgV addSubview:self.numLab];
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgV.mas_right).mas_offset(kWidth(14));
        make.top.equalTo(self.specificationLab.mas_bottom).mas_offset(kWidth(3));
    }];
    
    self.priceLab = [[UILabel alloc]init];
    self.priceLab.text = @"￥349.00";
    self.priceLab.textColor = [ColorManager Color333333];
    self.priceLab.font = kBoldFont(14);
    [bgV addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-16));
        make.bottom.mas_offset(kWidth(-54));
    }];
    
    UILabel *pticeTitleLab = [[UILabel alloc]init];
    pticeTitleLab.text = @"合计";
    pticeTitleLab.textColor = [ColorManager Color666666];
    pticeTitleLab.font = kFont(14);
    [bgV addSubview:pticeTitleLab];
    [pticeTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.priceLab.mas_left);
        make.bottom.mas_offset(kWidth(-54));
    }];
    
    [self createBottomBtn:bgV];
    
}

-(void)createBottomBtn:(UIView *)view{
    self.buyAgainBtn = [[UIButton alloc]init];
    [self.buyAgainBtn setTitle:@"再次购买" forState:UIControlStateNormal];
    [self.buyAgainBtn setTitleColor:[ColorManager Color990900] forState:UIControlStateNormal];
    self.buyAgainBtn.titleLabel.font = kFont(12);
    self.buyAgainBtn.layer.borderColor = [ColorManager Color990900].CGColor;
    self.buyAgainBtn.layer.borderWidth = kWidth(1);
    self.buyAgainBtn.layer.cornerRadius = kWidth(14);
    [view addSubview:self.buyAgainBtn];
    [self.buyAgainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-16));
        make.bottom.mas_offset(kWidth(-13));
        make.width.mas_offset(kWidth(74));
        make.height.mas_offset(kWidth(28));
    }];
    
    self.payBtn = [[UIButton alloc]init];
    [self.payBtn setTitle:@"立即付款" forState:UIControlStateNormal];
    [self.payBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    self.payBtn.titleLabel.font = kFont(12);
    self.payBtn.layer.cornerRadius = kWidth(14);
    self.payBtn.backgroundColor = [ColorManager MainColor];
    [view addSubview:self.payBtn];
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-16));
        make.bottom.mas_offset(kWidth(-13));
        make.width.mas_offset(kWidth(74));
        make.height.mas_offset(kWidth(28));
    }];
    
    self.addressBtn = [[UIButton alloc]init];
    [self.addressBtn setTitle:@"修改地址" forState:UIControlStateNormal];
    [self.addressBtn setTitleColor:[ColorManager Color09AFFF] forState:UIControlStateNormal];
    self.addressBtn.titleLabel.font = kFont(12);
    self.addressBtn.layer.borderColor = [ColorManager Color09AFFF].CGColor;
    self.addressBtn.layer.borderWidth = kWidth(1);
    self.addressBtn.layer.cornerRadius = kWidth(14);
    [view addSubview:self.addressBtn];
    [self.addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-98));
        make.bottom.mas_offset(kWidth(-13));
        make.width.mas_offset(kWidth(74));
        make.height.mas_offset(kWidth(28));
    }];
    
    self.cancelBtn = [[UIButton alloc]init];
    [self.cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:[ColorManager Color666666] forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font = kFont(12);
    self.cancelBtn.layer.borderColor = [ColorManager Color999999].CGColor;
    self.cancelBtn.layer.borderWidth = kWidth(1);
    self.cancelBtn.layer.cornerRadius = kWidth(14);
    [view addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-180));
        make.bottom.mas_offset(kWidth(-13));
        make.width.mas_offset(kWidth(74));
        make.height.mas_offset(kWidth(28));
    }];
    
    self.doneTakeBtn = [[UIButton alloc]init];
    [self.doneTakeBtn setTitle:@"确认收货" forState:UIControlStateNormal];
    [self.doneTakeBtn setTitleColor:[ColorManager MainColor] forState:UIControlStateNormal];
    self.doneTakeBtn.titleLabel.font = kFont(12);
    self.doneTakeBtn.layer.borderColor = [ColorManager MainColor].CGColor;
    self.doneTakeBtn.layer.borderWidth = kWidth(1);
    self.doneTakeBtn.layer.cornerRadius = kWidth(14);
    [view addSubview:self.doneTakeBtn];
    [self.doneTakeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-16));
        make.bottom.mas_offset(kWidth(-13));
        make.width.mas_offset(kWidth(74));
        make.height.mas_offset(kWidth(28));
    }];
    
    self.readLogisticsBtn = [[UIButton alloc]init];
    [self.readLogisticsBtn setTitle:@"查看物流" forState:UIControlStateNormal];
    [self.readLogisticsBtn setTitleColor:[ColorManager Color666666] forState:UIControlStateNormal];
    self.readLogisticsBtn.titleLabel.font = kFont(12);
    self.readLogisticsBtn.layer.borderColor = [ColorManager Color999999].CGColor;
    self.readLogisticsBtn.layer.borderWidth = kWidth(1);
    self.readLogisticsBtn.layer.cornerRadius = kWidth(14);
    [view addSubview:self.readLogisticsBtn];
    [self.readLogisticsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-98));
        make.bottom.mas_offset(kWidth(-13));
        make.width.mas_offset(kWidth(74));
        make.height.mas_offset(kWidth(28));
    }];
    
    self.finishEvaluateBtn = [[UIButton alloc]init];
    [self.finishEvaluateBtn setTitle:@"评价" forState:UIControlStateNormal];
    [self.finishEvaluateBtn setTitleColor:[ColorManager Color09AFFF] forState:UIControlStateNormal];
    self.finishEvaluateBtn.titleLabel.font = kFont(12);
    self.finishEvaluateBtn.layer.borderColor = [ColorManager Color09AFFF].CGColor;
    self.finishEvaluateBtn.layer.borderWidth = kWidth(1);
    self.finishEvaluateBtn.layer.cornerRadius = kWidth(14);
    [view addSubview:self.finishEvaluateBtn];
    [self.finishEvaluateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-98));
        make.bottom.mas_offset(kWidth(-13));
        make.width.mas_offset(kWidth(74));
        make.height.mas_offset(kWidth(28));
    }];
    
    self.deleteBtn = [[UIButton alloc]init];
    [self.deleteBtn setTitle:@"删除订单" forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:[ColorManager Color666666] forState:UIControlStateNormal];
    self.deleteBtn.titleLabel.font = kFont(12);
    self.deleteBtn.layer.borderColor = [ColorManager Color999999].CGColor;
    self.deleteBtn.layer.borderWidth = kWidth(1);
    self.deleteBtn.layer.cornerRadius = kWidth(14);
    [view addSubview:self.deleteBtn];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-180));
        make.bottom.mas_offset(kWidth(-13));
        make.width.mas_offset(kWidth(74));
        make.height.mas_offset(kWidth(28));
    }];
}

-(void)setType:(NSString *)type{
    //1.待付款 2.待收货 3.已完成 4.已取消
    _type = type;
    if ([type isEqualToString:@"1"]) {
        self.buyAgainBtn.hidden = YES;
        self.payBtn.hidden = NO;
        self.addressBtn.hidden = NO;
        self.cancelBtn.hidden = NO;
        self.doneTakeBtn.hidden = YES;
        self.readLogisticsBtn.hidden = YES;
        self.finishEvaluateBtn.hidden = YES;
        self.deleteBtn.hidden = YES;
    }
    if ([type isEqualToString:@"2"]) {
        self.buyAgainBtn.hidden = YES;
        self.payBtn.hidden = YES;
        self.addressBtn.hidden = YES;
        self.cancelBtn.hidden = YES;
        self.doneTakeBtn.hidden = NO;
        self.readLogisticsBtn.hidden = NO;
        self.finishEvaluateBtn.hidden = YES;
        self.deleteBtn.hidden = YES;
    }
    if ([type isEqualToString:@"3"]) {
        self.buyAgainBtn.hidden = NO;
        self.payBtn.hidden = YES;
        self.addressBtn.hidden = YES;
        self.cancelBtn.hidden = YES;
        self.doneTakeBtn.hidden = YES;
        self.readLogisticsBtn.hidden = YES;
        self.finishEvaluateBtn.hidden = NO;
        self.deleteBtn.hidden = NO;
    }
    if ([type isEqualToString:@"4"]) {
        self.buyAgainBtn.hidden = NO;
        self.payBtn.hidden = YES;
        self.addressBtn.hidden = YES;
        self.cancelBtn.hidden = YES;
        self.doneTakeBtn.hidden = YES;
        self.readLogisticsBtn.hidden = YES;
        self.finishEvaluateBtn.hidden = YES;
        self.deleteBtn.hidden = YES;
    }
}

-(void)setListModel:(OrderListModel *)listModel{
    _listModel = listModel;
    NSDictionary *orderGoodDic = listModel.order_goods;
    NSArray *allKey = orderGoodDic.allKeys;
    OrderGoodModel *goodModel = [OrderGoodModel mj_objectWithKeyValues:[orderGoodDic valueForKey:allKey.firstObject]];
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",goodModel.goods_file1]]];
    self.titleLab.text = goodModel.goods_name;
    self.numLab.text = [NSString stringWithFormat:@"数量：%@",goodModel.buy_number];
    self.priceLab.text = listModel.original_price;
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
