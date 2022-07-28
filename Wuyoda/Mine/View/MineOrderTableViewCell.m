//
//  MineOrderTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/28.
//

#import "MineOrderTableViewCell.h"
#import "MineOrderCollectionViewCell.h"
#import "SecurityCenterViewController.h"
#import "FootprintViewController.h"
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
    
    self.backgroundColor = [ColorManager ColorF2F2F2];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(kWidth(10), 0, kWidth(355), kWidth(228))];
    bgView.backgroundColor = [ColorManager WhiteColor];
    bgView.layer.cornerRadius = kWidth(10);
    [self.contentView addSubview:bgView];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.textColor = [ColorManager BlackColor];
    titleLab.font = kFont(16);
    titleLab.text = @"我的订单";
    [bgView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(10));
        make.top.mas_offset(kWidth(20));
    }];
    
    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
    fl.itemSize = CGSizeMake(kWidth(80), kWidth(56));
    fl.sectionInset = UIEdgeInsetsMake(0, kWidth(30), kWidth(20), kWidth(30));
    fl.minimumLineSpacing = kWidth(30);
    
    
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kWidth(66), kWidth(355), kWidth(164)) collectionViewLayout:fl];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    self.collectionV.backgroundColor = [ColorManager WhiteColor];
    self.collectionV.layer.cornerRadius = kWidth(10);
    [self.collectionV registerClass:[MineOrderCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MineOrderCollectionViewCell class])];
    [bgView addSubview:self.collectionV];
    
    self.titleArr = @[@"全部订单",@"有效订单",@"待支付订单",@"安全中心",@"获取帮助",@"历史足迹"];
    
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
    
    if (![CommonManager isLogin:self.CurrentViewController isPush:YES]) {
        return;
    }
    
    if (indexPath.row == 0) {
        OrderViewController *vc = [[OrderViewController alloc]init];
        [self.CurrentViewController.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 1) {
        OrderViewController *vc = [[OrderViewController alloc]init];
        vc.type = @"4";
        [self.CurrentViewController.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 2) {
        OrderViewController *vc = [[OrderViewController alloc]init];
        vc.type = @"2";
        [self.CurrentViewController.navigationController pushViewController:vc animated:YES];
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
        FootprintViewController *vc = [[FootprintViewController alloc]init];
        [self.CurrentViewController.navigationController pushViewController:vc animated:YES];
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
