//
//  OrderPriceTableViewCell.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/12/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderPriceTableViewCell : UITableViewCell

@property (nonatomic , retain)UIView *bgView;

@property (nonatomic , retain)UILabel *priceTitleLab;
@property (nonatomic , retain)UILabel *priceLab;

@property (nonatomic , retain)UILabel *allPriceTitleLab;
@property (nonatomic , retain)UILabel *allPriceLab;

@property (nonatomic , assign)BOOL isFirst;
@property (nonatomic , assign)BOOL isLast;

@end

NS_ASSUME_NONNULL_END
