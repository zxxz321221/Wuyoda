//
//  OrderInfoHeaderView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/12.
//

#import "OrderInfoHeaderView.h"

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
    self.backgroundColor = [ColorManager MainColor];
    
    self.typeLab = [[UILabel alloc]init];
    self.typeLab.textColor = [ColorManager WhiteColor];
    self.typeLab.font = kBoldFont(20);
    [self addSubview:self.typeLab];
    [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(27));
        make.top.mas_offset(kWidth(22));
    }];
    
    self.infoLab = [[UILabel alloc]init];
    self.infoLab.textColor = [ColorManager WhiteColor];
    self.infoLab.font = kBoldFont(20);
    [self addSubview:self.infoLab];
    [self.infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(27));
        make.bottom.mas_offset(kWidth(-22));
    }];
    
    self.typeImgV = [[UIImageView alloc]init];
    [self addSubview:self.typeImgV];
    [self.typeImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.mas_offset(kWidth(-37));
        make.width.height.mas_offset(kWidth(44));
    }];
}

-(void)setType:(NSString *)type{
    _type = type;
    if ([type isEqualToString:@"1"]) {
        self.typeLab.text = @"待付款";
        self.infoLab.text = @"10分钟后订单关闭，请及时付款";
        [self.typeImgV setImage:kGetImage(@"")];
    }
    if ([type isEqualToString:@"2"]) {
        self.typeLab.text = @"待收货";
        self.infoLab.text = @"运输中，查看详情>>";
        [self.typeImgV setImage:kGetImage(@"")];
    }
    if ([type isEqualToString:@"3"]) {
        self.typeLab.text = @"已完成";
        [self.typeLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(kWidth(34));
        }];
        [self.typeImgV setImage:kGetImage(@"")];
    }
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
