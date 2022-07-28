//
//  VersionTableViewCell.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VersionTableViewCell : UITableViewCell

@property (nonatomic , retain)UIView *bgView;

@property (nonatomic , retain)UILabel *titleLab;

@property (nonatomic , retain)UILabel *versionLab;

@property (nonatomic , retain)UIView *bottomLine;

@property (nonatomic , assign)BOOL isLast;

@end

NS_ASSUME_NONNULL_END
