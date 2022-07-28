//
//  AttractionsListTableViewCell.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/18.
//

#import <UIKit/UIKit.h>
#import "AttractionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AttractionsListTableViewCell : UITableViewCell

@property (nonatomic , retain)AttractionModel *model;

@property (nonatomic , assign)BOOL isFirst;

@end

NS_ASSUME_NONNULL_END
