//
//  HomeSearchHotCityView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/16.
//

#import "HomeSearchHotCityView.h"
#import "HomeSearchCityCollectionViewCell.h"
#import "PreferentialGoodListViewController.h"

@interface HomeSearchHotCityView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , retain)UICollectionView *collectionV;

@end

@implementation HomeSearchHotCityView

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
    UILabel *hotCityLab = [[UILabel alloc]init];
    hotCityLab.text = @"热门城市";
    hotCityLab.textColor = [ColorManager BlackColor];
    hotCityLab.font = kFont(12);
    [self addSubview:hotCityLab];
    [hotCityLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.mas_offset(kWidth(11));
    }];
    
    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
    fl.itemSize = CGSizeMake(kWidth(58), kWidth(36));
    fl.sectionInset = UIEdgeInsetsMake(kWidth(0), kWidth(20), kWidth(0), kWidth(20));
    fl.minimumLineSpacing = kWidth(14);
    
    
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kWidth(40), kScreenWidth, kWidth(36)*2+kWidth(24)) collectionViewLayout:fl];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    self.collectionV.backgroundColor = [ColorManager WhiteColor];
    [self.collectionV registerClass:[HomeSearchCityCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([HomeSearchCityCollectionViewCell class])];
    [self addSubview:self.collectionV];
    
    UILabel *allCityLab = [[UILabel alloc]init];
    allCityLab.text = @"所有城市";
    allCityLab.textColor = [ColorManager BlackColor];
    allCityLab.font = kFont(12);
    [self addSubview:allCityLab];
    [allCityLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.bottom.mas_offset(kWidth(-15));
    }];
    
    //self.hotCityArr = [[NSMutableArray alloc]initWithObjects:@"台北市",@"新北市",@"基隆市",@"桃园市",@"新竹市",@"宜兰市", nil];
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeSearchCityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomeSearchCityCollectionViewCell class]) forIndexPath:indexPath];
    cell.cityLab.text = [self.hotCityArr objectAtIndex:indexPath.row];
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.hotCityArr.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    PreferentialGoodListViewController *vc = [[PreferentialGoodListViewController alloc]init];
//    vc.cityStr = [self.hotCityArr objectAtIndex:indexPath.row];
//    [self.CurrentViewController.navigationController pushViewController:vc animated:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectHotCity:)]) {
        [self.delegate selectHotCity:self.hotCityArr[indexPath.row]];
        //[self.delegate selectCity:@"台南市"];
        [self.CurrentViewController.navigationController popViewControllerAnimated:YES];
    }
}

-(void)setHotCityArr:(NSArray *)hotCityArr{
    _hotCityArr = hotCityArr;
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
