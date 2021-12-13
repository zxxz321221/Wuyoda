//
//  MessageModel.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/11/18.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageModel : BaseModel

@property (nonatomic , copy)NSString *author;
@property (nonatomic , copy)NSString *board_body;
@property (nonatomic , copy)NSString *board_hit;
@property (nonatomic , copy)NSString *board_subject;
@property (nonatomic , copy)NSString *cover;
@property (nonatomic , copy)NSString *domain_id;
@property (nonatomic , copy)NSString *is_domain;
@property (nonatomic , copy)NSString *od;
@property (nonatomic , copy)NSString *ps_name;
@property (nonatomic , copy)NSString *register_date;
@property (nonatomic , copy)NSString *supplier_id;
@property (nonatomic , copy)NSString *uid;

@end

NS_ASSUME_NONNULL_END
