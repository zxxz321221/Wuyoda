//
//  SettingTableViewCell.h
//  Wuyoda
//
//  Created by 赵祥 on 2022/6/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingTableViewCell : UITableViewCell

@property (nonatomic , retain)UIView *bgView;

@property (nonatomic , retain)UILabel *titleLab;
@property (nonatomic , retain)UIView *bottomLine;

@property (nonatomic , assign)BOOL isFirst;
@property (nonatomic , assign)BOOL isLast;

@end

NS_ASSUME_NONNULL_END
