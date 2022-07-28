//
//  UserInfoModel.h
//  HuoZhiShop
//
//  Created by MAC02 on 2021/1/22.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoModel : BaseModel

@property (nonatomic, copy)NSString             *uid;//id
@property (nonatomic, copy)NSString             *member_class;
@property (nonatomic, copy)NSString             *member_id;
@property (nonatomic, copy)NSString             *base_id;
@property (nonatomic, copy)NSString             *member_pass;
@property (nonatomic, copy)NSString             *base_pass;
@property (nonatomic, copy)NSString             *pay_pass;
@property (nonatomic, copy)NSString             *member_name;
@property (nonatomic, copy)NSString             *member_sex;
@property (nonatomic, copy)NSString             *member_birthday;
@property (nonatomic, copy)NSString             *member_tel1;
@property (nonatomic, copy)NSString             *member_tel2;
@property (nonatomic, copy)NSString             *member_email;
@property (nonatomic, copy)NSString             *qq;
@property (nonatomic, copy)NSString             *taobao;
@property (nonatomic, copy)NSString             *member_zip;
@property (nonatomic, copy)NSString             *province;
@property (nonatomic, copy)NSString             *city;
@property (nonatomic, copy)NSString             *county;
@property (nonatomic, copy)NSString             *member_address;
@property (nonatomic, copy)NSString             *member_point;
@property (nonatomic, copy)NSString             *member_point_acc;
@property (nonatomic, copy)NSString             *member_money;
@property (nonatomic, copy)NSString             *member_money_freeze;
@property (nonatomic, copy)NSString             *member_image;
@property (nonatomic, copy)NSString             *register_date;
@property (nonatomic, copy)NSString             *isSupplier;
@property (nonatomic, copy)NSString             *card_id;
@property (nonatomic, copy)NSString             *card_owner;
@property (nonatomic, copy)NSString             *card_off;
@property (nonatomic, copy)NSString             *card_cashback;
@property (nonatomic, copy)NSString             *is_card;
@property (nonatomic, copy)NSString             *is_vip;
@property (nonatomic, copy)NSString             *from_user;
@property (nonatomic, copy)NSString             *sharecard;
@property (nonatomic, copy)NSString             *org_user;
@property (nonatomic, copy)NSString             *shaogood;
@property (nonatomic, copy)NSString             *is_invite;
@property (nonatomic, copy)NSString             *is_active;
@property (nonatomic, copy)NSString             *register_ip;
@property (nonatomic, copy)NSString             *wx_openid;
@property (nonatomic, copy)NSString             *wx_language;
@property (nonatomic, copy)NSString             *wx_privilege;
@property (nonatomic, copy)NSString             *token;
@property (nonatomic, copy)NSString             *days;





//@property (nonatomic, copy)NSMutableArray       *class_list;//班级列表



+ (void)saveUserInfoModel:(UserInfoModel *)model; 
+ (UserInfoModel *)getUserInfoModel;
+ (void)clearUserInfo;

@end

NS_ASSUME_NONNULL_END
