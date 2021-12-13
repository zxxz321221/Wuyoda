//
//  AttractionDetailHeaderView.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/18.
//

#import <UIKit/UIKit.h>
#import "AttractionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AttractionDetailHeaderView : UIView

@property (nonatomic , retain)NSMutableArray *tagsArr;

@property (nonatomic , retain)AttractionModel *model;

@end

NS_ASSUME_NONNULL_END
