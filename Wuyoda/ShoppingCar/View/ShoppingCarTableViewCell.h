//
//  ShoppingCarTableViewCell.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/24.
//

#import <UIKit/UIKit.h>
#import "ShopCartModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol updateCartNumDelegate <NSObject>

-(void)updateCartNumwithModel:(ShopCartModel *)model;

@end

@interface ShoppingCarTableViewCell : UITableViewCell

@property (nonatomic , retain)ShopCartModel *model;

@property (nonatomic , weak)id <updateCartNumDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
