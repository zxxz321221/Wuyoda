//
//  AttractionDetailRecommendTableViewCell.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/18.
//

#import <UIKit/UIKit.h>
#import "AttractionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AttractionDetailRecommendTableViewCell : UITableViewCell

@property (nonatomic  , retain)NSArray *otherArr;

@property (nonatomic , retain)AttractionModel *model;

@end

NS_ASSUME_NONNULL_END
