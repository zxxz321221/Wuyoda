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
#import "AddressDeleteAlertView.h"
#import "AddressModel.h"
#import "OrderDetailViewController.h"

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
@property (nonatomic , retain)UITextView *addressTextV;
@property (nonatomic , retain)UITextField *realNameField;
@property (nonatomic , retain)UITextField *idNumField;
@property (nonatomic , assign)BOOL is_buy;
@property (nonatomic , retain)UIImage *front_id;
@property (nonatomic , retain)UIImage *reverse_id;

@property (nonatomic , copy)NSString *idCardType;

@property (nonatomic , retain)AddressDeleteAlertView *deleteAlertV;

@end

@implementation AddressInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FJNormalNavView *nav = [[FJNormalNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar) controller:self titleStr:@"新增收货地址"];
    nav.backgroundColor = [ColorManager ColorF2F2F2];
    [self.view addSubview:nav];
    
    if ([self.type isEqualToString:@"2"]) {
        UIButton *deleteBtn = [[UIButton alloc]init];
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [deleteBtn setTitleColor:[ColorManager MainColor] forState:UIControlStateNormal];
        deleteBtn.titleLabel.font = kFont(14);
        [deleteBtn addTarget:self action:@selector(deleteAddressClicked:) forControlEvents:UIControlEventTouchUpInside];
        [nav addSubview:deleteBtn];
        [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(kWidth(-10));
            make.right.mas_offset(kWidth(-20));
            make.width.mas_offset(kWidth(30));
            make.height.mas_offset(kWidth(20));
        }];
    }
    
    self.view.backgroundColor = [ColorManager ColorF2F2F2];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight_NavBar+kWidth(20), kScreenWidth, kScreenHeight-kHeight_NavBar-kWidth(20))];
    bgView.backgroundColor = [ColorManager WhiteColor];
    [self.view addSubview:bgView];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(kWidth(10), kWidth(10))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame =  bgView.bounds;
    maskLayer.path = maskPath.CGPath;
    bgView.layer.mask = maskLayer;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kWidth(10), kScreenWidth, kScreenHeight-kHeight_NavBar-kHeight_SafeArea-kWidth(42)-kWidth(60)-kWidth(30)) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[AddressInfoTableViewCell class] forCellReuseIdentifier:NSStringFromClass([AddressInfoTableViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [ColorManager WhiteColor];
    
    self.footerV = [[AddressInfoFooterView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(190))];
    [self.footerV.identifierBtn1 addTarget:self action:@selector(selectIDCardImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.footerV.identifierBtn2 addTarget:self action:@selector(selectIDCardImage:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.footerV.deleteBtn1 addTarget:self action:@selector(deleteImageClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.footerV.deleteBtn2 addTarget:self action:@selector(deleteImageClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = self.footerV;
    
    
    [bgView addSubview:self.tableView];
    
    UIButton *saveBtn = [[UIButton alloc]init];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[ColorManager WhiteColor] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = kFont(14);
    [saveBtn setBackgroundImage:kGetImage(@"login_按钮") forState:UIControlStateNormal];
    saveBtn.layer.cornerRadius = kWidth(21);
    [saveBtn addTarget:self action:@selector(saveAddressClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.mas_offset(kWidth(-20)-kHeight_SafeArea);
        make.width.mas_offset(kWidth(335));
        make.height.mas_offset(kWidth(48));
    }];
    
    self.proStr = @"";
    self.cityStr = @"";
    self.areaStr = @"";
    self.titleArr = @[@[@"收货人",@"手机号码",@"所在地区",@"详细地址",@""],@[@"姓名",@"身份证号"]];
    self.placeholderArr = @[@[@"姓名",@"手机号",@"省、市、区、街道",@"例：xx小区8号楼1-403",@""],@[@"请输入姓名",@"请输入身份证号"]];
}

-(void)deleteAddressClicked:(id)sender{
    self.deleteAlertV = [[AddressDeleteAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.deleteAlertV.deleteBtn addTarget:self action:@selector(deleteDoneClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.deleteAlertV];
}

-(void)deleteDoneClicked:(UIButton *)sender{
    [self.deleteAlertV removeFromSuperview];
    
    NSDictionary *dic = @{@"uid":self.addressModel.uid,@"api_token":[RegisterModel getUserInfoModel].user_token};
    
    [FJNetTool postWithParams:dic url:Special_address_del loading:YES success:^(id responseObject) {
        BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([baseModel.code isEqualToString:CODE0]) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(updateAddressInfo)]) {
                [self.delegate updateAddressInfo];
                [self.view showHUDWithText:@"保存成功" withYOffSet:0];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }else{
            [self.view showHUDWithText:baseModel.msg withYOffSet:0];
        }
    } failure:^(NSError *error) {
        
    }];
    
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
    imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void)deleteImageClicked:(UIButton *)sender{
    sender.hidden = YES;
    if (sender == self.footerV.deleteBtn1) {
        self.footerV.identifierimgV1.image = kGetImage(@"上传身份证正面");
        self.front_id = nil;
    }else{
        self.footerV.identifierimgV2.image = kGetImage(@"上传身份证反面");
        self.reverse_id = nil;
    }
}

-(void)saveAddressClicked{
    if (!self.nameField.text.length || !self.addressField.text.length || !self.addressTextV.text.length || !self.phoneField.text.length || !self.idNumField.text.length || !self.realNameField.text.length || !self.front_id || !self.reverse_id) {
        [self.view showHUDWithText:@"请填写完整信息" withYOffSet:0];
        return;
    }
    
    if (self.idNumField.text.length > 20) {
        [self.view showHUDWithText:@"请输入正确身份证号" withYOffSet:0];
        return;
    }
    
    [SVProgressHUD show];
    
    if ([self.type isEqualToString:@"2"]) {
        [self editAddressFromServer];
    }else{
//        self.front_id = kGetImage(@"手办礼品1");
//        self.reverse_id = kGetImage(@"手办礼品2");
        
        NSDictionary *dic = @{@"consignee":self.nameField.text,@"province":self.proStr,@"city":self.cityStr,@"county":self.areaStr,@"address":[NSString stringWithFormat:@"%@",self.addressTextV.text],@"mobile":self.phoneField.text,@"m_uid":[UserInfoModel getUserInfoModel].uid,@"is_buy":[NSString stringWithFormat:@"%d",self.is_buy],@"name":self.realNameField.text,@"card":self.idNumField.text,@"api_token":[RegisterModel getUserInfoModel].user_token};
        
        AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
        sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [sessionManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil]];
        [sessionManager POST:[NSString stringWithFormat:@"%@%@",HTTP,Special_address_add] parameters:dic headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            NSData *data = [LCTools resetSizeOfImageData:self.front_id maxSize:1024*80];

            //把要上传的文件转成NSData
            //NSString*path=[[NSBundlemainBundle]pathForResource:@"123"ofType:@"txt"];

            //NSData*fileData = [NSDatadataWithContentsOfFile:path];

            [formData appendPartWithFileData:data name:@"front_ID" fileName:@"front_ID.png" mimeType:@"image/png"];//给定数据流的数据名，文件名，文件类型（以图片为例）
            
            

            NSData *data2 = [LCTools resetSizeOfImageData:self.reverse_id maxSize:1024*80];//把要上传的图片转成NSData
            //把要上传的文件转成NSData
            //NSString*path=[[NSBundlemainBundle]pathForResource:@"123"ofType:@"txt"];

            //NSData*fileData = [NSDatadataWithContentsOfFile:path];

            [formData appendPartWithFileData:data2 name:@"reverse_ID" fileName:@"reverse_ID.png" mimeType:@"image/png"];//给定数据流的数据名，文件名，文件类型（以图片为例）
            
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [SVProgressHUD dismiss];
                NSError *err;
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                    options:NSJSONReadingMutableContainers
                                                                      error:&err];
                
                BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:dic];
                if ([baseModel.code isEqualToString:CODE0]) {
                    if (self.delegate && [self.delegate respondsToSelector:@selector(updateAddressInfo)]) {
                        [self.delegate updateAddressInfo];
                        [self.view showHUDWithText:@"保存成功" withYOffSet:0];
                        [self.navigationController popViewControllerAnimated:YES];
                    }else{
                        for (UIViewController *vc in self.navigationController.viewControllers) {
                            if ([vc isKindOfClass:[OrderDetailViewController class]] && !self.addressCount) {
                                AddressModel *addressModel = [[AddressModel alloc]init];
                                addressModel.uid = baseModel.msg;
                                [[NSNotificationCenter defaultCenter]postNotificationName:@"orderAddAddress" object:addressModel];
                                [self.navigationController popToViewController:vc animated:YES];
                                break;
                            }
                        }
                    }
                    
                }else{
                    [self.view showHUDWithText:baseModel.msg withYOffSet:0];
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [SVProgressHUD dismiss];
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
    
//    self.front_id = kGetImage(@"手办礼品1");
//    self.reverse_id = kGetImage(@"手办礼品2");
    
    NSDictionary *dic = @{@"consignee":self.nameField.text,@"province":self.proStr,@"city":self.cityStr,@"county":self.areaStr,@"address":[NSString stringWithFormat:@"%@",self.addressTextV.text],@"mobile":self.phoneField.text,@"m_uid":[UserInfoModel getUserInfoModel].uid,@"is_buy":[NSString stringWithFormat:@"%d",self.is_buy],@"name":self.realNameField.text,@"card":self.idNumField.text,@"api_token":[RegisterModel getUserInfoModel].user_token,@"uid":self.addressModel.uid};
    
//    FJNetTool uploadWithURL:<#(NSString *)#> params:<#(NSDictionary *)#> images:<#(NSArray<UIImage *> *)#> name:<#(NSString *)#> filename:<#(NSArray<NSString *> *)#> loading:<#(BOOL)#> imageScale:<#(CGFloat)#> imageType:<#(NSString *)#> progress:<#^(NSProgress *progress)progres#> success:<#^(id responseObject)success#> failure:<#^(NSError *error)failure#>
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [sessionManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil]];
    [sessionManager POST:[NSString stringWithFormat:@"%@%@",HTTP,Special_address_edit] parameters:dic headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = [LCTools resetSizeOfImageData:self.front_id maxSize:1024*80];

        //把要上传的文件转成NSData
        //NSString*path=[[NSBundlemainBundle]pathForResource:@"123"ofType:@"txt"];

        //NSData*fileData = [NSDatadataWithContentsOfFile:path];

        [formData appendPartWithFileData:data name:@"front_ID" fileName:@"front_ID.png" mimeType:@"image/png"];//给定数据流的数据名，文件名，文件类型（以图片为例）
        
        

        NSData *data2 = [LCTools resetSizeOfImageData:self.reverse_id maxSize:1024*80];//把要上传的图片转成NSData

        //把要上传的文件转成NSData
        //NSString*path=[[NSBundlemainBundle]pathForResource:@"123"ofType:@"txt"];

        //NSData*fileData = [NSDatadataWithContentsOfFile:path];

        [formData appendPartWithFileData:data2 name:@"reverse_ID" fileName:@"reverse_ID.png" mimeType:@"image/png"];//给定数据流的数据名，文件名，文件类型（以图片为例）
        
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [SVProgressHUD dismiss];
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
            }else{
                [self.view showHUDWithText:baseModel.msg withYOffSet:0];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD dismiss];
        }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AddressInfoTableViewCell class])];
    if (!cell) {
        cell = [[AddressInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([AddressInfoTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleLab.text = self.titleArr[indexPath.section][indexPath.row];
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.placeholderArr[indexPath.section][indexPath.row] attributes:@{NSForegroundColorAttributeName:[ColorManager Color666666],NSFontAttributeName:kFont(14)}];
    cell.infoTextField.attributedPlaceholder = attrString;

    
    
    cell.is_buy = self.is_buy;
    
    cell.titleLab.hidden = NO;
    cell.infoBgV.hidden = YES;
    cell.infoTextField.hidden = YES;
    cell.addressTextV.hidden = YES;
    cell.arrowImgV.hidden = YES;
    cell.phoneTypeLab.hidden = YES;
    cell.addressPlaceHolderLab.hidden = YES;
    cell.defaultImgV.hidden = YES;
    cell.defaultLab.hidden = YES;
    
    if (indexPath.section == 0 && indexPath.row == 4) {
        cell.defaultImgV.hidden = NO;
        cell.defaultLab.hidden = NO;
        cell.titleLab.hidden = YES;
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.infoBgV.hidden = NO;
            cell.infoTextField.hidden = NO;
            self.nameField = cell.infoTextField;
        }
        if (indexPath.row == 1) {
            cell.infoBgV.hidden = NO;
            cell.infoTextField.hidden = NO;
            cell.phoneTypeLab.hidden = NO;
            cell.arrowImgV.hidden = NO;
            self.phoneField = cell.infoTextField;
        }

        if (indexPath.row == 2) {
            cell.infoBgV.hidden = NO;
            cell.infoTextField.hidden = NO;
            cell.arrowImgV.hidden = NO;
            self.addressField = cell.infoTextField;
            self.addressField.userInteractionEnabled = NO;
            self.addressField.text = [NSString stringWithFormat:@"%@%@%@",self.proStr,self.cityStr,self.areaStr];
        }

        if (indexPath.row == 3) {
            cell.infoBgV.hidden = NO;
            cell.addressTextV.hidden = NO;
            cell.addressPlaceHolderLab.hidden = NO;
            self.addressTextV = cell.addressTextV;
        }
    }else{
        if (indexPath.row == 0) {
            cell.infoBgV.hidden = NO;
            cell.infoTextField.hidden = NO;
            self.realNameField = cell.infoTextField;
        }
        if (indexPath.row == 1) {
            cell.infoBgV.hidden = NO;
            cell.infoTextField.hidden = NO;
            self.idNumField = cell.infoTextField;
        }
    }
    
    if (self.addressModel) {
        cell.addressPlaceHolderLab.hidden = YES;
        self.nameField.text = self.addressModel.consignee;
        self.phoneField.text = self.addressModel.mobile;
        self.proStr = self.addressModel.province;
        self.cityStr = self.addressModel.city;
        self.areaStr = self.addressModel.county;
        self.addressField.text = [NSString stringWithFormat:@"%@%@%@",self.proStr,self.cityStr,self.areaStr];
        self.addressTextV.text = self.addressModel.address;
        self.realNameField.text = self.addressModel.name;
        self.idNumField.text = self.addressModel.card;
        self.is_buy = self.addressModel.is_buy;
        if (!self.front_id) {
            [self.footerV.identifierimgV1 sd_setImageWithURL:[NSURL URLWithString:self.addressModel.front_ID] placeholderImage:kGetImage(@"上传身份证正面") completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if (!error) {
                    NSData *imageData = UIImagePNGRepresentation(image);
                    
                    self.front_id = image;
                }
                        
            }];
        }
        if (!self.reverse_id) {
            [self.footerV.identifierimgV2 sd_setImageWithURL:[NSURL URLWithString:self.addressModel.reverse_ID] placeholderImage:kGetImage(@"上传身份证反面") completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if (!error) {
                    self.reverse_id = image;
                }
                        
            }];
        }
        
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

    if (indexPath.section == 0 && indexPath.row == 3) {
        return kWidth(80);
    }
    return kWidth(70);
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
    if (indexPath.section == 0 && indexPath.row == 4) {
        self.is_buy = !self.is_buy;
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        [self.view endEditing:YES];
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
        [self.footerV.identifierimgV1 setImage:image];
        self.footerV.deleteBtn1.hidden = NO;
    }else{
        self.reverse_id = image;
        [self.footerV.identifierimgV2 setImage:image];
        self.footerV.deleteBtn2.hidden = NO;
    }
    //[self.tableView reloadData];
    
}

-(void)setAddressModel:(AddressModel *)addressModel{
    _addressModel = addressModel;
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
