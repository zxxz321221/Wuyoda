//
//  HomeAttractionsCollectionViewCell.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/14.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeAttractionsCollectionViewCell : UICollectionViewCell

@property (nonatomic , copy)NSString *imgName;

@property (nonatomic , strong)HomeCityModel *model;

@end

NS_ASSUME_NONNULL_END
