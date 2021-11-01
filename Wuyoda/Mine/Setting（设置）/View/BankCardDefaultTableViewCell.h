//
//  BankCardDefaultTableViewCell.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BankCardDefaultTableViewCell : UITableViewCell

@property (nonatomic , retain)UIImageView *selectImgV;

@property (nonatomic , retain)UILabel *titleLab;

@property (nonatomic , assign)BOOL isEdit;

@end

NS_ASSUME_NONNULL_END
