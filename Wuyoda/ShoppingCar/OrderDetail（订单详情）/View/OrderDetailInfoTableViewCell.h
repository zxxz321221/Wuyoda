//
//  OrderDetailInfoTableViewCell.h
//  Wuyoda
//
//  Created by 赵祥 on 2022/6/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailInfoTableViewCell : UITableViewCell

@property (nonatomic , retain)UILabel *infoLab;
@property (nonatomic , retain)UILabel *titleLab;

@property (nonatomic , assign)BOOL isLast;

@end

NS_ASSUME_NONNULL_END
