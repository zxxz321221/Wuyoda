//
//  AddressListViewController.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/27.
//

#import "FJBaseViewController.h"
#import "AddressModel.h"

@protocol selectAddressDelegate <NSObject>

-(void)selectAddress:(AddressModel *)model;

@end

NS_ASSUME_NONNULL_BEGIN

@interface AddressListViewController : FJBaseViewController

@property (nonatomic  , weak)id <selectAddressDelegate>delegate;

//order:无地址订单  setting：设置
@property (nonatomic  , copy)NSString *type;

@property (nonatomic  , retain)AddressModel *addressModel;

@end

NS_ASSUME_NONNULL_END
