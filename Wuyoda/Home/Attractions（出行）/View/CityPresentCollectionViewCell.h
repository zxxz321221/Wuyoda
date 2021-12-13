//
//  CityPresentCollectionViewCell.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/22.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
#import "FootPrintModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CityPresentCollectionViewCell : UICollectionViewCell

@property (nonatomic , retain)HomeShopModel *model;

@property (nonatomic , retain)FootPrintModel *footPrintmodel;

@property (nonatomic , assign)BOOL isEdit;

@end

NS_ASSUME_NONNULL_END
