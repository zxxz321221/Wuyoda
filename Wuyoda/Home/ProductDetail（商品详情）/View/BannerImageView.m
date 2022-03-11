//
//  BannerImageView.m
//  Wuyoda
//
//  Created by 赵祥 on 2022/1/11.
//

#import "BannerImageView.h"
#import "BannerImageCollectionViewCell.h"

@interface BannerImageView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , retain)UICollectionView *collectionV;

@property (nonatomic , retain)UILabel *pageLab;

@end

@implementation BannerImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
    fl.itemSize = CGSizeMake(kScreenWidth, kScreenHeight);
    fl.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    fl.minimumLineSpacing = 0;
    
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:fl];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    self.collectionV.backgroundColor = [ColorManager BlackColor];
    [self.collectionV registerClass:[BannerImageCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([BannerImageCollectionViewCell class])];
    self.collectionV.pagingEnabled = YES;
    self.collectionV.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.collectionV];
    
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setImage:kGetImage(@"商品详情_关闭") forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-20));
        make.top.mas_offset(kHeight_StatusBar +kWidth(15));
        make.width.height.mas_offset(kWidth(20));
    }];
    
    self.pageLab = [[UILabel alloc]init];
    self.pageLab.textColor = [ColorManager WhiteColor];
    self.pageLab.font = kFont(14);
    [self addSubview:self.pageLab];
    [self.pageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.mas_offset(-kHeight_SafeArea-kWidth(15));
    }];
    
}

-(void)closeClicked{
    [self removeFromSuperview];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BannerImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([BannerImageCollectionViewCell class]) forIndexPath:indexPath];
    
    cell.model = [self.bannerArr objectAtIndex:indexPath.row];
    
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.bannerArr.count;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.currentPage = scrollView.contentOffset.x/kScreenWidth;
}

-(void)setBannerArr:(NSArray *)bannerArr{
    _bannerArr = bannerArr;
    [self.collectionV reloadData];
}

-(void)setCurrentPage:(NSInteger)currentPage{
    _currentPage = currentPage;
    self.pageLab.text = [NSString stringWithFormat:@"%ld/%ld",currentPage+1,self.bannerArr.count];
    [self.collectionV scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:currentPage inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
