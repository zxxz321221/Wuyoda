//
//  ChangePasswordTableViewCell.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChangePasswordTableViewCell : UITableViewCell

@property (nonatomic , retain)UIView *bgView;

@property (nonatomic , retain)UILabel *titleLab;

@property (nonatomic , retain)UITextField *infoTextField;

@property (nonatomic , retain)UIButton *getCodeBtn;

@property (nonatomic , retain)UIButton *disAppearBtn;

@property (nonatomic , retain)UIView *bottomLine;

@property (nonatomic , assign)BOOL isLast;

@end

NS_ASSUME_NONNULL_END
