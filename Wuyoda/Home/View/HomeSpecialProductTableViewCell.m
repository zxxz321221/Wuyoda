//
//  HomeSpecialProductTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/14.
//

#import "HomeSpecialProductTableViewCell.h"
#import "HomeSpecialCollectionViewCell.h"
#import "ProductDetailViewController.h"
#import "HomeSpecialCollectionHeaderView.h"
#import "HomeSpecialNewCollectionViewCell.h"


@interface HomeSpecialProductTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , retain)NSMutableArray *btnArr;
//@property (nonatomic , retain)NSMutableArray *bgViewArr;

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
    
    
    
    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
    fl.itemSize = CGSizeMake(kWidth(160), kWidth(240));
    fl.sectionInset = UIEdgeInsetsMake(kWidth(23), kWidth(20), kWidth(24), kWidth(20));
    fl.minimumLineSpacing = kWidth(24);
    
    
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kWidth(70), kScreenWidth, kWidth(260)*3+kWidth(413)+kWidth(24)) collectionViewLayout:fl];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    self.collectionV.backgroundColor = [ColorManager WhiteColor];
    self.collectionV.showsVerticalScrollIndicator = NO;
    self.collectionV.scrollEnabled = NO;
    [self.collectionV registerClass:[HomeSpecialNewCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([HomeSpecialNewCollectionViewCell class])];
    [self.collectionV registerClass:[HomeSpecialCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"homeSpecialHeader"];
    [self.contentView addSubview:self.collectionV];

}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeSpecialNewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomeSpecialNewCollectionViewCell class]) forIndexPath:indexPath];
    
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
    HomeShopModel *model = [self.shopArr objectAtIndex:indexPath.row];
    ProductDetailViewController *vc = [[ProductDetailViewController alloc]init];
    vc.uid = model.uid;
    vc.supplier_id = model.supplier_id;
    [self.CurrentViewController.navigationController pushViewController:vc animated:YES];
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseIdentifier;
    // header
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        reuseIdentifier = @"homeSpecialHeader";
        HomeSpecialCollectionHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        view.model = self.topGoodModel;

        return view;
        
    }
    return nil;
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (self.topGoodModel) {
        return CGSizeMake(kScreenWidth, kWidth(413));
    }
    return CGSizeMake(0.1, 0.1);
}

-(void)setTypeArr:(NSArray *)typeArr{
    _typeArr = typeArr;

    if (self.typeScrollV) {
        [self.typeScrollV removeFromSuperview];
    }
    
    self.typeScrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(50))];
    self.typeScrollV.backgroundColor = [ColorManager WhiteColor];
    self.typeScrollV.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:self.typeScrollV];
    
    self.btnArr = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<typeArr.count; i++) {
        HomeCategoryModel *model = [typeArr objectAtIndex:i];
        CGFloat strW = [LCTools widthWithString:model.category_name font:kWidth(14)];
        if (strW<kWidth(60)) {
            strW = kWidth(80);
        }else{
            strW += kWidth(20);
        }
        
        UIButton *typeBtn = [[UIButton alloc]init];
        if (i == 0) {
            typeBtn.frame = CGRectMake(kWidth(20), kWidth(5), strW, kWidth(40));
        }else{
            UIButton *lastBtn = [self.btnArr lastObject];
            typeBtn.frame = CGRectMake(lastBtn.frame.origin.x+lastBtn.bounds.size.width+kWidth(10), kWidth(5), strW, kWidth(40));
        }
        [typeBtn setTitle:model.category_name forState:UIControlStateNormal];
        typeBtn.titleLabel.font = kFont(14);
        typeBtn.backgroundColor = [ColorManager WhiteColor];
        typeBtn.layer.cornerRadius = kWidth(5);
        if (i == self.typeIndex) {
            [typeBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
            [typeBtn setBackgroundImage:kGetImage(@"推荐按钮") forState:UIControlStateNormal];
            
        }else{
            [typeBtn setTitleColor:[ColorManager Color777777] forState:UIControlStateNormal];
            //[typeBtn setBackgroundImage:kGetImage(@"") forState:UIControlStateNormal];
        }
        [typeBtn addTarget:self action:@selector(changeTypeClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        typeBtn.layer.shadowColor = [ColorManager BlackColor].CGColor;
        //阴影偏移量
        typeBtn.layer.shadowOffset = CGSizeMake(0, 4);
        //定义view的阴影宽度，模糊计算的半径
        typeBtn.layer.shadowRadius = 6;
        //定义view的阴影透明度，注意:如果view没有设置背景色阴影也是不会显示的
        typeBtn.layer.shadowOpacity = 0.15;
        
        [self.typeScrollV addSubview:typeBtn];
        [self.btnArr addObject:typeBtn];

    }
    UIButton *lastBtn = [self.btnArr lastObject];
    self.typeScrollV.contentSize = CGSizeMake(lastBtn.frame.origin.x+lastBtn.bounds.size.width+kWidth(10), 0);
}

-(void)changeTypeClicked:(UIButton *)sender{
    for (int i = 0; i<self.btnArr.count; i++) {
        UIButton *btn = [self.btnArr objectAtIndex:i];
        
        if (btn == sender) {
            [btn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
            [btn setBackgroundImage:kGetImage(@"推荐按钮") forState:UIControlStateNormal];
            [self.collectionV reloadData];
            if (self.delegate && [self.delegate respondsToSelector:@selector(selectSpecailProductType:)]) {
                [self.delegate selectSpecailProductType:i];
            }
        }else{
            [btn setTitleColor:[ColorManager Color777777] forState:UIControlStateNormal];
            [btn setBackgroundImage:kGetImage(@"") forState:UIControlStateNormal];
        }
        //定义view的阴影颜色
        btn.layer.shadowColor = [ColorManager BlackColor].CGColor;
        //阴影偏移量
        btn.layer.shadowOffset = CGSizeMake(0, 3);
        //定义view的阴影宽度，模糊计算的半径
        btn.layer.shadowRadius = 4;
        //定义view的阴影透明度，注意:如果view没有设置背景色阴影也是不会显示的
        btn.layer.shadowOpacity = 0.15;
    }
}

-(void)setShopArr:(NSArray *)shopArr{
    _shopArr = shopArr;
    [self.collectionV reloadData];
}

-(void)setTopGoodModel:(HomeShopModel *)topGoodModel{
    _topGoodModel = topGoodModel;
    
    CGFloat height = 0;
    if (self.topGoodModel) {
        height += +kWidth(413);
    }
    NSInteger line = self.shopArr.count/2;
    if (self.shopArr.count%2) {
        line += 1;
    }
    
    height += kWidth(260)*line;
    self.collectionV.frame = CGRectMake(0, kWidth(70), kScreenWidth, height + kWidth(24)*2);
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
