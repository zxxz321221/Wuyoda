//
//  OrderListTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/11.
//

#import "OrderListTableViewCell.h"

@interface OrderListTableViewCell ()

@property (nonatomic , retain)UIView *bgView;

@property (nonatomic , retain)UILabel *statusLab;

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
    self.bgView = [[UIView alloc]init];
    self.bgView.layer.cornerRadius = kWidth(10);
    self.bgView.backgroundColor = [ColorManager WhiteColor];
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.mas_offset(kWidth(10));
        make.width.mas_offset(kWidth(350));
        make.bottom.equalTo(self.contentView);
    }];
    
    self.statusLab = [[UILabel alloc]init];
    self.statusLab.text = @"已取消";
    self.statusLab.textColor = [ColorManager Color999999];
    self.statusLab.font = kFont(12);
    //self.statusLab.hidden = YES;
    [self.bgView addSubview:self.statusLab];
    [self.statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-16));
        make.top.mas_offset(kWidth(14));
    }];
    
    
    self.priceLab = [[UILabel alloc]init];
    //self.priceLab.text = @"￥0.00";
    self.priceLab.textColor = [ColorManager Color333333];
    self.priceLab.font = kBoldFont(14);
    [self.bgView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-16));
        make.bottom.mas_offset(kWidth(-54));
    }];
    
    UILabel *pticeTitleLab = [[UILabel alloc]init];
    pticeTitleLab.text = @"合计";
    pticeTitleLab.textColor = [ColorManager Color666666];
    pticeTitleLab.font = kFont(14);
    [self.bgView addSubview:pticeTitleLab];
    [pticeTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.priceLab.mas_left);
        make.bottom.mas_offset(kWidth(-54));
    }];
    
    
    [self createBottomBtn:self.bgView];
    
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
    [self.bgView removeFromSuperview];
    [self createUI];
    _listModel = listModel;
    NSDictionary *orderGoodDic = listModel.order_goods;
    NSArray *allKey = orderGoodDic.allKeys;
    for (int i = 0; i<allKey.count; i++) {
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth(15), kWidth(40)+kWidth(89)*i, kWidth(79), kWidth(79))];
        imgV.layer.cornerRadius = kWidth(5);
        imgV.backgroundColor = [ColorManager ColorF2F2F2];
        [self.bgView addSubview:imgV];
        
        UILabel *titleLab = [[UILabel alloc]init];
        titleLab.textColor = [ColorManager BlackColor];
        titleLab.font = kFont(14);
        [self.bgView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgV.mas_right).mas_offset(kWidth(14));
            make.right.mas_offset(kWidth(-50));
            make.top.mas_offset(kWidth(40)+kWidth(89)*i);
        }];
        
        UILabel *specificationLab = [[UILabel alloc]init];
        //self.specificationLab.text = @"规格：200g/块";
        specificationLab.text = @"件";
        specificationLab.textColor = [ColorManager Color999999];
        specificationLab.font = kFont(12);
        [self.bgView addSubview:specificationLab];
        [specificationLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgV.mas_right).mas_offset(kWidth(14));
            make.top.equalTo(titleLab.mas_bottom).mas_offset(kWidth(24));
        }];
        UILabel *numLab = [[UILabel alloc]init];
        numLab.textColor = [ColorManager Color999999];
        numLab.font = kFont(12);
        [self.bgView addSubview:numLab];
        [numLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgV.mas_right).mas_offset(kWidth(14));
            make.top.equalTo(specificationLab.mas_bottom).mas_offset(kWidth(3));
        }];
        
        OrderGoodModel *goodModel = [OrderGoodModel mj_objectWithKeyValues:[orderGoodDic valueForKey:[allKey objectAtIndex:i]]];
        [imgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",goodModel.goods_file1]]];
        titleLab.text = goodModel.goods_name;
        numLab.text = [NSString stringWithFormat:@"数量：%@",goodModel.buy_number];
        
    }
    self.priceLab.text = listModel.order_amount;
    self.statusLab.text = listModel.status;
//    if ([listModel.status_code isEqualToString:@"2"]) {
//        self.statusLab.hidden = NO;
//    }else{
//        self.statusLab.hidden = YES;
//    }
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
