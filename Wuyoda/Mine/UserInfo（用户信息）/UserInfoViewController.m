//
//  UserInfoViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/8.
//

#import "UserInfoViewController.h"
#import "UserInfoTableViewCell.h"
#import "UserBirthdayView.h"

@interface UserInfoViewController ()<UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UserInfoBirthdayDelegate>

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)UIImageView *iconImgV;

@property (nonatomic , retain)UITextField *nameField;

@property (nonatomic , retain)UIButton *manBtn;

@property (nonatomic , retain)UIButton *womenBtn;

@property (nonatomic , retain)UITextField *birthdayField;

@property (nonatomic , copy)NSString *nameStr;
@property (nonatomic , copy)NSString *sexStr;
@property (nonatomic , copy)NSString *birthdayStr;

@property (nonatomic , retain)UserBirthdayView *birthdayV;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"编辑个人资料"];
    nav.backgroundColor = [ColorManager ColorF2F2F2];
    [self.view addSubview:nav];
    
    self.view.backgroundColor = [ColorManager ColorF2F2F2];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar+kWidth(20), kScreenWidth, kScreenHeight-kHeight_NavBar-kWidth(20))];
    bgView.backgroundColor = [ColorManager WhiteColor];
    [self.view addSubview:bgView];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(kWidth(10), kWidth(10))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame =  bgView.bounds;
    maskLayer.path = maskPath.CGPath;
    bgView.layer.mask = maskLayer;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kWidth(10), kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UserInfoTableViewCell class] forCellReuseIdentifier:NSStringFromClass([UserInfoTableViewCell class])];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager ColorF2F2F2];
    
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(154))];
    headerV.backgroundColor = [ColorManager WhiteColor];
    self.iconImgV = [[UIImageView alloc]init];
    self.iconImgV.backgroundColor = [ColorManager ColorF2F2F2];
    self.iconImgV.layer.cornerRadius = kWidth(40);
    self.iconImgV.layer.masksToBounds = YES;
    self.iconImgV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeIconClicked)];
    [self.iconImgV addGestureRecognizer:tap];
    [headerV addSubview:self.iconImgV];
    [self.iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kWidth(20));
        make.centerX.equalTo(headerV);
        make.width.height.mas_offset(kWidth(80));
    }];
    
    UIButton *iconBtn = [[UIButton alloc]init];
    [iconBtn setTitle:@"修改头像" forState:UIControlStateNormal];
    [iconBtn setTitleColor:[ColorManager ColorFA8B18] forState:UIControlStateNormal];
    iconBtn.titleLabel.font = kFont(12);
    [iconBtn addTarget:self action:@selector(changeIconClicked) forControlEvents:UIControlEventTouchUpInside];
    [headerV addSubview:iconBtn];
    [iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImgV.mas_bottom).mas_offset(kWidth(10));
        make.centerX.equalTo(headerV);
        make.width.mas_offset(kWidth(50));
        make.height.mas_offset(kWidth(12));
    }];
    
    self.tableView.tableHeaderView = headerV;
    
    UIView *footerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(82))];
    UIButton *saveBtn = [[UIButton alloc]init];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    saveBtn .titleLabel.font = kFont(14);
    [saveBtn setBackgroundImage:kGetImage(@"login_按钮") forState:UIControlStateNormal];;
    saveBtn.layer.cornerRadius = kWidth(24);
    [saveBtn addTarget:self action:@selector(saveUserInfoClicked) forControlEvents:UIControlEventTouchUpInside];
    [footerV addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.equalTo(footerV);
        make.width.mas_offset(kWidth(321));
        make.height.mas_offset(kWidth(48));
    }];
    self.tableView.tableFooterView = footerV;
    
    UserInfoModel *userInfo = [UserInfoModel getUserInfoModel];
    
    
    self.nameStr = userInfo.member_name;
    NSInteger time = [userInfo.member_birthday integerValue];
    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:time];
    self.birthdayStr =  [CommonManager getCurrentDateOfYearMonthDay:myDate];
    [self.iconImgV sd_setImageWithURL:[NSURL URLWithString:userInfo.member_image] placeholderImage:kGetImage(@"normal_icon")];
    self.sexStr = userInfo.member_sex;
    
    [bgView addSubview:self.tableView];
}

-(void)saveUserInfoClicked{
    
    if (!self.nameField.text.length || !self.sexStr.length || !self.birthdayStr.length) {
        [self.view showHUDWithText:@"请填写完整信息" withYOffSet:0];
        return;
    }
    
    [SVProgressHUD show];
    NSDictionary *dic = @{@"uid":[UserInfoModel getUserInfoModel].uid,@"member_name":self.nameField.text,@"member_sex":self.sexStr,@"member_birthday":self.birthdayStr,@"api_token":[RegisterModel getUserInfoModel].user_token};
    
    
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [sessionManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil]];
    [sessionManager POST:[NSString stringWithFormat:@"%@%@",HTTP,Login_perfect] parameters:dic headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

        NSData *data = [LCTools resetSizeOfImageData:self.iconImgV.image maxSize:1024*80];//把要上传的图片转成NSData
        //把要上传的文件转成NSData
        //NSString*path=[[NSBundlemainBundle]pathForResource:@"123"ofType:@"txt"];

        //NSData*fileData = [NSDatadataWithContentsOfFile:path];

        [formData appendPartWithFileData:data name:@"member_image" fileName:@"member_image.png" mimeType:@"image/png"];//给定数据流的数据名，文件名，文件类型（以图片为例）
        
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [SVProgressHUD dismiss];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                options:NSJSONReadingMutableContainers
                                                                  error:nil];
            BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:dic];
            if ([baseModel.code isEqualToString:CODE0]) {
                UserInfoModel *userModel = [UserInfoModel mj_objectWithKeyValues:dic[@"data"]];
                [UserInfoModel saveUserInfoModel:userModel];
                [LoginUsersModel saveLoginUsers:userModel];
                [self.view showHUDWithText:baseModel.msg withYOffSet:0];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self.view showHUDWithText:@"修改信息失败" withYOffSet:0];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"errrrrr:%@",error);
            [self.view showHUDWithText:@"网络连接异常，请检查后重试!" withYOffSet:0];
            [SVProgressHUD dismiss];
        }];

    
//    [FJNetTool postWithParams:dic url:Login_perfect loading:YES success:^(id responseObject) {
//        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
//        if ([baseModel.code isEqualToString:CODE0]) {
//
//        }
//    } failure:^(NSError *error) {
//
//    }];
}

-(void)changeSexClicked:(UIButton *)sender{
    //sender.selected = YES;
    if (sender == self.manBtn) {
        //self.womenBtn.selected = NO;
        self.sexStr = @"1";
    }else{
        //self.manBtn.selected = NO;
        self.sexStr = @"0";
    }
    
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)selectUserBirthday:(NSString *)birthday{
    self.birthdayStr = birthday;
    [self.birthdayV removeFromSuperview];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)changeIconClicked{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UserInfoTableViewCell class])];
    if (!cell) {
        cell = [[UserInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UserInfoTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        cell.titleLab.text = @"昵称";
        cell.infoTextField.placeholder = @"请输入昵称";
        cell.manBtn.hidden = YES;
        cell.womenBtn.hidden = YES;
        cell.infoTextField.hidden = NO;
        self.nameField = cell.infoTextField;
        cell.infoTextField.text = self.nameStr;
        
    }
    if (indexPath.row == 1) {
        cell.titleLab.text = @"性别";
        cell.manBtn.hidden = NO;
        cell.womenBtn.hidden = NO;
        cell.infoTextField.hidden = YES;
        self.manBtn = cell.manBtn;
        self.womenBtn = cell.womenBtn;
        [cell.manBtn addTarget:self action:@selector(changeSexClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.womenBtn addTarget:self action:@selector(changeSexClicked:) forControlEvents:UIControlEventTouchUpInside];
        if ([self.sexStr isEqualToString:@"0"]) {
            cell.womenBtn.selected = YES;
            cell.manBtn.selected = NO;
        }else{
            cell.womenBtn.selected = NO;
            cell.manBtn.selected = YES;
        }
    }
    if (indexPath.row == 2) {
        cell.titleLab.text = @"生日";
        cell.infoTextField.placeholder = @"请输入生日";
        cell.manBtn.hidden = YES;
        cell.womenBtn.hidden = YES;
        cell.infoTextField.hidden = NO;
        self.birthdayField = cell.infoTextField;
        cell.infoTextField.text = self.birthdayStr;
        self.birthdayField.userInteractionEnabled = NO;
    }
    
    
    return cell;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return kWidth(52);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return [UIView new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        self.birthdayV = [[UserBirthdayView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar)];
        self.birthdayV.delegate = self;
        [self.birthdayV show];
        [self.view addSubview:self.birthdayV];
    }
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self.iconImgV setImage:image];
    
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
