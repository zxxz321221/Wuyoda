//
//  ChangeOrderAddressHeaderView.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/12.
//

#import <UIKit/UIKit.h>
#import "OrderListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChangeOrderAddressHeaderView : UIView

@property (nonatomic , retain)UIButton *addBtn;

@property (nonatomic , retain)OrderListModel *orderListModel;

@end

NS_ASSUME_NONNULL_END
