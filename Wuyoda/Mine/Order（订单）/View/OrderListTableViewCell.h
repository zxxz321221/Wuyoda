//
//  OrderListTableViewCell.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderListTableViewCell : UITableViewCell

@property (nonatomic , retain)UIButton *buyAgainBtn;

@property (nonatomic , retain)UIButton *payBtn;

@property (nonatomic , retain)UIButton *addressBtn;

@property (nonatomic , retain)UIButton *cancelBtn;

@property (nonatomic , retain)UIButton *doneTakeBtn;

@property (nonatomic , retain)UIButton *readLogisticsBtn;

@property (nonatomic , retain)UIButton *finishEvaluateBtn;

@property (nonatomic , retain)UIButton *deleteBtn;

//@property (nonatomic , retain)UIButton *evaluateBtn;

@property (nonatomic , copy)NSString *type;


@end

NS_ASSUME_NONNULL_END
