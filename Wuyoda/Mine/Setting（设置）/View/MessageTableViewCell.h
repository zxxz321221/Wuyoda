//
//  MessageTableViewCell.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/14.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageTableViewCell : UITableViewCell

@property (nonatomic , retain)MessageModel *model;

@end

NS_ASSUME_NONNULL_END
