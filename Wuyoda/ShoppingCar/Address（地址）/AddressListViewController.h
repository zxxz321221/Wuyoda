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

@end

NS_ASSUME_NONNULL_END
