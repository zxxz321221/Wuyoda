//
//  AccountListTableViewCell.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AccountListTableViewCell : UITableViewCell

@property (nonatomic , retain)UIButton *deleteBtn;

@property (nonatomic , retain)UserInfoModel *model;

//1.账号； 2.添加账号
@property (nonatomic , copy)NSString *type;

@end

NS_ASSUME_NONNULL_END
