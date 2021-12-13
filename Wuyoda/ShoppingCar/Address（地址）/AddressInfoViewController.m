//
//  AddressInfoViewController.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/27.
//

#import "AddressInfoViewController.h"
#import "AddressInfoTableViewCell.h"
#import "AddressInfoFooterView.h"
#import "AddressChangeView.h"

@interface AddressInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,AddressChangeSelectDelegate>

@property (nonatomic , retain)UITableView *tableView;

@property (nonatomic , retain)NSArray *titleArr;

@property (nonatomic , retain)NSArray *placeholderArr;

@property (nonatomic , retain)AddressInfoFooterView *footerV;

@property (nonatomic , retain)AddressChangeView *addressV;

@property (nonatomic , copy)NSString *proStr;
@property (nonatomic , copy)NSString *cityStr;
@property (nonatomic , copy)NSString *areaStr;

@property (nonatomic , retain)UITextField *nameField;
@property (nonatomic , retain)UITextField *phoneField;
@property (nonatomic , retain)UITextField *addressField;
@property (nonatomic , retain)UITextField *numField;
@property (nonatomic , retain)UITextField *realNameField;
@property (nonatomic , retain)UITextField *idNumField;
@property (nonatomic , assign)BOOL is_buy;
@property (nonatomic , retain)UIImage *front_id;
@property (nonatomic , retain)UIImage *reverse_id;

@property (nonatomic , copy)NSString *idCardType;

@end

@implementation AddressInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"新增收货地址"];
    [self.view addSubview:nav];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar, kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea-kWidth(42)-kWidth(60)) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[AddressInfoTableViewCell class] forCellReuseIdentifier:NSStringFromClass([AddressInfoTableViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager WhiteColor];
    
    self.footerV = [[AddressInfoFooterView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(190))];
    [self.footerV.identifierBtn1 addTarget:self action:@selector(selectIDCardImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.footerV.identifierBtn2 addTarget:self action:@selector(selectIDCardImage:) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = self.footerV;
    
    
    [self.view addSubview:self.tableView];
    
    UIButton *saveBtn = [[UIButton alloc]init];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = kFont(14);
    saveBtn.backgroundColor = [ColorManager MainColor];
    saveBtn.layer.cornerRadius = kWidth(21);
    [saveBtn addTarget:self action:@selector(saveAddressClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.mas_offset(kWidth(-20)-kHeight_SafeArea);
        make.width.mas_offset(kWidth(350));
        make.height.mas_offset(kWidth(42));
    }];
    
    self.proStr = @"";
    self.cityStr = @"";
    self.areaStr = @"";
    self.titleArr = @[@[@"收货人",@"手机号",@"收货地址",@"门牌号",@""],@[@"姓名",@"身份证号"]];
    self.placeholderArr = @[@[@"您的姓名",@"您的手机号",@"小区/写字楼/学校",@"例：8号楼808室",@""],@[@"请输入姓名",@"请输入身份证号"]];
}

-(void)selectIDCardImage:(UIButton *)sender{
    if (sender == self.footerV.identifierBtn1) {
        self.idCardType = @"1";
    }else{
        self.idCardType = @"2";
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void)saveAddressClicked{
    if ([self.type isEqualToString:@"2"]) {
        [self editAddressFromServer];
    }else{
        self.front_id = kGetImage(@"手办礼品1");
        self.reverse_id = kGetImage(@"手办礼品2");
        
        NSDictionary *dic = @{@"consignee":self.nameField.text,@"province":self.proStr,@"city":self.cityStr,@"county":self.areaStr,@"address":[NSString stringWithFormat:@"%@",self.numField.text],@"mobile":self.phoneField.text,@"m_uid":[UserInfoModel getUserInfoModel].uid,@"is_buy":[NSString stringWithFormat:@"%d",self.is_buy],@"name":self.realNameField.text,@"card":self.idNumField.text,@"api_token":[RegisterModel getUserInfoModel].user_token};
        
        AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
        sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];

        [sessionManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil]];
        [sessionManager POST:[NSString stringWithFormat:@"%@%@",HTTP,Special_address_add] parameters:dic headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            NSData *data =UIImagePNGRepresentation(self.front_id);//把要上传的图片转成NSData

            //把要上传的文件转成NSData
            //NSString*path=[[NSBundlemainBundle]pathForResource:@"123"ofType:@"txt"];

            //NSData*fileData = [NSDatadataWithContentsOfFile:path];

            [formData appendPartWithFileData:data name:@"front_ID" fileName:@"front_ID.png" mimeType:@"image/png"];//给定数据流的数据名，文件名，文件类型（以图片为例）
            
            

            NSData *data2 =UIImagePNGRepresentation(self.reverse_id);//把要上传的图片转成NSData

            //把要上传的文件转成NSData
            //NSString*path=[[NSBundlemainBundle]pathForResource:@"123"ofType:@"txt"];

            //NSData*fileData = [NSDatadataWithContentsOfFile:path];

            [formData appendPartWithFileData:data2 name:@"reverse_ID" fileName:@"reverse_ID.png" mimeType:@"image/png"];//给定数据流的数据名，文件名，文件类型（以图片为例）
            
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                    options:NSJSONReadingMutableContainers
                                                                      error:nil];
                BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:dic];
                if ([baseModel.code isEqualToString:CODE0]) {
                    if (self.delegate && [self.delegate respondsToSelector:@selector(updateAddressInfo)]) {
                        [self.delegate updateAddressInfo];
                        [self.view showHUDWithText:@"保存成功" withYOffSet:0];
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        
    //    [FJNetTool postWithParams:dic url:Special_address_add loading:YES success:^(id responseObject) {
    //        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
    //        if ([baseModel.code isEqualToString:CODE0]) {
    //            [self.navigationController popViewControllerAnimated:YES];
    //        }
    //    } failure:^(NSError *error) {
    //
    //    }];
    }
    
    
    
}

-(void)editAddressFromServer{
    
    self.front_id = kGetImage(@"手办礼品1");
    self.reverse_id = kGetImage(@"手办礼品2");
    
    NSDictionary *dic = @{@"consignee":self.nameField.text,@"province":self.proStr,@"city":self.cityStr,@"county":self.areaStr,@"address":[NSString stringWithFormat:@"%@",self.numField.text],@"mobile":self.phoneField.text,@"m_uid":[UserInfoModel getUserInfoModel].uid,@"is_buy":[NSString stringWithFormat:@"%d",self.is_buy],@"name":self.realNameField.text,@"card":self.idNumField.text,@"api_token":[RegisterModel getUserInfoModel].user_token,@"uid":self.addressModel.uid};
    
//    FJNetTool uploadWithURL:<#(NSString *)#> params:<#(NSDictionary *)#> images:<#(NSArray<UIImage *> *)#> name:<#(NSString *)#> filename:<#(NSArray<NSString *> *)#> loading:<#(BOOL)#> imageScale:<#(CGFloat)#> imageType:<#(NSString *)#> progress:<#^(NSProgress *progress)progres#> success:<#^(id responseObject)success#> failure:<#^(NSError *error)failure#>
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [sessionManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil]];
    [sessionManager POST:[NSString stringWithFormat:@"%@%@",HTTP,Special_address_edit] parameters:dic headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data =UIImagePNGRepresentation(self.front_id);//把要上传的图片转成NSData

        //把要上传的文件转成NSData
        //NSString*path=[[NSBundlemainBundle]pathForResource:@"123"ofType:@"txt"];

        //NSData*fileData = [NSDatadataWithContentsOfFile:path];

        [formData appendPartWithFileData:data name:@"front_ID" fileName:@"front_ID.png" mimeType:@"image/png"];//给定数据流的数据名，文件名，文件类型（以图片为例）
        
        

        NSData *data2 =UIImagePNGRepresentation(self.reverse_id);//把要上传的图片转成NSData

        //把要上传的文件转成NSData
        //NSString*path=[[NSBundlemainBundle]pathForResource:@"123"ofType:@"txt"];

        //NSData*fileData = [NSDatadataWithContentsOfFile:path];

        [formData appendPartWithFileData:data2 name:@"reverse_ID" fileName:@"reverse_ID.png" mimeType:@"image/png"];//给定数据流的数据名，文件名，文件类型（以图片为例）
        
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                options:NSJSONReadingMutableContainers
                                                                  error:nil];
            BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:dic];
            if ([baseModel.code isEqualToString:CODE0]) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(updateAddressInfo)]) {
                    [self.delegate updateAddressInfo];
                    [self.view showHUDWithText:@"修改成功" withYOffSet:0];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AddressInfoTableViewCell class])];
    if (!cell) {
        cell = [[AddressInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([AddressInfoTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleLab.text = self.titleArr[indexPath.section][indexPath.row];
    cell.infoTextField.placeholder = self.placeholderArr[indexPath.section][indexPath.row];
    
    cell.is_buy = self.is_buy;
    
    if (indexPath.section == 0 && indexPath.row == 4) {
        cell.titleLab.hidden = YES;
        cell.infoTextField.hidden = YES;
        cell.arrowImgV.hidden = YES;
        cell.defaultImgV.hidden = NO;
        cell.defaultLab.hidden = NO;
    }else{
        cell.titleLab.hidden = NO;
        cell.infoTextField.hidden = NO;
        cell.arrowImgV.hidden = YES;
        cell.defaultImgV.hidden = YES;
        cell.defaultLab.hidden = YES;
        
        if (indexPath.section == 0 && indexPath.row == 2) {
            cell.arrowImgV.hidden = NO;
        }
    }
    
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            self.nameField = cell.infoTextField;
        }
        if (indexPath.row == 1) {
            self.phoneField = cell.infoTextField;
        }

        if (indexPath.row == 2) {
            self.addressField = cell.infoTextField;
            self.addressField.userInteractionEnabled = NO;
            self.addressField.text = [NSString stringWithFormat:@"%@%@%@",self.proStr,self.cityStr,self.areaStr];
        }

        if (indexPath.row == 3) {
            self.numField = cell.infoTextField;
        }
    }else{
        if (indexPath.row == 0) {
            self.realNameField = cell.infoTextField;
        }
        if (indexPath.row == 1) {
            self.idNumField = cell.infoTextField;
        }
    }
    
    if (self.addressModel) {
        self.nameField.text = self.addressModel.consignee;
        self.phoneField.text = self.addressModel.mobile;
        self.proStr = self.addressModel.province;
        self.cityStr = self.addressModel.city;
        self.areaStr = self.addressModel.county;
        self.addressField.text = [NSString stringWithFormat:@"%@%@%@",self.proStr,self.cityStr,self.areaStr];
        self.numField.text = self.addressModel.address;
        self.realNameField.text = self.addressModel.name;
        self.idNumField.text = self.addressModel.card;
        self.is_buy = self.addressModel.is_buy;
    }
    
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
    }
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return kWidth(48);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return kWidth(10);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(10))];
    headerV.backgroundColor = [ColorManager ColorF2F2F2];
    return headerV;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 4) {
        self.is_buy = !self.is_buy;
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        if (self.addressV) {
            self.addressV.hidden = NO;
        }else{
            self.addressV = [[AddressChangeView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
            self.addressV.delegate = self;
            [self.navigationController.view addSubview:self.addressV];
        }
    }
}

-(void)selectAddress:(NSString *)proStr CityStr:(NSString *)cityStr AreaStr:(NSString *)areaStr{
    self.proStr = proStr;
    self.cityStr = cityStr;
    self.areaStr = areaStr;
    if (self.addressModel) {
        self.addressModel.province = proStr;
        self.addressModel.city = cityStr;
        self.addressModel.county = areaStr;
    }
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if ([self.idCardType isEqualToString:@"1"]) {
        self.front_id = image;
        [self.footerV.identifierBtn1 setImage:image forState:UIControlStateNormal];
    }else{
        self.reverse_id = image;
        [self.footerV.identifierBtn2 setImage:image forState:UIControlStateNormal];
    }
    [self.tableView reloadData];
    
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
