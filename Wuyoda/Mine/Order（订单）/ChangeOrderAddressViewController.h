//
//  ChangeOrderAddressViewController.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/12.
//

#import "FJBaseViewController.h"
#import "OrderListModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ChangeOrderAddressDelegate <NSObject>

-(void)changeOrderAddress;

@end

@interface ChangeOrderAddressViewController : FJBaseViewController

@property (nonatomic , retain)OrderListModel *orderListModel;

@property (nonatomic , weak)id <ChangeOrderAddressDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
