//
//  PayInfoTableViewCell.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/11/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PayInfoTableViewCellDelegate <NSObject>

//DEBIT_CARD银联，CREDIT_CARD信用卡
-(void)updatePayType:(NSString *)payType;

@end

@interface PayInfoTableViewCell : UITableViewCell

@property (nonatomic , retain)UILabel *titleLab;
@property (nonatomic , retain)UILabel *infoLab;
@property (nonatomic , retain)UIButton *yinlianBtn;
@property (nonatomic , retain)UIButton *xinYongkaBtn;
@property (nonatomic , retain)UITextField *infoTextField;
@property (nonatomic , retain)UIButton *yearBtn;
@property (nonatomic , retain)UIButton *monthBtn;
@property (nonatomic , retain)UILabel *yearLab;
@property (nonatomic , retain)UILabel *monthLab;
@property (nonatomic , retain)UIButton *getCodeBtn;

@property (nonatomic , weak)id <PayInfoTableViewCellDelegate>delegate;

@property (nonatomic , copy)NSString *payType;

@end

NS_ASSUME_NONNULL_END
