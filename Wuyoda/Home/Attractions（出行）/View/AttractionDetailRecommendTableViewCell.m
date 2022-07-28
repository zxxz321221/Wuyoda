//
//  AttractionDetailRecommendTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/18.
//

#import "AttractionDetailRecommendTableViewCell.h"
#import "AttractionDetailRecommendCollectionViewCell.h"
#import "AttractionDetailViewController.h"
#import "AttractionModel.h"

@interface AttractionDetailRecommendTableViewCell ()

@property (nonatomic , retain)UIImageView *imgV;
@property (nonatomic , retain)UILabel *titleLab;
@property (nonatomic , retain)UILabel *introLab;

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
//    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
//    fl.itemSize = CGSizeMake(kWidth(161), kWidth(170));
//    fl.sectionInset = UIEdgeInsetsMake(0, kWidth(20), kWidth(20), kWidth(20));
//    fl.minimumLineSpacing = kWidth(24);
//
//
//    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(194)*2+kWidth(16)) collectionViewLayout:fl];
//    self.collectionV.delegate = self;
//    self.collectionV.dataSource = self;
//    self.collectionV.backgroundColor = [ColorManager WhiteColor];
//    [self.collectionV registerClass:[AttractionDetailRecommendCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([AttractionDetailRecommendCollectionViewCell class])];
//    [self.contentView addSubview:self.collectionV];
    
    self.imgV = [[UIImageView alloc]init];
    self.imgV.layer.cornerRadius = kWidth(10);
    self.imgV.layer.masksToBounds = YES;
    [self.contentView addSubview:self.imgV];
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_offset(kWidth(100));
    }];
    
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.textColor= [ColorManager BlackColor];
    self.titleLab.font = kFont(14);
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgV.mas_right).mas_offset(kWidth(15));
        make.top.equalTo(self.imgV).mas_offset(kWidth(5));
        make.right.mas_offset(kWidth(-15));
    }];
    
    self.introLab = [[UILabel alloc]init];
    self.introLab.textColor= [ColorManager Color333333];
    self.introLab.font = kFont(12);
    self.introLab.numberOfLines = 4;
    self.introLab.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:self.introLab];
    [self.introLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgV.mas_right).mas_offset(kWidth(15));
        make.top.equalTo(self.titleLab.mas_bottom).mas_offset(kWidth(10));
        make.right.mas_offset(kWidth(-15));
    }];
}

//-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    AttractionDetailRecommendCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([AttractionDetailRecommendCollectionViewCell class]) forIndexPath:indexPath];
//    
//    cell.model = [self.otherArr objectAtIndex:indexPath.row];
//    
//    return cell;
//}
//
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 1;
//}
//
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return self.otherArr.count;
//}
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//}

//-(void)setOtherArr:(NSArray *)otherArr{
//    _otherArr = otherArr;
//    [self.collectionV reloadData];
//}

- (void)setModel:(AttractionModel *)model{
    _model = model;
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    self.titleLab.text = model.scenic_title;
    self.introLab.text = model.scenic_brief;
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
