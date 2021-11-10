//
//  AddressInfoTableViewCell.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressInfoTableViewCell : UITableViewCell

@property (nonatomic , retain)UILabel *titleLab;

@property (nonatomic , retain)UITextField *infoTextField;

@property (nonatomic , retain)UIImageView *defaultImgV;

@property (nonatomic , retain)UILabel *defaultLab;

@property (nonatomic  , retain)UIImageView *arrowImgV;

@property (nonatomic , assign)BOOL is_buy;


@end

NS_ASSUME_NONNULL_END
