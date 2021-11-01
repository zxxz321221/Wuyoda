//
//  UserInfoTableViewCell.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoTableViewCell : UITableViewCell

@property (nonatomic , retain)UILabel *titleLab;

@property (nonatomic , retain)UITextField *infoTextField;

@property (nonatomic , retain)UIButton *manBtn;

@property (nonatomic , retain)UIButton *womenBtn;

@end

NS_ASSUME_NONNULL_END
