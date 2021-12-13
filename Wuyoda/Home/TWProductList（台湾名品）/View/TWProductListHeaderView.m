//
//  TWProductListHeaderView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/17.
//

#import "TWProductListHeaderView.h"
#import "HomeSearchCityCollectionViewCell.h"

@interface TWProductListHeaderView ()<UICollectionViewDelegate,UICollectionViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic , retain)UICollectionView *collectionV;


@property (nonatomic , retain)NSArray *tableArr;

@end

@implementation TWProductListHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.backgroundColor = [ColorManager WhiteColor];
    self.addressBtn = [[UIButton alloc]init];
    [self.addressBtn setTitle:@"城市" forState:UIControlStateNormal];
    [self.addressBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
    self.addressBtn.titleLabel.font = kFont(12);
    [self.addressBtn setImage:kGetImage(@"下拉icon") forState:UIControlStateNormal];
    [self.addressBtn setImage:kGetImage(@"") forState:UIControlStateSelected];
    self.addressBtn.imageEdgeInsets = UIEdgeInsetsMake(0, kWidth(85), 0, 0);
    [self addSubview:self.addressBtn];
    [self.addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(20));
        make.top.mas_offset(kWidth(10));
        make.width.mas_offset(kWidth(95));
        make.height.mas_offset(kWidth(30));
    }];
    
    self.typeBtn = [[UIButton alloc]init];
    [self.typeBtn setTitle:@"分类" forState:UIControlStateNormal];
    [self.typeBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
    self.typeBtn.titleLabel.font = kFont(12);
    [self.typeBtn setImage:kGetImage(@"下拉icon") forState:UIControlStateNormal];
    [self.typeBtn setImage:kGetImage(@"") forState:UIControlStateSelected];
    self.typeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, kWidth(85), 0, 0);
//    [self.typeBtn addTarget:self action:@selector(selectTypeClicekd:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.typeBtn];
    [self.typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.mas_offset(kWidth(10));
        make.width.mas_offset(kWidth(95));
        make.height.mas_offset(kWidth(30));
    }];
    
    self.priceBtn = [[UIButton alloc]init];
    [self.priceBtn setTitle:@"价格" forState:UIControlStateNormal];
    [self.priceBtn setTitleColor:[ColorManager BlackColor] forState:UIControlStateNormal];
    self.priceBtn.titleLabel.font = kFont(12);
    [self.priceBtn setImage:kGetImage(@"下拉icon") forState:UIControlStateNormal];
    [self.priceBtn setImage:kGetImage(@"") forState:UIControlStateSelected];
//    [self.priceBtn addTarget:self action:@selector(selectTypeClicekd:) forControlEvents:UIControlEventTouchUpInside];
    self.priceBtn.imageEdgeInsets = UIEdgeInsetsMake(0, kWidth(75), 0, 0);
    [self addSubview:self.priceBtn];
    [self.priceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-20));
        make.top.mas_offset(kWidth(10));
        make.width.mas_offset(kWidth(86));
        make.height.mas_offset(kWidth(30));
    }];
    
//    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
//    fl.itemSize = CGSizeMake(kWidth(76), kWidth(32));
//    fl.sectionInset = UIEdgeInsetsMake(kWidth(0), kWidth(20), kWidth(0), kWidth(20));
//    fl.minimumLineSpacing = kWidth(16);
    
//    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kWidth(48), kScreenWidth, kWidth(36)*2) collectionViewLayout:fl];
//    self.collectionV.delegate = self;
//    self.collectionV.dataSource = self;
//    self.collectionV.backgroundColor = [ColorManager WhiteColor];
//    [self.collectionV registerClass:[HomeSearchCityCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([HomeSearchCityCollectionViewCell class])];
//    [self addSubview:self.collectionV];
    
//    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 1, 1) style:UITableViewStylePlain];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"searchTypeTableViewCell"];
//    self.tableView.hidden = YES;
//    [self addSubview:self.tableView];
    
    self.tableArr = [[NSArray alloc]init];
    //self.recommendArr = [[NSMutableArray alloc]initWithObjects:@"凤梨酥",@"高山茶",@"手工皂", nil];
}

//-(void)selectTypeClicekd:(UIButton *)sender{
//    sender.selected = !sender.isSelected;
//    if (sender == self.addressBtn) {
//        self.selectType = @"0";
////        if ([self.type isEqualToString:@"1"]) {
////            self.tableView.frame = CGRectMake(self.addressBtn.frame.origin.x, 45+kHeight_NavBar+kWidth(30), kWidth(100), kWidth(80));
////        }else{
////            self.tableView.frame = CGRectMake(self.addressBtn.frame.origin.x, 45+kHeight_NavBar, kWidth(100), kWidth(80));
////        }
//        
//        self.tableArr = self.allCityArr;
//        //[self.tableView reloadData];
//        self.typeBtn.selected = NO;
//        self.priceBtn.selected = NO;
//    }
//    if (sender == self.typeBtn) {
//        self.selectType = @"1";
////        if ([self.type isEqualToString:@"1"]) {
////            self.tableView.frame = CGRectMake(self.typeBtn.frame.origin.x, 45+kHeight_NavBar+kWidth(30), kWidth(100), kWidth(80));
////        }else{
////            self.tableView.frame = CGRectMake(self.typeBtn.frame.origin.x, 45+kHeight_NavBar, kWidth(100), kWidth(80));
////        }
//        self.tableArr = @[@"台湾名品",@"宝岛礼盒",@"特惠商品"];
//        //[self.tableView reloadData];
//        self.addressBtn.selected = NO;
//        self.priceBtn.selected = NO;
//    }
//    if (sender == self.priceBtn) {
//        self.selectType = @"2";
////        if ([self.type isEqualToString:@"1"]) {
////            self.tableView.frame = CGRectMake(self.priceBtn.frame.origin.x, 45+kHeight_NavBar+kWidth(30), kWidth(100), kWidth(80));
////        }else{
////            self.tableView.frame = CGRectMake(self.priceBtn.frame.origin.x, 45+kHeight_NavBar, kWidth(100), kWidth(80));
////        }
//        self.tableArr = @[@"由低到高",@"由高到低"];
//        //[self.tableView reloadData];
//        self.typeBtn.selected = NO;
//        self.addressBtn.selected = NO;
//    }
//    //self.tableView.hidden = !sender.isSelected;
//}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeSearchCityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomeSearchCityCollectionViewCell class]) forIndexPath:indexPath];
    
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.recommendArr.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchTypeTableViewCell" forIndexPath:indexPath];
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"searchTypeTableViewCell"];
//    }
//    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    
//    cell.textLabel.text = [self.tableArr objectAtIndex:indexPath.row];
//    cell.textLabel.textColor = [ColorManager Color333333];
//    cell.textLabel.font = kFont(12);
//    
//    return cell;
//}
//
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.tableArr.count;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return kWidth(30);
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSString *selectStr = [self.tableArr objectAtIndex:indexPath.row];
//    if ([self.selectType isEqualToString:@"0"]) {
//        self.addressBtn.selected = NO;
//        [self.addressBtn setTitle:selectStr forState:UIControlStateNormal];
//        if (self.delegate && [self.delegate respondsToSelector:@selector(changeSearchCity:)]) {
//            [self.delegate changeSearchCity:selectStr];
//        }
//    }
//    if ([self.selectType isEqualToString:@"1"]) {
//        self.typeBtn.selected = NO;
//        [self.typeBtn setTitle:selectStr forState:UIControlStateNormal];
//        if (self.delegate && [self.delegate respondsToSelector:@selector(changeSearchTitle:)]) {
//            [self.delegate changeSearchTitle:selectStr];
//        }
//    }
//    if ([self.selectType isEqualToString:@"2"]) {
//        self.priceBtn.selected = NO;
//        [self.priceBtn setTitle:selectStr forState:UIControlStateNormal];
//        if (self.delegate && [self.delegate respondsToSelector:@selector(changeSearchPrice:)]) {
//            if ([selectStr isEqualToString:@"由低到高"]) {
//                [self.delegate changeSearchPrice:@"1"];
//            }else{
//                [self.delegate changeSearchPrice:@"0"];
//            }
//            
//        }
//    }
//    tableView.hidden = YES;
//}

-(void)setRecommendArr:(NSMutableArray *)recommendArr{
    _recommendArr = recommendArr;
    [self.collectionV reloadData];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
