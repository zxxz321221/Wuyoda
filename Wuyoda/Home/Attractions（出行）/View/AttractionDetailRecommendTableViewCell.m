//
//  AttractionDetailRecommendTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/18.
//

#import "AttractionDetailRecommendTableViewCell.h"
#import "AttractionDetailRecommendCollectionViewCell.h"

@interface AttractionDetailRecommendTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , retain)UICollectionView *collectionV;

@end

@implementation AttractionDetailRecommendTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    
    return self;
}

-(void)createUI{
    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
    fl.itemSize = CGSizeMake(kWidth(161), kWidth(170));
    fl.sectionInset = UIEdgeInsetsMake(0, kWidth(20), kWidth(20), kWidth(20));
    fl.minimumLineSpacing = kWidth(24);
    
    
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(194)*2+kWidth(16)) collectionViewLayout:fl];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    self.collectionV.backgroundColor = [ColorManager WhiteColor];
    [self.collectionV registerClass:[AttractionDetailRecommendCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([AttractionDetailRecommendCollectionViewCell class])];
    [self.contentView addSubview:self.collectionV];
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AttractionDetailRecommendCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([AttractionDetailRecommendCollectionViewCell class]) forIndexPath:indexPath];
    
    cell.model = [self.otherArr objectAtIndex:indexPath.row];
    
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.otherArr.count;
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
