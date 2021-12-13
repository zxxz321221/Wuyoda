//
//  AddressChangeView.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/11/15.
//

#import "AddressChangeView.h"

@interface AddressChangeView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , retain)UIView *lineV;

@property (nonatomic , retain)UILabel *proLab;
@property (nonatomic , retain)UILabel *cityLab;
@property (nonatomic , retain)UILabel *areaLab;

@property (nonatomic , retain)NSMutableArray *proArr;
@property (nonatomic , retain)NSMutableArray *cityArr;
@property (nonatomic , retain)NSMutableArray *areaArr;

@property (nonatomic , retain)UITableView *proTableView;
@property (nonatomic , retain)UITableView *cityTableView;
@property (nonatomic , retain)UITableView *areaTableView;

@property (nonatomic , copy)NSString *proStr;
@property (nonatomic , copy)NSString *cityStr;
@property (nonatomic , copy)NSString *areaStr;

@end

@implementation AddressChangeView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    UIView *shadowV = [[UIView alloc]initWithFrame:self.bounds];
    shadowV.backgroundColor = [ColorManager BlackColor];
    shadowV.alpha = 0.5;
    [self addSubview:shadowV];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height/4, kScreenWidth, self.bounds.size.height/4*3+kWidth(20))];
    bgView.backgroundColor = [ColorManager WhiteColor];
    bgView.layer.cornerRadius = kWidth(10);
    [self addSubview:bgView];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"请选择";
    titleLab.textColor = [ColorManager Color333333];
    titleLab.font = kFont(16);
    [bgView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView);
        make.top.mas_offset(kWidth(10));
    }];
    
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setImage:kGetImage(@"") forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(hiddenView) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(kWidth(-20));
        make.centerY.equalTo(titleLab);
        make.width.height.mas_offset(kWidth(15));
    }];
    
    self.proLab = [[UILabel alloc]init];
    self.proLab.font = kFont(12);
    self.proLab.userInteractionEnabled = YES;
    [bgView addSubview:self.proLab];
    [self.proLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(15));
        make.top.equalTo(titleLab.mas_bottom).mas_offset(kWidth(20));
    }];
    UITapGestureRecognizer *proTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectProClicked)];
    [self.proLab addGestureRecognizer:proTap];
    
    self.cityLab = [[UILabel alloc]init];
    self.cityLab.font = kFont(12);
    self.cityLab.userInteractionEnabled = YES;
    [bgView addSubview:self.cityLab];
    [self.cityLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.proLab.mas_right).mas_offset(kWidth(15));
        make.top.equalTo(titleLab.mas_bottom).mas_offset(kWidth(20));
    }];
    
    UITapGestureRecognizer *cityTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectCityClicked)];
    [self.cityLab addGestureRecognizer:cityTap];
    
    self.areaLab = [[UILabel alloc]init];
    self.areaLab.font = kFont(12);
    self.areaLab.userInteractionEnabled = YES;
    [bgView addSubview:self.areaLab];
    [self.areaLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cityLab.mas_right).mas_offset(kWidth(15));
        make.top.equalTo(titleLab.mas_bottom).mas_offset(kWidth(20));
    }];
    UITapGestureRecognizer *areaTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectAreaClicked)];
    [self.areaLab addGestureRecognizer:areaTap];
    
    self.lineV = [[UIView alloc]init];
    self.lineV.backgroundColor = [ColorManager MainColor];
    self.lineV.hidden = YES;
    [bgView addSubview:self.lineV];
    [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.proLab.mas_bottom).mas_offset(kWidth(10));
        make.centerX.equalTo(self.proLab);
        make.width.mas_offset(kWidth(10));
        make.height.mas_offset(kWidth(3));
    }];
    
    self.proTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.proTableView.delegate = self;
    self.proTableView.dataSource = self;
    [self.proTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"proTableViewCell"];
    self.proTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [bgView addSubview:self.proTableView];
    [self.proTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(bgView);
        make.top.mas_offset(kWidth(80));
        make.bottom.mas_offset(kWidth(-20));
    }];
    
    self.cityTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.cityTableView.delegate = self;
    self.cityTableView.dataSource = self;
    self.cityTableView.hidden = YES;
    self.cityTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.cityTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cityTableViewCell"];
    [bgView addSubview:self.cityTableView];
    [self.cityTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(bgView);
        make.top.mas_offset(kWidth(80));
        make.bottom.mas_offset(kWidth(-20));
    }];
    
    self.areaTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.areaTableView.delegate = self;
    self.areaTableView.dataSource = self;
    self.areaTableView.hidden = YES;
    self.areaTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.areaTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"areaTableViewCell"];
    [bgView addSubview:self.areaTableView];
    [self.areaTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(bgView);
        make.top.mas_offset(kWidth(80));
        make.bottom.mas_offset(kWidth(-20));
    }];
    if (!self.proArr) {
        self.proStr = @"";
        self.cityStr = @"";
        self.areaStr = @"";
        [self getProDataFromServer];
    }
}

-(void)getProDataFromServer{
    [FJNetTool postWithParams:@{} url:Special_pro_address loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            self.proArr = [responseObject[@"data"] mutableCopy];
            [self.proTableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}
-(void)getCityDataFromServer{
    [FJNetTool postWithParams:@{@"province":self.proStr} url:Special_city_address loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            self.cityArr = [responseObject[@"data"] mutableCopy];
            self.proTableView.hidden = YES;
            self.cityTableView.hidden = NO;
            [self.cityTableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}
-(void)getAreaDataFromServer{
    [FJNetTool postWithParams:@{@"province":self.proStr,@"city":self.cityStr} url:Special_county_address loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            self.areaArr = [responseObject[@"data"] mutableCopy];
            self.cityTableView.hidden = YES;
            self.areaTableView.hidden = NO;
            [self.areaTableView reloadData];
        }else if ([baseModel.msg isEqualToString:@"城市错误"]){
            if (self.delegate && [self.delegate respondsToSelector:@selector(selectAddress:CityStr:AreaStr:)]) {
                [self.delegate selectAddress:self.proStr CityStr:self.cityStr AreaStr:self.areaStr];

            }
            [self hiddenView];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)hiddenView{
    self.hidden = YES;
}
-(void)selectProClicked{
    self.proLab.textColor = [ColorManager MainColor];
    self.cityLab.textColor = [ColorManager Color333333];
    self.areaLab.textColor = [ColorManager Color333333];
    self.proTableView.hidden = NO;
    self.cityTableView.hidden = YES;
    self.areaTableView.hidden = YES;
//    [self.lineV mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.proLab);
//    }];
}
-(void)selectCityClicked{
    self.proLab.textColor = [ColorManager Color333333];
    self.cityLab.textColor = [ColorManager MainColor];
    self.areaLab.textColor = [ColorManager Color333333];
    self.proTableView.hidden = YES;
    self.cityTableView.hidden = NO;
    self.areaTableView.hidden = YES;
//    [self.lineV mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.cityLab);
//    }];
}
-(void)selectAreaClicked{
    self.proLab.textColor = [ColorManager Color333333];
    self.cityLab.textColor = [ColorManager Color333333];
    self.areaLab.textColor = [ColorManager MainColor];
    self.proTableView.hidden = YES;
    self.cityTableView.hidden = YES;
    self.areaTableView.hidden = NO;
//    [self.lineV mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.areaLab);
//    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.proTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"proTableViewCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"proTableViewCell"];
        }
        
        cell.textLabel.text = [self.proArr objectAtIndex:indexPath.row];
        cell.textLabel.textColor = [ColorManager Color666666];
        cell.textLabel.font = kFont(12);
        
        return cell;
    }else if (tableView == self.cityTableView){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityTableViewCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cityTableViewCell"];
        }
        
        cell.textLabel.text = [self.cityArr objectAtIndex:indexPath.row];
        cell.textLabel.textColor = [ColorManager Color666666];
        cell.textLabel.font = kFont(12);
        
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"areaTableViewCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"areaTableViewCell"];
        }
        
        cell.textLabel.text = [self.areaArr objectAtIndex:indexPath.row];
        cell.textLabel.textColor = [ColorManager Color666666];
        cell.textLabel.font = kFont(12);
        
        return cell;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.proTableView) {
        return self.proArr.count;
    }else if (tableView == self.cityTableView){
        return self.cityArr.count;
    }else{
        return self.areaArr.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kWidth(44);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.proTableView) {
        self.proStr = [self.proArr objectAtIndex:indexPath.row];
        self.proLab.text = self.proStr;
        self.proLab.textColor = [ColorManager Color333333];
        self.cityStr = @"";
        self.areaStr = @"";
        self.cityLab.text = @"请选择城市";
        self.cityLab.textColor = [ColorManager MainColor];
        self.areaLab.text = self.areaStr;
//        self.lineV.hidden = NO;
//        [self.lineV mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self.cityLab);
//        }];
        [self getCityDataFromServer];
    }
    if (tableView == self.cityTableView) {
        self.cityStr = [self.cityArr objectAtIndex:indexPath.row];
        self.cityLab.text = self.cityStr;
        self.cityLab.textColor = [ColorManager Color333333];
        self.proLab.textColor = [ColorManager Color333333];
        self.areaStr = @"";
        self.areaLab.text = @"请选择区";
        self.areaLab.textColor = [ColorManager MainColor];
//        [self.lineV mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self.areaLab);
//        }];
        [self getAreaDataFromServer];
    }
    if (tableView == self.areaTableView) {
        self.areaStr = [self.areaArr objectAtIndex:indexPath.row];
        self.areaLab.text = self.areaStr;
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectAddress:CityStr:AreaStr:)]) {
            [self.delegate selectAddress:self.proStr CityStr:self.cityStr AreaStr:self.areaStr];

        }
        [self hiddenView];
        NSLog(@"address:%@%@%@",self.proStr,self.cityStr,self.areaStr);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
