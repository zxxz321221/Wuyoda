//
//  OrderInfoTableViewCell.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderInfoTableViewCell : UITableViewCell

@property (nonatomic , retain)UILabel *titleLab;

@property (nonatomic , retain)UILabel *infoLab;

@property (nonatomic , retain)UILabel *orderNumLab;

@property (nonatomic , retain)UIButton *orderCopyBtn;

@property (nonatomic , retain)UIView *bgView;

@property (nonatomic , assign)BOOL isLast;

@end

NS_ASSUME_NONNULL_END
