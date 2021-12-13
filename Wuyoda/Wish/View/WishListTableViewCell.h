//
//  WishListTableViewCell.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/23.
//

#import <UIKit/UIKit.h>
#import "WishModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WishListTableViewCell : UITableViewCell

@property (nonatomic , retain)WishModel *model;

@property (nonatomic , assign)BOOL isEdit;

@end

NS_ASSUME_NONNULL_END
