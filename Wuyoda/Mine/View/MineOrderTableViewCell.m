//
//  MineOrderTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/28.
//

#import "MineOrderTableViewCell.h"
#import "MineOrderCollectionViewCell.h"
#import "SecurityCenterViewController.h"
#import "OrderViewController.h"
#import "HelperViewController.h"

@interface MineOrderTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , retain)UICollectionView *collectionV;

@property (nonatomic , retain)NSArray *titleArr;

@end

@implementation MineOrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    
    return self;
}

-(void)createUI{
    
    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
    fl.itemSize = CGSizeMake(kWidth(80), kWidth(62));
    fl.sectionInset = UIEdgeInsetsMake(kWidth(16), kWidth(35), kWidth(24), kWidth(40));
    fl.minimumLineSpacing = kWidth(45);
    
    
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(235)) collectionViewLayout:fl];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    self.collectionV.backgroundColor = [ColorManager WhiteColor];
    [self.collectionV registerClass:[MineOrderCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MineOrderCollectionViewCell class])];
    [self.contentView addSubview:self.collectionV];
    
    self.titleArr = @[@"全部订单",@"有效订单",@"待支付订单",@"安全中心",@"获取帮助",@"历史足迹"];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = [ColorManager ColorF2F2F2];
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.equalTo(self);
        make.width.mas_offset(kWidth(335));
        make.height.mas_offset(kWidth(1));
    }];
    
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MineOrderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MineOrderCollectionViewCell class]) forIndexPath:indexPath];
    NSString *titleStr = [self.titleArr objectAtIndex:indexPath.row];
    cell.titleLab.text = titleStr;
    [cell.imgV setImage:kGetImage(titleStr)];
    
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titleArr.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        OrderViewController *vc = [[OrderViewController alloc]init];
        [self.CurrentViewController.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 1) {
        
    }
    if (indexPath.row == 2) {
        
    }
    if (indexPath.row == 3) {
        SecurityCenterViewController *vc = [[SecurityCenterViewController alloc]init];
        [self.CurrentViewController.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 4) {
        HelperViewController *vc = [[HelperViewController alloc]init];
        [self.CurrentViewController.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 5) {
        
    }
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
