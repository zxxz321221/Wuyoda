//
//  ProductDetailHeaderView.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/15.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailHeaderView : UIView

@property (nonatomic , retain)NSMutableArray *labelArr;

@property (nonatomic , retain)HomeShopModel *model;

@end

NS_ASSUME_NONNULL_END
