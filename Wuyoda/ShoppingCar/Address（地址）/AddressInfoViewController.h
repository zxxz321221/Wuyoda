//
//  AddressInfoViewController.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/27.
//

#import "FJBaseViewController.h"
#import "AddressModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol updateAddressInfoDelegate <NSObject>

-(void)updateAddressInfo;

@end

@interface AddressInfoViewController : FJBaseViewController

//1.新增；2.编辑
@property (nonatomic , copy)NSString *type;

@property (nonatomic , retain)AddressModel *addressModel;

@property (nonatomic , weak)id <updateAddressInfoDelegate>delegate;

@property (nonatomic , assign)NSInteger addressCount;

@end

NS_ASSUME_NONNULL_END
