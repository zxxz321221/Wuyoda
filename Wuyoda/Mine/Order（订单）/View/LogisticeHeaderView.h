//
//  LogisticeHeaderView.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/14.
//

#import <UIKit/UIKit.h>
#import "LogisticsModel.h"
#import "LogisticsNewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LogisticeHeaderView : UIView

@property (nonatomic  , retain)LogisticsModel *model;
@property (nonatomic  , retain)LogisticsNewModel *model2;

//1.普通 2.中华邮政
@property (nonatomic , copy)NSString *expressType;

@end

NS_ASSUME_NONNULL_END
