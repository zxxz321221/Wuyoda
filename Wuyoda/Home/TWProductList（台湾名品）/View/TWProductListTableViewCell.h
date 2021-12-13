//
//  TWProductListTableViewCell.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/17.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TWProductListTableViewCell : UITableViewCell

@property (nonatomic , retain)NSMutableArray *tagsArr;

@property (nonatomic , retain)HomeShopModel *model;

//@property (nonatomic , copy)NSString *imgName;

@end

NS_ASSUME_NONNULL_END
