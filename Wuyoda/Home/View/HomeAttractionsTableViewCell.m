//
//  HomeAttractionsTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/14.
//

#import "HomeAttractionsTableViewCell.h"
#import "HomeAttractionsCollectionViewCell.h"
#import "AttractionsListViewController.h"
#import "CityDetailViewController.h"
#import "HomeModel.h"

@interface HomeAttractionsTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , retain)UICollectionView *collectionV;

@end

@implementation HomeAttractionsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
    fl.itemSize = CGSizeMake(kWidth(138), kWidth(168));
    fl.sectionInset = UIEdgeInsetsMake(0, kWidth(20), 0, kWidth(20));
    fl.minimumLineSpacing = kWidth(12);
    fl.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(168)) collectionViewLayout:fl];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    self.collectionV.backgroundColor = [ColorManager WhiteColor];
    [self.collectionV registerClass:[HomeAttractionsCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([HomeAttractionsCollectionViewCell class])];
    self.collectionV.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:self.collectionV];
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeAttractionsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomeAttractionsCollectionViewCell class]) forIndexPath:indexPath];
    
    //cell.imgName = [NSString stringWithFormat:@"home_attractions%ld",indexPath.row+1];
    cell.model = [self.cityArr objectAtIndex:indexPath.row];
    
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.cityArr.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    AttractionsListViewController *vc = [[AttractionsListViewController alloc] init];
//    [self.CurrentViewController.navigationController pushViewController:vc animated:YES];
    
    HomeCityModel *model = [self.cityArr objectAtIndex:indexPath.row];
    CityDetailViewController *vc = [[CityDetailViewController alloc]init];
    vc.cityID = model.uid;
    [self.CurrentViewController.navigationController pushViewController:vc animated:YES];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCityArr:(NSMutableArray *)cityArr{
    _cityArr = cityArr;
    [self.collectionV reloadData];
}

@end
