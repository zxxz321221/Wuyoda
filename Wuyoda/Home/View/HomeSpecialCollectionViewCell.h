//
//  HomeSpecialCollectionViewCell.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/14.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeSpecialCollectionViewCell : UICollectionViewCell

@property (nonatomic , copy)NSString *imgName;

@property (nonatomic , retain)HomeShopModel *model;

@end

NS_ASSUME_NONNULL_END
