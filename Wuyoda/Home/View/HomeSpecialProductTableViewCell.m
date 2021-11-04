//
//  HomeSpecialProductTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/14.
//

#import "HomeSpecialProductTableViewCell.h"
#import "HomeSpecialCollectionViewCell.h"
#import "ProductDetailViewController.h"

@interface HomeSpecialProductTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , retain)NSMutableArray *btnArr;

@property (nonatomic , retain)UIScrollView *typeScrollV;

@property (nonatomic , retain)UICollectionView *collectionV;

@end

@implementation HomeSpecialProductTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.typeScrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(kWidth(20), 0, kScreenWidth-kWidth(20), kWidth(50))];
    self.typeScrollV.backgroundColor = [ColorManager ColorF7F7F7];
    [self.contentView addSubview:self.typeScrollV];
    
    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
    fl.itemSize = CGSizeMake(kWidth(161), kWidth(210));
    fl.sectionInset = UIEdgeInsetsMake(kWidth(23), kWidth(20), kWidth(24), kWidth(20));
    fl.minimumLineSpacing = kWidth(24);
    
    
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kWidth(50), kScreenWidth, kWidth(234)*2+kWidth(24)) collectionViewLayout:fl];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    self.collectionV.backgroundColor = [ColorManager WhiteColor];
    [self.collectionV registerClass:[HomeSpecialCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([HomeSpecialCollectionViewCell class])];
    [self.contentView addSubview:self.collectionV];

}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeSpecialCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomeSpecialCollectionViewCell class]) forIndexPath:indexPath];
    
    //cell.imgName = [NSString stringWithFormat:@"home_special_good%ld",indexPath.row+1];
    cell.model = [self.shopArr objectAtIndex:indexPath.row];
    
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.shopArr.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductDetailViewController *vc = [[ProductDetailViewController alloc]init];
    [self.CurrentViewController.navigationController pushViewController:vc animated:YES];
}

-(void)setTypeArr:(NSArray *)typeArr{
    _typeArr = typeArr;
    self.btnArr = [[NSMutableArray alloc]init];
    for (int i = 0; i<typeArr.count; i++) {
        UIButton *typeBtn = [[UIButton alloc]initWithFrame:CGRectMake(kWidth(81)*i, kWidth(5), kWidth(73), kWidth(40))];
        [typeBtn setTitle:[typeArr objectAtIndex:i] forState:UIControlStateNormal];
        typeBtn.titleLabel.font = kFont(14);
        typeBtn.layer.cornerRadius = kWidth(5);
        if (i == self.typeIndex) {
            [typeBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
            typeBtn.backgroundColor = [ColorManager MainColor];
        }else{
            [typeBtn setTitleColor:[ColorManager Color777777] forState:UIControlStateNormal];
            typeBtn.backgroundColor = [ColorManager WhiteColor];
        }
        [typeBtn addTarget:self action:@selector(changeTypeClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.typeScrollV addSubview:typeBtn];
        [self.btnArr addObject:typeBtn];
    }
    self.typeScrollV.contentSize = CGSizeMake(kWidth(81)*typeArr.count, 0);
}

-(void)changeTypeClicked:(UIButton *)sender{
    for (int i = 0; i<self.btnArr.count; i++) {
        UIButton *btn = [self.btnArr objectAtIndex:i];
        if (btn == sender) {
            [btn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
            btn.backgroundColor = [ColorManager MainColor];
            [self.collectionV reloadData];
            if (self.delegate && [self.delegate respondsToSelector:@selector(selectSpecailProductType:)]) {
                [self.delegate selectSpecailProductType:i];
            }
        }else{
            [btn setTitleColor:[ColorManager Color777777] forState:UIControlStateNormal];
            btn.backgroundColor = [ColorManager WhiteColor];
        }
    }
}

-(void)setShopArr:(NSArray *)shopArr{
    _shopArr = shopArr;
    [self.collectionV reloadData];
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
