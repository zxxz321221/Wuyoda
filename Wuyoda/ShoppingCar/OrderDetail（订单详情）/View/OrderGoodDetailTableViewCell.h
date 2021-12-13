//
//  OrderGoodDetailTableViewCell.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/26.
//

#import <UIKit/UIKit.h>
#import "ShopCartModel.h"
#import "OrderListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderGoodDetailTableViewCell : UITableViewCell

@property (nonatomic , retain)ShopCartModel *model;

@property (nonatomic , retain)OrderGoodModel *orderGoodModel;

@end

NS_ASSUME_NONNULL_END
