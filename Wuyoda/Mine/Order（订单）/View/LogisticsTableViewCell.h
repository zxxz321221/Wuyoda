//
//  LogisticsTableViewCell.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/14.
//

#import <UIKit/UIKit.h>
#import "LogisticsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LogisticsTableViewCell : UITableViewCell

@property (nonatomic , retain)UIView *line;

@property (nonatomic , retain)LogisticsModel *model;

@end

NS_ASSUME_NONNULL_END
