//
//  ClassicalCollectionViewCell.h
//  Wuyoda
//
//  Created by 赵祥 on 2022/5/24.
//

#import <UIKit/UIKit.h>
#import "ClassicalGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ClassicalCollectionViewCell : UICollectionViewCell

@property (nonatomic , retain)ClassicalGoodsModel *model;

@end

NS_ASSUME_NONNULL_END
