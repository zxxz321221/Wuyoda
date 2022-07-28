//
//  CityHistoryTableViewCell.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/22.
//

#import <UIKit/UIKit.h>
#import "CityDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CityHistoryTableViewCell : UITableViewCell

@property (nonatomic , retain)CityEventModel *model;

@property (nonatomic , assign)BOOL isLast;

@end

NS_ASSUME_NONNULL_END
