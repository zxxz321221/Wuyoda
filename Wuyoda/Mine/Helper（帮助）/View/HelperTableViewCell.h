//
//  HelperTableViewCell.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HelperTableViewCell : UITableViewCell

@property (nonatomic , retain)UIView *bgView;

@property (nonatomic , retain)UIImageView *imgV;

@property (nonatomic  , retain)UILabel *titleLab;

@property (nonatomic , retain)UIView *bottomLine;

@property (nonatomic , assign)BOOL isLast;

@end

NS_ASSUME_NONNULL_END
