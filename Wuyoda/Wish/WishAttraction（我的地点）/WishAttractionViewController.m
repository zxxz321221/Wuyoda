//
//  WishAttractionViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/23.
//

#import "WishAttractionViewController.h"
#import "AttractionDetailRecommendCollectionViewCell.h"

@interface WishAttractionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , retain)UICollectionView *collectionV;

@end

@implementation WishAttractionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"我的地点"];
    [self.view addSubview:nav];
    
    UIButton *editBtn = [[UIButton alloc]init];
    [editBtn setTitle:@"管理" forState:UIControlStateNormal];
    [editBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
    editBtn.titleLabel.font = kFont(14);
    [editBtn addTarget:self action:@selector(editClicked:) forControlEvents:UIControlEventTouchUpInside];
    [nav addSubview:editBtn];
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(nav);
        make.right.mas_offset(kWidth(-13));
        make.width.height.mas_offset(kHeight_NavBar-kHeight_StatusBar);
    }];
    
    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
    fl.itemSize = CGSizeMake(kWidth(161), kWidth(170));
    fl.sectionInset = UIEdgeInsetsMake(0, kWidth(20), kWidth(20), kWidth(20));
    fl.minimumLineSpacing = kWidth(24);
    
    
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea) collectionViewLayout:fl];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    self.collectionV.backgroundColor = [ColorManager WhiteColor];
    [self.collectionV registerClass:[AttractionDetailRecommendCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([AttractionDetailRecommendCollectionViewCell class])];
    [self.view addSubview:self.collectionV];
}

-(void)editClicked:(UIButton *)sender{
    
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AttractionDetailRecommendCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([AttractionDetailRecommendCollectionViewCell class]) forIndexPath:indexPath];
    
    //cell.imgName = [NSString stringWithFormat:@"home_attractions%ld",indexPath.row+1];
    
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
