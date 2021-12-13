//
//  CityPresentTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/22.
//

#import "CityPresentTableViewCell.h"
#import "CityPresentCollectionViewCell.h"

@interface CityPresentTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , retain)UICollectionView *collectionV;

@end

@implementation CityPresentTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
    fl.itemSize = CGSizeMake(kWidth(100), kWidth(130));
    fl.sectionInset = UIEdgeInsetsMake(kWidth(20), kWidth(20), kWidth(20), kWidth(20));
    fl.minimumLineSpacing = kWidth(18);
    fl.scrollDirection = UICollectionViewScrollDirectionHorizontal;


    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(170)) collectionViewLayout:fl];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    self.collectionV.backgroundColor = [ColorManager WhiteColor];
    self.collectionV.showsHorizontalScrollIndicator = NO;
    [self.collectionV registerClass:[CityPresentCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([CityPresentCollectionViewCell class])];
    [self.contentView addSubview:self.collectionV];
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CityPresentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CityPresentCollectionViewCell class]) forIndexPath:indexPath];
    
    cell.model = [self.goodsArr objectAtIndex:indexPath.row];

    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.goodsArr.count;
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
