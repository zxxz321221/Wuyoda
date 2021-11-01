//
//  EvaluateImageTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/13.
//

#import "EvaluateImageTableViewCell.h"
#import "EvaluateImageCollectionViewCell.h"

@interface EvaluateImageTableViewCell ()<UICollectionViewDelegate ,UICollectionViewDataSource>

@property (nonatomic , retain)UICollectionView *collectionV;

@end

@implementation EvaluateImageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    
    return self;
}

-(void)createUI{
    UILabel *titlaLab = [[UILabel alloc]init];
    titlaLab.text = @"添加视频/图片";
    titlaLab.textColor = [ColorManager Color333333];
    titlaLab.font = kFont(14);
    [self.contentView addSubview:titlaLab];
    [titlaLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(24));
        make.top.mas_offset(0);
    }];
    
    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
    fl.itemSize = CGSizeMake(kWidth(100), kWidth(80));
    fl.sectionInset = UIEdgeInsetsMake(0, kWidth(24), 0, kWidth(24));
    fl.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kWidth(38), kScreenWidth, kWidth(80)) collectionViewLayout:fl];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    self.collectionV.backgroundColor = [ColorManager WhiteColor];
    [self.collectionV registerClass:[EvaluateImageCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([EvaluateImageCollectionViewCell class])];
    [self.contentView addSubview:self.collectionV];
    
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    EvaluateImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([EvaluateImageCollectionViewCell class]) forIndexPath:indexPath];
    
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
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
