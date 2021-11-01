//
//  TWProductListHeaderView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/17.
//

#import "TWProductListHeaderView.h"
#import "HomeSearchCityCollectionViewCell.h"

@interface TWProductListHeaderView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , retain)UICollectionView *collectionV;

@property (nonatomic , retain)UIButton *addressBtn;
@property (nonatomic , retain)UIButton *typeBtn;
@property (nonatomic , retain)UIButton *priceBtn;

@end

@implementation TWProductListHeaderView


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
    self.addressBtn = [[UIButton alloc]init];
    [self.addressBtn setTitle:@"北台湾" forState:UIControlStateNormal];
    [self.addressBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
    self.addressBtn.titleLabel.font = kFont(12);
    [self.addressBtn setImage:kGetImage(@"") forState:UIControlStateNormal];
    [self.addressBtn setImage:kGetImage(@"") forState:UIControlStateSelected];
    [self addSubview:self.addressBtn];
    [self.addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.mas_offset(kWidth(10));
        make.width.mas_offset(kWidth(65));
        make.height.mas_offset(kWidth(30));
    }];
    
    self.typeBtn = [[UIButton alloc]init];
    [self.typeBtn setTitle:@"特色伴手礼" forState:UIControlStateNormal];
    [self.typeBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
    self.typeBtn.titleLabel.font = kFont(12);
    [self.typeBtn setImage:kGetImage(@"") forState:UIControlStateNormal];
    [self.typeBtn setImage:kGetImage(@"") forState:UIControlStateSelected];
    [self addSubview:self.typeBtn];
    [self.typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.mas_offset(kWidth(10));
        make.width.mas_offset(kWidth(95));
        make.height.mas_offset(kWidth(30));
    }];
    
    self.priceBtn = [[UIButton alloc]init];
    [self.priceBtn setTitle:@"价格" forState:UIControlStateNormal];
    [self.priceBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
    self.priceBtn.titleLabel.font = kFont(12);
    [self.priceBtn setImage:kGetImage(@"") forState:UIControlStateNormal];
    [self.priceBtn setImage:kGetImage(@"") forState:UIControlStateSelected];
    [self addSubview:self.priceBtn];
    [self.priceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-20));
        make.top.mas_offset(kWidth(10));
        make.width.mas_offset(kWidth(86));
        make.height.mas_offset(kWidth(30));
    }];
    
    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
    fl.itemSize = CGSizeMake(kWidth(76), kWidth(32));
    fl.sectionInset = UIEdgeInsetsMake(kWidth(0), kWidth(20), kWidth(0), kWidth(20));
    fl.minimumLineSpacing = kWidth(16);
    
    
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kWidth(48), kScreenWidth, kWidth(36)*2) collectionViewLayout:fl];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    self.collectionV.backgroundColor = [ColorManager WhiteColor];
    [self.collectionV registerClass:[HomeSearchCityCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([HomeSearchCityCollectionViewCell class])];
    [self addSubview:self.collectionV];
    
    self.recommendArr = [[NSMutableArray alloc]initWithObjects:@"凤梨酥",@"高山茶",@"手工皂", nil];
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeSearchCityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomeSearchCityCollectionViewCell class]) forIndexPath:indexPath];
    
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.recommendArr.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)setRecommendArr:(NSMutableArray *)recommendArr{
    _recommendArr = recommendArr;
    [self.collectionV reloadData];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
