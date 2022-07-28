//
//  PayInfoViewController.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/11/11.
//

#import "FJBaseViewController.h"
#import "PayInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PayInfoViewController : FJBaseViewController

@property(nonatomic , retain)PayInfoModel *payInfoModel;

@property(nonatomic , copy)NSString *payType;
@property(nonatomic , copy)NSString *openId;

@end

NS_ASSUME_NONNULL_END
