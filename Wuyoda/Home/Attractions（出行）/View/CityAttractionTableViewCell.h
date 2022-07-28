//
//  CityAttractionTableViewCell.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/22.
//

#import <UIKit/UIKit.h>
#import "AttractionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CityAttractionTableViewCell : UITableViewCell

@property (nonatomic , retain)AttractionModel *model;

@property (nonatomic , assign)BOOL isLast;

@end

NS_ASSUME_NONNULL_END
