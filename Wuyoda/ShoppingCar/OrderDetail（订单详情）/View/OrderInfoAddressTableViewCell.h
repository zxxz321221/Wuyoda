//
//  OrderInfoAddressTableViewCell.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/27.
//

#import <UIKit/UIKit.h>
#import "OrderListModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface OrderInfoAddressTableViewCell : UITableViewCell

@property (nonatomic , retain)OrderListModel *model;

@property (nonatomic , retain)UIButton *changeddressBtn;

@property (nonatomic , copy)NSString *type;

@end

NS_ASSUME_NONNULL_END
