//
//  OrderInfoHeaderView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/12.
//

#import "OrderInfoHeaderView.h"
#import "LogisticsViewController.h"

@interface OrderInfoHeaderView ()

@property (nonatomic , retain)UILabel *typeLab;

@property (nonatomic , retain)UILabel *infoLab;

@property (nonatomic , retain)UIImageView *typeImgV;

@end

@implementation OrderInfoHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.backgroundColor = [ColorManager ColorF2F2F2];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(kWidth(10), 0, kWidth(355), kWidth(84))];
    bgView.backgroundColor = [ColorManager WhiteColor];
    bgView.layer.cornerRadius = kWidth(10);
    [self addSubview:bgView];
    
    self.typeLab = [[UILabel alloc]init];
    self.typeLab.font = kBoldFont(20);
    [bgView addSubview:self.typeLab];
    [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(10));
        make.top.mas_offset(kWidth(20));
    }];
    
    self.infoLab = [[UILabel alloc]init];
    self.infoLab.textColor = [ColorManager Color666666];
    self.infoLab.font = kFont(12);
    [bgView addSubview:self.infoLab];
    [self.infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(10));
        make.bottom.mas_offset(kWidth(-20));
    }];
    
    self.typeImgV = [[UIImageView alloc]init];
    self.typeImgV.contentMode = UIViewContentModeScaleAspectFit;
    [bgView addSubview:self.typeImgV];
    [self.typeImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView);
        make.right.mas_offset(kWidth(-10));
        make.width.height.mas_offset(kWidth(44));
    }];
}

-(void)setType:(NSString *)type{
    _type = type;
    if ([type isEqualToString:@"1"]) {
        self.typeLab.text = @"待付款";
        self.typeLab.textColor = [ColorManager MainColor];
        self.infoLab.text = @"10分钟后订单关闭，请及时付款";
        [self.typeImgV setImage:kGetImage(@"订单_待付款")];
    }
    if ([type isEqualToString:@"4"]) {
        self.typeLab.text = @"待收货";
        self.infoLab.text = @"运输中，查看详情>>";
        self.typeLab.textColor = [ColorManager Color09AFFF];
        [self.typeImgV setImage:kGetImage(@"订单_待收货")];
        UIButton *logisticsBtn = [[UIButton alloc]initWithFrame:self.bounds];
        [logisticsBtn addTarget:self action:@selector(readLogisticsClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:logisticsBtn];
        
    }
    if ([type isEqualToString:@"5"]) {
        self.typeLab.text = @"已完成";
        self.typeLab.textColor = [ColorManager Color333333];
        self.infoLab.text = @"";
        [self.typeLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(kWidth(32));
        }];
        [self.typeImgV setImage:kGetImage(@"订单_已完成")];
    }
    if ([type isEqualToString:@"3"]) {
        self.typeLab.text = @"已付款";
        self.typeLab.textColor = [ColorManager ColorFB9A3A];
        self.infoLab.text = @"等待发货";
        [self.typeImgV setImage:kGetImage(@"订单_已付款")];
    }
    if ([type isEqualToString:@"2"]) {
        self.typeLab.text = @"已取消";
        self.typeLab.textColor = [ColorManager ColorFD817C];
        self.infoLab.text = @"";
        [self.typeImgV setImage:kGetImage(@"订单_已取消")];
        [self.typeLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(kWidth(10));
            make.centerY.equalTo(self.typeImgV);
        }];
        
    }
    if ([type isEqualToString:@"6"]) {
        self.typeLab.text = @"已退货";
        self.typeLab.textColor = [ColorManager Color999999];
        self.infoLab.text = @"";
        [self.typeImgV setImage:kGetImage(@"订单_已退货")];
        [self.typeLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(kWidth(10));
            make.centerY.equalTo(self.typeImgV);
        }];
    }
    
}

-(void)readLogisticsClicked{
    LogisticsViewController *vc = [[LogisticsViewController alloc]init];
    vc.orderNum = self.ordersn;
    [self.CurrentViewController.navigationController pushViewController:vc animated:YES];
}

-(void)setSurplus:(NSInteger)surplus{
    NSInteger minute = surplus/60;
    NSInteger second = surplus % 60;
    self.infoLab.text = [NSString stringWithFormat:@"%.2ld：%.2ld后订单关闭，请及时付款",minute,second];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
